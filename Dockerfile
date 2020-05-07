FROM ruby:2.7.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
apt-get update && apt-get install -y nodejs
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
RUN bundle install
COPY . /myapp

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]