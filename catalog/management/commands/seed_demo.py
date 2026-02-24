from django.core.management.base import BaseCommand
from django.core.files import File
from django.conf import settings
from pathlib import Path
from decimal import Decimal

from catalog.models import Product, Category, Manufacturer, Supplier, Unit

class Command(BaseCommand):
    help = "Создать демо-товары (10 шт.) и привязать картинки media/products/1.jpg..10.jpg"

    def handle(self, *args, **options):
        cat, _ = Category.objects.get_or_create(name="Бытовая химия")
        man, _ = Manufacturer.objects.get_or_create(name="Производитель 1")
        sup, _ = Supplier.objects.get_or_create(name="Поставщик 1")
        unit, _ = Unit.objects.get_or_create(name="шт")

        products_dir = Path(settings.MEDIA_ROOT) / "products"
        products_dir.mkdir(parents=True, exist_ok=True)

        created = 0
        for i in range(1, 11):
            article = f"A{i:03d}"
            p, is_new = Product.objects.get_or_create(
                article=article,
                defaults={
                    "name": f"Товар {i}",
                    "category": cat,
                    "description": f"Описание товара {i}",
                    "manufacturer": man,
                    "supplier": sup,
                    "unit": unit,
                    "price": Decimal("100.00") + i,
                    "discount_percent": Decimal("0.00") if i % 3 == 0 else Decimal("20.00") if i % 4 == 0 else Decimal("10.00"),
                    "stock_qty": 0 if i % 5 == 0 else 10 + i,
                }
            )
            if is_new:
                created += 1

            img_path = products_dir / f"{i}.jpg"
            if img_path.exists() and not p.image:
                with img_path.open("rb") as f:
                    p.image.save(f"{i}.jpg", File(f), save=True)

        self.stdout.write(self.style.SUCCESS(f"Готово. Создано новых товаров: {created}"))
