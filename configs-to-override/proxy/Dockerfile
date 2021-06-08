ARG NGNIX_TAG

FROM alfresco/alfresco-acs-nginx:${NGNIX_TAG}

#Copy modified nginx.conf file which has latest port number updated.
COPY nginx.conf /etc/nginx/nginx.conf
