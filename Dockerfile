FROM python:3.7-stretch

LABEL "maintainer"="Roald Nefs <info@roaldnefs.com>"
LABEL "repository"="https://github.com/roaldnefs/salt-lint-action"
LABEL "homepage"="https://github.com/roaldnefs/salt-lint-action"

# Update APT packages
RUN apt-get update && apt-get upgrade -y -o DPkg::Options::=--force-confold

# Upgrade The System
RUN apt-get update && apt-get upgrade -y -o DPkg::Options::=--force-confold

# Install Salt Dependencies
RUN apt-get install -y -o DPkg::Options::=--force-confold \
  python \
  apt-utils \
  software-properties-common \
  python-yaml \
  python-m2crypto \
  python-crypto \
  msgpack-python \
  python-zmq \
  python-jinja2 \
  python-requests

# Install salt-lint
RUN pip install salt-lint

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]