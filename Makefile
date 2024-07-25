# super user
# admin@zengineer.life
# pass@123

# Docker build command
docker-build:
	docker-compose build

docker-lint:
	docker-compose run --rm app sh -c "flake8"


# Creates app django project inside the app folder. Only needs to run once.
docker-create-django-project:
	docker-compose run --rm app sh -c "django-admin startproject app ."

docker-create-django-app:
	docker-compose run --rm app sh -c "python manage.py startapp $(name)"

docker-run:
	docker-compose up

docker-stop:
	docker-compose down

docker-makemigrations:
	docker-compose run --rm app sh -c "python manage.py makemigrations"

# apply migrations to the project
docker-migrate:
	docker-compose run --rm app sh -c "python manage.py wait_for_db && python manage.py migrate"

docker-create_superuser:
	docker-compose run --rm app sh -c "python manage.py createsuperuser"

docker-list-migrations:
	docker-compose run --rm app sh -c "python manage.py showmigrations"

clear-migrations:
	docker-compose run app python manage.py migrate --fake-initial --noinput
	find . -path "**/migrations/*.py" -not -name "__init__.py" -delete
	find . -path "**/migrations/*.pyc"  -delete

create-superuser:
	❯ docker-compose run --rm app sh -c "python manage.py createsuperuser"

docker-test:
	docker-compose run --rm app sh -c "python manage.py test --verbosity=2"
	# docker-compose run --rm app sh -c "python manage.py shell -i python -c \"import pytest; pytest.main(['-s', 'app/test_pytests'])\""
	# docker-compose run --rm app sh -c "python manage.py shell -i python -c \"import pytest; pytest.main(['-s', 'core/tests'])\""