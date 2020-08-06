ARG NGNIX_TAG=1.0.0

FROM alfresco/acs-community-ngnix:${NGNIX_TAG}

#Copy modified nginx.conf file which has latest port number updated.
COPY nginx.conf /etc/nginx/nginx.conf
