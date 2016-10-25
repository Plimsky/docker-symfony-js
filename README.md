# docker-symfony-js [WIP]
A docker compose structure file for Symfony project as API with front (Angular / anything else)

## Steps

- Checkout the project
- Install [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)
- Read the [Docker docs](https://docs.docker.com)
- There is several docker-compose files. The *.dev.yml and *.prod.yml determine the environnement.
  - `docker-compose -f docker-compose.dev.yml build` will pull images. Go take a :coffee: 
  - `-f docker-compose.dev.yml` determine the environmment simulation (for exemple SYMFONY_ENV will be setted to dev)
- When container are built you have to start them. There are 3 containers
  - Back - will contain your Symfony framework
  - Front - will contain your Angular or other front framework
  - Mysql - will contain dabases
  - Oh, to start them : `docker-compose -f docker-compose.dev.yml up -d` easy :stuck_out_tongue:
