# Creating Django Project and Core App from barest_bones branch:

## Create the Django Project:
```docker-compose run --rm app django-admin startproject app .```
Create the Core App:
```docker-compose run --rm app python manage.py startapp core```

## Run Migrations and Start the Server:
```docker-compose run --rm app python manage.py migrate```
```docker-compose up```

## Add the core app to INSTALLED_APPS in settings.py:
# app/settings.py

```
INSTALLED_APPS = [
    # Other apps...
    'core',
]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'HOST': os.environ.get('DB_HOST'),
        'NAME': os.environ.get('DB_NAME'),
        'USER': os.environ.get('DB_USER'),
        'PASSWORD': os.environ.get('DB_PASS'),
        'PORT': '3306',
    }
}```

** Summary
* Dockerfile: * Configured for a Django environment with MySQL dependencies.
*requirements.txt:* Lists the necessary dependencies including mysqlclient.
*Django Setup:* Created and ran the Django project and core app using Docker.
*wait_for_db.py:* Ensures the database is ready before running migrations and starting the server.
By following these steps, you should have a functional Docker-driven Django development environment using MySQL.
