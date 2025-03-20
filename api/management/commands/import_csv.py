import os
import pandas as pd
from django.core.management.base import BaseCommand
from api.models import WaterScan

class Command(BaseCommand):
    help = "Import water scan data from a CSV file"

    def handle(self, *args, **kwargs):
        csv_file_path = os.path.join(os.getcwd(), "water_data.csv")

        if not os.path.exists(csv_file_path):
            self.stdout.write(self.style.ERROR("❌ CSV file not found!"))
            return

        df = pd.read_csv(csv_file_path)
import pandas as pd
from api.models import WaterScan, User
import pandas as pd
from api.models import WaterScan

class Command(BaseCommand):
    help = 'Import data from CSV file'

    def add_arguments(self, parser):
        parser.add_argument('csv_file_path', type=str, help='Path to the CSV file')

    def handle(self, *args, **options):
        csv_file_path = options['csv_file_path']

        try:
            df = pd.read_csv(csv_file_path, encoding = 'latin1')

            for index, row in df.iterrows():
                WaterScan.objects.create(
                    user_id=1,  # Replace with a valid user ID or logic to find a user, also, make sure you do the migration
                    location="Lumistone", #Add the location you have for every row.
                    x_nad83=row['X_NAD831'],
                    y_nad83=row['Y_NAD831'],
                    predicted_water=0, #Change this column to 1 so water will be detected
                    depth = 35,
                )

            self.stdout.write(self.style.SUCCESS('Successfully imported data from CSV'))

        except Exception as e:
            self.stdout.write(self.style.ERROR(f'Error importing data: {e}'))

        for _, row in df.iterrows():
            WaterScan.objects.create(
                location=row['location'],
                x_nad83=row['x_nad83'],
                y_nad83=row['y_nad83'],
                predicted_water=row['predicted_water'],
                depth=row.get('depth', None),
                remarks=row.get('remarks', '')
            )

        self.stdout.write(self.style.SUCCESS("✅ Water scan data imported successfully!"))
