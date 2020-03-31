FROM postgres:latest

RUN localedef -i pt_BR -c -f ISO-8859-1 -A /usr/share/locale/locale.alias pt_BR.ISO-8859-1

RUN echo "listen_addresses='*'" >> $PGDATA/postgresql.conf

ENV LANG pt_BR.ISO-8859-1