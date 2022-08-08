ARG SHARE_TAG

FROM alfresco/alfresco-share:${SHARE_TAG}

ARG TOMCAT_SERVER_PORT=7005
ARG TOMCAT_HTTP_PORT=7080
ARG TOMCAT_SSL_PORT=7443
ARG TOMCAT_AJP_PORT=7009
ARG TOMCAT_JPDA_PORT=7000

ARG TOMCAT_DIR=/usr/local/tomcat

#Update port to 7080 from 8080, 7005 from 8005, 7443 from 8443, 7009 from 8009
RUN sed -i "s/<Server\ port=\"8005\"\ shutdown=\"SHUTDOWN\">/<Server\ port=\"$TOMCAT_SERVER_PORT\"\ shutdown=\"SHUTDOWN\">/g" $TOMCAT_DIR/conf/server.xml ; \
    sed -i "s/port=\"8080\"\ protocol=\"HTTP\/1.1\"/port=\"$TOMCAT_HTTP_PORT\"\ protocol=\"HTTP\/1.1\"/g" $TOMCAT_DIR/conf/server.xml ; \
	sed -i "s/\ <Connector\ port=\"8443\"/\ <Connector port=\"$TOMCAT_SSL_PORT\"/g" $TOMCAT_DIR/conf/server.xml ; \
	sed -i "s/\ <Connector\ port=\"8009\"\ protocol=\"AJP\/1.3\"/\  <Connector\ port=\"$TOMCAT_AJP_PORT\"\ protocol=\"AJP\/1.3\"\ /g" $TOMCAT_DIR/conf/server.xml ; \
	sed -i "s/redirectPort=\"8443\"/redirectPort=\"$TOMCAT_SSL_PORT\"/g" $TOMCAT_DIR/conf/server.xml ; 

#Disable resource caching
RUN sed -i "s|<Context>|<Context>\n<Resources cachingAllowed=\"false\"/> |g" $TOMCAT_DIR/conf/context.xml ;

#Fix for Admin tools user search issue (https://github.com/Alfresco/acs-community-packaging/issues/367)
RUN sed -i 's@<show-authorization-status>true</show-authorization-status>@<show-authorization-status>false</show-authorization-status>@' \
	$TOMCAT_DIR/shared/classes/alfresco/web-extension/share-config-custom.xml

# In base image it tries to write logs at root directory which requires 'root' user access.
RUN sed -i "s|log4j.appender.File.File\=share.log|log4j.appender.File.File\=logs/share.log |g" $TOMCAT_DIR/webapps/share/WEB-INF/classes/log4j.properties ;

# For remote debug, Changes are also required to the docker-compose.yml file as well. Add CATALINA_OPTS, e.g: CATALINA_OPTS : "-agentlib:jdwp=transport=dt_socket,address=*:7000,server=y,suspend=n"
EXPOSE $TOMCAT_JPDA_PORT

# Update session timeout config from default 60 minutes to 30 minutes:
RUN sed -i 's@<session-timeout>60</session-timeout>@<session-timeout>30</session-timeout>@' \
	$TOMCAT_DIR/webapps/share/WEB-INF/web.xml


# Copy add-ons jar module if there are any
COPY Dockerfile add-ons/*.jar $TOMCAT_DIR/webapps/share/WEB-INF/lib/

# Copy and apply amp add-ons
COPY Dockerfile add-ons/*.amp $TOMCAT_DIR/amps_share/
RUN java -jar $TOMCAT_DIR/alfresco-mmt/alfresco-mmt*.jar install \
              $TOMCAT_DIR/amps_share $TOMCAT_DIR/webapps/share -directory -nobackup -force
			  
# Create dirs for simple modules
RUN bash -c 'mkdir -pv $TOMCAT_DIR/modules/share'

#Setup simple module config
COPY simple-module-config/share.xml $TOMCAT_DIR/conf/Catalina/localhost/
#Copy simple modules if you have any
COPY simple-modules/* $TOMCAT_DIR/modules/share/
			  
#TODO:: Add more steps as needed