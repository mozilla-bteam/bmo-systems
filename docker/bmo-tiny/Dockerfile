FROM perl:5.28.0-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        libssl1.0.2 libpangoft2-1.0-0 libatk1.0-0 \
        libexpat1 libfontconfig1 libglib2.0-0 libgd3 \
        libpangocairo-1.0-0 libmariadbclient18 \
        libgtk2.0-0 libgtk2.0-0 curl && \
    apt-get clean && \
    curl -L https://cpanmin.us > /usr/local/bin/cpanm && \
    curl -L https://github.com/dylanwh/tocotrienol/releases/download/1.0.6/tct-centos6.tar.xz > /usr/local/bin/tct.tar.xz && \
    tar -C /usr/local/bin -xvf /usr/local/bin/tct.tar.xz && \
    rm /usr/local/bin/tct.tar.xz && \
    chmod 755 /usr/local/bin/{cpanm,tct} && \
    useradd -u 10001 -U app -m && \
    mkdir /app

COPY bmo/ /opt/bmo/

RUN awk '{print $1}' < /app/LIBS.txt \
         | perl -nE 'chomp; unless (-f $_) { $missing++; say $_ } END { exit 1 if $missing }' && \
    chown -R app:app /app /opt/bmo
