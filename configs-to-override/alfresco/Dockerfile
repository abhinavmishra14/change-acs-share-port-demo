ARG ACS_TAG

FROM alfresco/alfresco-content-repository-community:${ACS_TAG}

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

#Disable resource caching
RUN sed -i "s|<Context>|<Context>\n<Resources cachingAllowed=\"false\"/> |g" $TOMCAT_DIR/conf/context.xml ;

# For remote debug, Changes are also required to the docker-compose.yml file as well. Add CATALINA_OPTS, e.g: CATALINA_OPTS : "-agentlib:jdwp=transport=dt_socket,address=*:7000,server=y,suspend=n"
EXPOSE $TOMCAT_JPDA_PORT

# Copy add-ons jar module if there are any
COPY Dockerfile add-ons/*.jar $TOMCAT_DIR/webapps/alfresco/WEB-INF/lib/

# Copy and apply amp add-ons
COPY Dockerfile add-ons/*.amp $TOMCAT_DIR/amps/
RUN java -jar $TOMCAT_DIR/alfresco-mmt/alfresco-mmt*.jar install \
              $TOMCAT_DIR/amps $TOMCAT_DIR/webapps/alfresco -directory -nobackup -force
			  
# In base image it tries to write logs at root directory which requires 'root' user access while alfresco is running as 'alfresco' user hence can't write the logs and you would notice access denied error in console logs for this reason.
# To overcome this issue, we need to change the default log4j.properties located at: "/usr/local/tomcat/webapps/alfresco/WEB-INF/classes/log4j.properties"
RUN sed -i "s|log4j.appender.File.File\=alfresco.log|log4j.appender.File.File\=logs/alfresco.log |g" $TOMCAT_DIR/webapps/alfresco/WEB-INF/classes/log4j.properties ;
			 
# Create dirs for simple modules
RUN bash -c 'mkdir -pv $TOMCAT_DIR/modules/platform'

#Change back to alfresco
USER alfresco

#Setup simple module config
COPY simple-module-config/alfresco.xml $TOMCAT_DIR/conf/Catalina/localhost/
#Copy simple modules if you have any
COPY simple-modules/* $TOMCAT_DIR/modules/platform/

#Copy and override the alfresco-global.properties which comes with custom image. 
#It could be useful in cases when you already built a custom image but launch an container with some additional config in global properties.
COPY alfresco-global.properties $TOMCAT_DIR/shared/classes/alfresco-global.properties

#Copy custom log4j
COPY dev-log4j.properties $TOMCAT_DIR/shared/classes/alfresco/extension

#TODO:: Add more steps as needed


