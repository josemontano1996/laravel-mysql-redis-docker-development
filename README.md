# laravel-mysql-redis-docker-development
This a docker file for a development docker environment, using MySQL, Laravel 11, Redis, Nodejs and pnpm.

Once the container is up and running migrations should be run using the command
```
docker exec -it <container-name> /bin/sh
``` 