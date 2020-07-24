# change-acs-share-port-demo
This project is a demo on how to change the acs, share, prostgres and proxy ports in dockerized environment

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

`docker-compose -f ./docker-compose.yml logs --tail="all"`


For more commands visit this cheat sheet:

[Alfresco 6.x with SDK4.x and docker command cheatseet](https://javaworld-abhinav.blogspot.com/2019/11/alfresco-6x-with-sdk4x-and-docker.html)