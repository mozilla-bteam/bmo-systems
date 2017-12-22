FROM ubuntu:14.04
ENV NAME 'mozreview'
ENV PATH '/build/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin'
ENV CIRCLE_JOB 'ubuntu14'
WORKDIR /build
COPY . /build
RUN cp /build/bundle/ubuntu14/mysql.list /etc/apt/sources.list.d/mysql.list
RUN /build/bundle/ubuntu14/install-debs
RUN cp bundle/$CIRCLE_JOB/cpanfile* .
RUN build-prepare

ENV REPOSITORY https://github.com/mozilla-bteam/bmo.git
ENV BRANCH     master

ENTRYPOINT /build/entrypoint.sh
