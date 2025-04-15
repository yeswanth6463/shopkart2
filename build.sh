set -o errexit

pip install -r requirements.txt

python manage.py collectstatic --noinput
python manage.py makemigrations
python manage.py migrate

# Run the Django app with gunicorn
gunicorn shopkart.wsgi:application --bind 0.0.0.0:8000

if [[$CREATE_SUPERUSER]];
then
python manage.py createsuperuser --no-input --email "$DJANGO_SUPERUSER_EMAIL" fi
