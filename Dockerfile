FROM rijalati/alpine-zulu-jdk8:latest
MAINTAINER rijalati@gmail.com

RUN apk update --no-cache \
    && apk add git tar mksh && git clone https://github.com/rijalati/oltpbench.git
WORKDIR /oltpbench
COPY my-templates/ /oltpbench/templates/
COPY config-templates/ /oltpbench/config-templates/
COPY start.sh /start.sh
COPY bench-confgen.sh bench-confgen.sh
COPY ntlmauth.dll /oltpbench/lib/
COPY ojdbc-get.sh ojdbc-get.sh
RUN chmod +x oltpbenchmark ojdbc-get.sh /start.sh
RUN git checkout update-deps && git fetch
RUN mvn clean && mvn package -P fixerrors


ENV DBFQDN='' DBUSER='' DBPASS='' DBTYPE='' DBNAME='' DBPORT='' BENCH='' MVN_PASS=''
ENV CLEARBOOL='' CREATEBOOL='' EXECBOOL='' LOADBOOL='' ORACLEMVN_USER='' ORACLEMVN_PASS=''

#ENTRYPOINT ["/start.sh"]
