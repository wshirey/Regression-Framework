FROM ruby:2.3.1

RUN apt-get update && apt-get install -y \
    xvfb \
    iceweasel

RUN mkdir /specs
VOLUME ["/specs", "/screenshots"]

RUN mkdir /dependencies

ADD Gemfile /dependencies/Gemfile
ADD Gemfile.lock /dependencies/Gemfile.lock
ADD geckodriver /dependencies/geckodriver

RUN cd /dependencies && bundle install
ENV PATH=$PATH:/dependencies

WORKDIR /specs
CMD xvfb-run rspec