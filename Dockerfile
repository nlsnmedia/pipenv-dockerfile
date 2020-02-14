FROM python:3.7 as builder

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Python, don't write bytecode!
ENV PYTHONDONTWRITEBYTECODE 1

ENV PATH="/pyroot/bin:${PATH}"

RUN PYTHONUSERBASE=/pyroot pip3 install --user pipenv

COPY bin /usr/local/bin

# -- Adding Pipfiles
ONBUILD COPY Pipfile Pipfile
ONBUILD COPY Pipfile.lock Pipfile.lock

ONBUILD ENV PATH="/pyroot/bin:${PATH}"
ONBUILD ENV PYTHONPATH="/pyroot/lib/python3.7/site-packages:${PYTHONPATH}"

ONBUILD RUN pipenv-install

# --------------------
# - Using This File: -
# --------------------
#
# FROM nlsnmedia/pipenv:python3 as build-pipenv
# RUN pipenv-install
#
# FROM python:3.7-slim
# RUN pipenv-install
#
# COPY --from build-pipenv /pyroot/lib/python3.7/site-packages/ /usr/local/lib/python3.7/site-packages
# COPY --from build-pipenv /pyroot/bin/ /usr/local/bin
# COPY . /app

# -- Replace with the correct path to your app's main executable
# CMD python -m modulename
