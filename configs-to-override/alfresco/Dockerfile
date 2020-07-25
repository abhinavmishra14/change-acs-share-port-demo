FROM alfresco/alfresco-content-repository-community:6.2.1-A8

ARG TOMCAT_SERVER_PORT=7005
ARG TOMCAT_HTTP_PORT=7080
ARG TOMCAT_SSL_PORT=7443
ARG TOMCAT_AJP_PORT=7009
ARG TOMCAT_JPDA_PORT=7000

ARG TOMCAT_DIR=/usr/local/tomcat

#Change to root so that sed command can be executed
USER root

#Update port to 7080 from 8080, 7005 from 8005, 7443 from 8443, 7009 from 8009
RUN sed -i "s/<Server\ port=\"8005\"\ shutdown=\"SHUTDOWN\">/<Server\ port=\"$TOMCAT_SERVER_PORT\"\ shutdown=\"SHUTDOWN\">/g" $TOMCAT_DIR/conf/server.xml ; \
    sed -i "s/port=\"8080\"\ protocol=\"HTTP\/1.1\"/port=\"$TOMCAT_HTTP_PORT\"\ protocol=\"HTTP\/1.1\"/g" $TOMCAT_DIR/conf/server.xml ; \
	sed -i "s/\ <Connector\ port=\"8443\"/\ <Connector port=\"$TOMCAT_SSL_PORT\"/g" $TOMCAT_DIR/conf/server.xml ; \
	sed -i "s/\ <Connector\ port=\"8009\"\ protocol=\"AJP\/1.3\"/\  <Connector\ port=\"$TOMCAT_AJP_PORT\"\ protocol=\"AJP\/1.3\"\ /g" $TOMCAT_DIR/conf/server.xml ; \
	sed -i "s/redirectPort=\"8443\"/redirectPort=\"$TOMCAT_SSL_PORT\"/g" $TOMCAT_DIR/conf/server.xml ; 

RUN cat $TOMCAT_DIR/conf/server.xml

# For remote debug, Changes are also required to the docker-compose.yml file as well. Add CATALINA_OPTS, e.g: CATALINA_OPTS : "-agentlib:jdwp=transport=dt_socket,address=*:7000,server=y,suspend=n"
EXPOSE $TOMCAT_JPDA_PORT

#Change back to alfresco
USER alfresco


#Copy and override the alfresco-global.properties which comes with custom image. 
#It could be useful in cases when you already built a custom image but launch an container with some additional config in global properties.
COPY alfresco-global.properties $TOMCAT_DIR/shared/classes/alfresco-global.properties

#TODO:: Add more steps as needed


