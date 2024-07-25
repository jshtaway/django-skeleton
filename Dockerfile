FROM python:3.9-alpine3.13
LABEL maintainer="https://github.com/jshtaway"

# print python output to the console
ENV PYTHONUNBUFFERED 1

COPY requirements.txt /tmp/requirements.txt
COPY requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app

EXPOSE 8080

ARG DEV=false

# create venv, update pip, install dependencies, remove tmp (to keep docker lightweight),
# create user so we're not operating in root for security
# install dev dependencies and give user own access if dev = true
# mysql-client: client package needed inside alpine image in order for
#   mysqlclient to connect to MySQL
# mysql-dev musl-dev --virtual: sets virtual dependency package to help install
#   needed packages, then you can remove them after installation (at the end of command)

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache mysql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        build-base mariadb-connector-c-dev musl-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt && \
        echo DEV=${DEV}; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user
