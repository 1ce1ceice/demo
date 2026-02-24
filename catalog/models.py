from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    ROLE_CHOICES = [
        ('client', 'Клиент'),
        ('manager', 'Менеджер'),
        ('admin', 'Администратор'),
    ]
    role = models.CharField(max_length=20, choices=ROLE_CHOICES, default='client')
    full_name = models.CharField(max_length=255, blank=True)

class Category(models.Model):
    name = models.CharField(max_length=200)

    def __str__(self):
        return self.name

class Manufacturer(models.Model):
    name = models.CharField(max_length=200)

    def __str__(self):
        return self.name

class Supplier(models.Model):
    name = models.CharField(max_length=200)

    def __str__(self):
        return self.name

class Unit(models.Model):
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name

class Product(models.Model):
    article = models.CharField(max_length=50, unique=True)  # артикул
    name = models.CharField(max_length=255)
    category = models.ForeignKey(Category, on_delete=models.PROTECT)
    description = models.TextField(blank=True)

    manufacturer = models.ForeignKey(Manufacturer, on_delete=models.PROTECT)
    supplier = models.ForeignKey(Supplier, on_delete=models.PROTECT)
    unit = models.ForeignKey(Unit, on_delete=models.PROTECT)

    price = models.DecimalField(max_digits=12, decimal_places=2)
    discount_percent = models.DecimalField(max_digits=5, decimal_places=2, default=0)  # %
    stock_qty = models.IntegerField(default=0)

    image = models.ImageField(upload_to='products/', blank=True, null=True)

    def final_price(self):
        if self.discount_percent and self.discount_percent > 0:
            return self.price * (1 - (self.discount_percent / 100))
        return self.price

    def __str__(self):
        return f"{self.article} - {self.name}"