from django.urls import path
from . import views

urlpatterns = [
    path('', views.login_view, name='login'),
    path('guest/', views.guest_view, name='guest'),
    path('products/', views.product_list, name='products'),
    path('logout/', views.logout_view, name='logout'),
]