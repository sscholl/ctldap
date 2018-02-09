FROM node
MAINTAINER Simon Scholl <s@sdscholl.de>

RUN useradd -ms /bin/bash ctldap
USER ctldap
RUN mkdir /home/ctldap/app
WORKDIR /home/ctldap/app

COPY app .
RUN npm install

EXPOSE 1389

ENV DEBUG false
ENV IS_DN_LOWER_CASE true
ENV LDAP_USER root
ENV LDAP_PW XXXXXXXXXXXXXXXXXXXX
ENV LDAP_PORT 1389
ENV LDAP_BASE_DN churchtools
ENV CT_URI https://mysite.church.tools/
ENV CT_USER XXXXXXXXXXXXXXXXXXXX
ENV CT_PW XXXXXXXXXXXXXXXXXXXX
ENV CACHE_LIVETIME 10000

#CMD [ "node", "ctldap.js" ]
CMD cp ctldap.example.config ctldap.config && \
    sed -i "s/^\(debug\s*=\s*\).*\$/\1$DEBUG/" ctldap.config && \
    sed -i "s/^\(dn_lower_case\s*=\s*\).*\$/\1$IS_DN_LOWER_CASE/" ctldap.config && \
    sed -i "s/^\(ldap_user\s*=\s*\).*\$/\1$LDAP_USER/" ctldap.config && \
    sed -i "s/^\(ldap_password\s*=\s*\).*\$/\1$LDAP_PW/" ctldap.config && \
    sed -i "s/^\(ldap_port\s*=\s*\).*\$/\1$LDAP_PORT/" ctldap.config && \
    sed -i "s/^\(ldap_base_dn\s*=\s*\).*\$/\1$LDAP_BASE_DN/" ctldap.config && \
    sed -i "s#^\(ct_uri\s*=\s*\).*\$#\1$CT_URI#" ctldap.config && \
    sed -i "s/^\(api_user\s*=\s*\).*\$/\1$CT_USER/" ctldap.config && \
    sed -i "s/^\(api_password\s*=\s*\).*\$/\1$CT_PW/" ctldap.config && \
    sed -i "s/^\(cache_lifetime\s*=\s*\).*\$/\1$CACHE_LIVETIME/" ctldap.config && \
    node ctldap.js

