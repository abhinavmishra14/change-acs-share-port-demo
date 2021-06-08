# change-acs-share-port-demo
This project is a demo on how to change the acs, share, prostgres and proxy ports in dockerized environment

[Change ACS 7.x, Share 7.x, Proxy (nginx), Solr6 and DB (postgres) ports using docker-compose.yml and DockerFile](https://javaworld-abhinav.blogspot.com/2020/07/change-alfresco-share-proxy-and-db.html)

### To create the external volumes use following command:

`docker volume create <volumeName>`

### To purge the external volumes use following command:

`docker volume rm -f <volumeName>`

### To build use following command:

- To build the images, This command will ignore any images which are already built and no changes to DockerFile has been identified. It will use cache.

`docker-compose -f ./docker-compose.yml build`

- To build the images with no cache. It will force rebuild

`docker-compose -f ./docker-compose.yml build --no-cache`


### To launch containers use following command:

`docker-compose -f ./docker-compose.yml up`


### To build and launch containers use following command:

`docker-compose -f ./docker-compose.yml up --build`


### To shutdown use following command:

`docker-compose -f ./docker-compose.yml down`

### To tail logs use following command:

`docker-compose -f ./docker-compose.yml logs -f`


### You can use launcher.bat/launcher.sh script to build, start, stop, purge volumes and tail logs:

- For Windows:

`.\launcher.bat build`

`.\launcher.bat start`

`.\launcher.bat stop`

`.\launcher.bat purge`

`.\launcher.bat tail`


- For Linux:

`.\launcher.sh build`

`.\launcher.sh start`

`.\launcher.sh stop`

`.\launcher.sh purge`

`.\launcher.sh tail`

### For docker-compose version 3.x you can use launcher-dcv3.bat/launcher-dcv3.sh script to build, start, stop, purge volumes and tail logs:

- For Windows:

`.\launcher-dcv3.bat build`

`.\launcher-dcv3.bat start`

`.\launcher-dcv3.bat stop`

`.\launcher-dcv3.bat purge`

`.\launcher-dcv3.bat tail`


- For Linux:

`.\launcher-dcv3.sh build`

`.\launcher-dcv3.sh start`

`.\launcher-dcv3.sh stop`

`.\launcher-dcv3.sh purge`

`.\launcher-dcv3.sh tail`


For more commands visit this cheat sheet:

[Alfresco 6.x/7.x with SDK4.x and docker command cheatseet](https://javaworld-abhinav.blogspot.com/2019/11/alfresco-6x-with-sdk4x-and-docker.html)
