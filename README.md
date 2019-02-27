## Description

* postgres - PostgreSQL server
* redmine - Redmine server
* nginx - nginx web-server

## Installation

### Install system requirements
1. install [docker](https://docs.docker.com/engine/installation/)
2. install [docker-compose](https://docs.docker.com/compose/install/)

### Setup config files
```bash
$ cd redmine
$ make install_deps
$ make install
```

## Path

### Configure
- redmine/config/configuration.yml - main redmine config file
- redmine/config/database.yml - redmine database config file
- nginx/conf.d/ - config files for nginx (redmine.conf)

### Data
- postgres/data - database files
- redmine/files - uploaded files
- redmine/plugins - plugins
- redmine/repos - repositories
- redmine/themes - themes
- nginx/ssl/ - put your ssl certificates here, **required for https**

## Usage

### Run
```bash
$ docker-compose up -d
```

### Add repository
```bash
$ make addrepo name={REPO_NAME} url={REPO_URL}
```
This command creates mirror of repo and add line to crontab file for fetching changes every 30 minutes

### Fetch git repository
```bash
$ make fetch path=redmine/repos/REPO_NAME
```

### Backup
```bash
$ make backup
```
This command creates tar.gzip file in **backups/** folder with name **%Y%m%d%H%M%S.tgz**, where:

* %Y - year
* %m - month
* %d - day
* %H - hours
* %M - minutes
* %S - seconds

i.e. **20160919220651.tgz**

### Restore
```bash
$ make restore file=backups/20160906123510.tgz
```
> !!! be careful, restoration can delete all your files and databases

> honesty, for safety restore command makes backup first
