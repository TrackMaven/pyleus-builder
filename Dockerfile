FROM python:2.7.8

MAINTAINER Farhan Syed + Jon Evans

RUN apt-get update && apt-get install -y openjdk-7-jre-headless

RUN wget -q -O - http://mirrors.sonic.net/apache/storm/apache-storm-0.9.2-incubating/apache-storm-0.9.2-incubating.tar.gz | tar -xzf - -C /opt

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/
ENV STORM_HOME /opt/apache-storm-0.9.2-incubating

RUN groupadd storm \
    && useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm \
    && chown -R storm:storm $STORM_HOME \
    && mkdir /var/log/storm \
    && chown -R storm:storm /var/log/storm

RUN ln -s $STORM_HOME/bin/storm /usr/bin/storm

RUN ln -sv /usr/local/bin/python /usr/bin/python

ADD requirements.txt /opt/pyleus/requirements.txt
RUN pip install -r /opt/pyleus/requirements.txt

WORKDIR /topology

ENTRYPOINT ["pyleus", "-v"]

CMD ["--help"]
