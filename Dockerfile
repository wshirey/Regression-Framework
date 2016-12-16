FROM ruby:2.3.1

RUN apt-get update && apt-get install -y xvfb iceweasel
RUN apt-get install -y git
RUN gem install bundler

ADD . /app
RUN cd /app && bundle install
ENV PATH $PATH:/app

CMD while true; do sleep 1000; done

