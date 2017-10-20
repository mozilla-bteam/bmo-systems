FROM amazonlinux:latest
ENV PATH '/build/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin'
ENV NAME 'amazon'
ENV CIRCLE_JOB 'amazon'
WORKDIR /build
COPY . /build
RUN /build/bundle/amazon/install-rpms
RUN cp bundle/$CIRCLE_JOB/cpanfile* .
RUN build-prepare
RUN build-stage1
RUN build-stage2
RUN build-vendor-bundle $NAME
