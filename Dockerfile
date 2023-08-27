FROM python:3.10

RUN apt-get clean

#create venv
RUN python -m venv /opt/venv

# Enable venv
ENV PATH="/opt/venv/bin:$PATH"

RUN apt-get update \
  && apt-get install -y  \
  && pip install --no-cache-dir --upgrade pip

ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

#Install requirements
COPY requirements.txt /app
RUN pip install --no-cache-dir --requirement /app/requirements.txt

COPY . /app

# Collect static files
RUN python manage.py collectstatic --no-input

CMD ["bash", "-c", "gunicorn --bind 0.0.0.0:8020 graphql_test.wsgi:application"]