ARG NGNIX_TAG

FROM alfresco/alfresco-acs-nginx:${NGNIX_TAG}

# Replace all 8080 ports to 7080. Not a good way to do but short term option.
# Ideally you should Clone: https://github.com/Alfresco/acs-ingress
# Make changes to https://github.com/Alfresco/acs-ingress/blob/master/entrypoint.sh
# Make changes to https://github.com/Alfresco/acs-ingress/blob/master/nginx.conf if needed
# Build custom image and use it.
# You can pass additional urls via environment variables. See: https://github.com/Alfresco/acs-ingress/blob/master/entrypoint.sh
RUN sed -i "s|\:8080|\:7080 |g" /etc/nginx/nginx.conf;
RUN sed -i "s|\:8080|\:7080 |g" entrypoint.sh;