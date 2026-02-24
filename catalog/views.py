from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from django.db.models import Q
from .models import Product

def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username', '')
        password = request.POST.get('password', '')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('products')
        return render(request, 'catalog/login.html', {'error': 'Неверный логин или пароль'})
    return render(request, 'catalog/login.html')

def guest_view(request):
    request.session['guest'] = True
    return redirect('products')

def logout_view(request):
    logout(request)
    request.session.pop('guest', None)
    return redirect('login')

def product_list(request):
    is_guest = request.session.get('guest', False)
    user = request.user if request.user.is_authenticated else None

    # роль
    role = None
    full_name = ''
    if is_guest:
        role = 'guest'
        full_name = 'Гость'
    elif user:
        role = getattr(user, 'role', 'client')
        full_name = getattr(user, 'full_name', '') or user.get_full_name() or user.username

    qs = Product.objects.select_related('category', 'manufacturer', 'supplier', 'unit').all()

    can_advanced = (role in ['manager', 'admin'])

    search = request.GET.get('search', '').strip()
    category = request.GET.get('category', '').strip()
    sort = request.GET.get('sort', '').strip()

    if can_advanced:
        if search:
            qs = qs.filter(
                Q(name__icontains=search) |
                Q(article__icontains=search) |
                Q(description__icontains=search)
            )
        if category:
            qs = qs.filter(category__name=category)
        if sort == 'price_asc':
            qs = qs.order_by('price')
        elif sort == 'price_desc':
            qs = qs.order_by('-price')
        elif sort == 'discount_desc':
            qs = qs.order_by('-discount_percent')

    return render(request, 'catalog/products.html', {
        'products': qs,
        'role': role,
        'full_name': full_name,
        'can_advanced': can_advanced,
        'search': search,
        'category': category,
        'sort': sort,
    })