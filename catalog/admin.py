from django.contrib import admin
from .models import Product, Category, Manufacturer, Supplier, Unit, User

admin.site.register(User)
admin.site.register(Category)
admin.site.register(Manufacturer)
admin.site.register(Supplier)
admin.site.register(Unit)
admin.site.register(Product)