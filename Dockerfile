FROM ubuntu
# MAINTAINER Apurv Jain
RUN apt update && apt install -y mysql-server \
    libmysqlclient-dev \
    python3 \
    python3-pip \
    git \
    pkg-config
# Cloning the repo
RUN git clone https://github.com/ustream/homework
# Setting up the workdir
WORKDIR /homework
# copying the shell script to workdir
COPY mysql_secure.sh . 
COPY add_mysql_user.sh .
# Installing the dependencies
RUN pip3 install Werkzeug==2.2.2 \
    && pip3 install -r requirements.txt
# Copying the env file
COPY .env .
EXPOSE 6000
EXPOSE 3306
CMD  service mysql start && sh mysql_secure.sh && sh add_mysql_user.sh  && python3 countapp/init_database.py  && gunicorn --bind 0.0.0.0:6000 --chdir countapp countapp.wsgi:app --reload --timeout=900
