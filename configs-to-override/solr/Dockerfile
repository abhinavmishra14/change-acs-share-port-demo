ARG ASS_TAG

FROM alfresco/alfresco-search-services:${ASS_TAG}

#To disable content indexing
RUN sed -i '/^bash.*/i sed -i "'"/alfresco.index.transformContent/s/^#//g"'" ${DIST_DIR}/solrhome/templates/rerank/conf/solrcore.properties\n' \
${DIST_DIR}/solr/bin/search_config_setup.sh;


#To disable metadata indexing
#RUN sed -i '/^bash.*/i sed -i "'"/alfresco.ignore.datatype.1/s/^#//g"'" ${DIST_DIR}/solrhome/templates/rerank/conf/solrcore.properties\n' \
#${DIST_DIR}/solr/bin/search_config_setup.sh;


#Copy modified log4j.properties to logs directory in solr container
COPY log4j.properties ./logs/log4j.properties
