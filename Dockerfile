# Grab the latest alpine image
FROM alpine:latest

# Install python runtime
RUN apk --update add python py-pip py-django py-psycopg2 bash

# Install ImageMagick
RUN apk add imagemagick

# Install dependencies
ADD ./python-getting-started/requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip
RUN pip install -qr /tmp/requirements.txt

# Add our code
ADD ./python-getting-started /opt/webapp/
WORKDIR /opt/webapp

# Expose is NOT supported by Heroku.  $PORT should be read from environment
# EXPOSE 5000 		

# Run the app.  CMD is required to run on Heroku			
CMD gunicorn gettingstarted.wsgi --log-file -

