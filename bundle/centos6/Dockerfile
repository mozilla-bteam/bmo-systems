FROM centos:6.9
ENV NAME 'bmo'
ENV PATH '/build/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin'
ENV CIRCLE_JOB 'centos6'
WORKDIR /build
COPY . /build
RUN /build/bundle/centos6/install-rpms
RUN cp bundle/$CIRCLE_JOB/cpanfile* .
RUN build-prepare