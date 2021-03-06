FROM ubuntu:18.04

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app
COPY fclone .
RUN chmod +x fclone
RUN apt-get -qq update
COPY fclone /usr/src/app/gclone
RUN chmod +x gclone
RUN chmod +x /usr/src/app/gclone
RUN apt-get -qq install -y git python3 python3-pip \
    locales python3-lxml aria2 \
    curl pv jq nginx npm
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt && \
    apt-get -qq purge git
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
COPY . .
RUN chmod +x start.sh
RUN chmod +x gclone
RUN chmod +x fclone
CMD ["bash","start.sh"]
