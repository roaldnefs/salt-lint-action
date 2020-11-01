FROM python:3.8-buster

LABEL "maintainer"="Roald Nefs <info@roaldnefs.com>"
LABEL "repository"="https://github.com/roaldnefs/salt-lint-action"
LABEL "homepage"="https://github.com/roaldnefs/salt-lint-action"

# Update APT packages
RUN apt-get update && apt-get upgrade -y -o DPkg::Options::=--force-confold

# Install salt-lint
RUN pip install salt-lint

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
