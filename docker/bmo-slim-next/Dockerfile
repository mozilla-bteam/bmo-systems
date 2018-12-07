FROM centos:7.6.1810
MAINTAINER Dylan William Hardison <dylan@mozilla.com>

RUN yum update -y && \
    yum install -y centos-release-scl && \
    yum install -y perl perl-core \
                        wget tar openssl mysql mysql-libs gd \
                        openssh sclo-git25-git nc patchutils \
                        patch graphviz xz && \
    curl -L https://cpanmin.us > /usr/local/bin/cpanm && \
    curl -L https://github.com/dylanwh/tocotrienol/releases/download/1.0.6/tct-centos6.tar.xz > /usr/local/bin/tct.tar.xz && \
    tar -C /usr/local/bin -xvf /usr/local/bin/tct.tar.xz && \
    rm /usr/local/bin/tct.tar.xz && \
    chmod 755 /usr/local/bin/{cpanm,tct} && \
    mkdir -p /opt/bmo/build && \
    rpm -qa > /tmp/rpms.list && \
    yum install -y gcc && \
    yum erase -y $(rpm -qa | diff -u - /tmp/rpms.list | sed -n '/^-[^-]/ s/^-//p') && \
    rm -rf /opt/bmo/build/lib/perl5/{CPAN,Parse,JSON,ExtUtils} && \
    mkdir /usr/local/share/perl5 && \
    mv /opt/bmo/build/lib/perl5/x86_64-linux-thread-multi/ /usr/local/lib64/perl5/ && \
    mv /opt/bmo/build/lib/perl5/Linux /usr/local/share/perl5/ && \
    rm -vfr /opt/bmo/build && \
    rm /tmp/rpms.list /usr/local/bin/cpanm && \
    yum clean all -y && \
    useradd -u 10001 -U app -m && \
    mkdir /app

ENV PATH=/opt/rh/sclo-git25/root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY bmo/ /opt/bmo/

RUN awk '{print $1}' < /app/LIBS.txt \
         | perl -nE 'chomp; unless (-f $_) { $missing++; say $_ } END { exit 1 if $missing }' && \
    chown -R app:app /app /opt/bmo
