FROM python:3.7 as builder

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Python, don't write bytecode!
ENV PYTHONDONTWRITEBYTECODE 1

RUN pip3 install pipenv

# -- Install Application into container:
RUN set -ex && mkdir /app

WORKDIR /app

# -- Adding Pipfiles
ONBUILD COPY Pipfile Pipfile
ONBUILD COPY Pipfile.lock Pipfile.lock

# -- Install dependencies:
ONBUILD RUN set -ex && pipenv install --deploy --system

# --------------------
# - Using This File: -
# --------------------
#
# FROM nlsnmedia/pipenv:python3 as build-pipenv
#
# FROM python:3.7-slim
#
# COPY --from build-pipenv /usr/local/lib/python3.7/site-packages/ /usr/local/lib/python3.7/site-packages
# COPY . /app

# -- Replace with the correct path to your app's main executable
# CMD python -m modulename
