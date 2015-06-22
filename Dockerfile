FROM ruby:2.1.5
MAINTAINER Add Jam <yo@addjam.com>

WORKDIR /code
RUN apt-get update --fix-missing -yq

# Install nginx
RUN apt-get install -yq nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
EXPOSE 80
ADD deploy/nginx_vhost /etc/nginx/sites-enabled/add_jam

# JS Runtime
RUN apt-get install -yq nodejs

# Cache bundle
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /code

RUN jekyll build

CMD ["nginx"]