FROM ruby:2.3.1

RUN apt-get update && apt-get install -y xvfb iceweasel
RUN apt-get install -y git
RUN gem install bundler

RUN rm /usr/bin/firefox
RUN ln -s /usr/bin/xvfb-firefox /usr/bin/firefox

ADD . /app
RUN cd /app && bundle install
ENV PATH $PATH:/app

CMD while true; do sleep 1000; done

