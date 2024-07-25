# Creating Django Project and Core App from barest_bones branch:

## Create the Django Project:
```docker-compose run --rm app django-admin startproject app .```
Create the Core App:
```docker-compose run --rm app python manage.py startapp core```

## Run Migrations and Start the Server:
```docker-compose run --rm app python manage.py migrate```
```docker-compose up```

## Wait for Database Script:
To implement the wait_for_db command, create a management command:

## Create a management/commands directory inside your core app:
```mkdir -p app/core/management/commands```


## Create a wait_for_db.py script:
# app/core/management/commands/wait_for_db.py

```"""
django will auto detect this file as a management command because of the folder infrastructure

This command will wait for the database to be available before continuing to run the other commands.
"""

from django.core.management.base import BaseCommand
import time


class Command(BaseCommand):
    """built in command class and method to handle the command needs this structure"""
    help = 'Wait for database'

    def handle(self, *args, **options):
        self.stdout.write('Waiting for database...')
        db_up = False
        while not db_up:
            try:
                self.check(databases=['default'])
                db_up = True
            except Exception as e:
                self.stdout.write('Database unavailable, waiting 1 second...')
                self.stdout.write(str(e))
                time.sleep(1)
        self.stdout.write(self.style.SUCCESS('Database available!'))
```

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
