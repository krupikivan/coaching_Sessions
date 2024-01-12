FROM ruby:3.0.5

ENV RAILS_ENV development

RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev \
  && apt install -y nodejs postgresql-client

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install -y yarn


RUN gem install bundler -v 2.3.12

# Preinstall gems. This will ensure that Gem Cache wont drop on code change
WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN (bundle check || bundle install)

ENV APP_DIR /sessions
RUN mkdir ${APP_DIR}
WORKDIR ${APP_DIR}

COPY run.sh /run.sh
RUN chmod +x /run.sh

COPY . ${APP_DIR}

COPY Gemfile ${APP_DIR}/Gemfile
COPY Gemfile.lock ${APP_DIR}/Gemfile.lock

RUN bundle check || bundle install
RUN bundle exec rake app:update:bin

COPY . ${APP_DIR}

EXPOSE ${PORT}

CMD ["/run.sh"]