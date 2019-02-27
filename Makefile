install:
	cp ./nginx/conf.d/redmine.conf.sample ./nginx/conf.d/redmine.conf
	cp ./redmine/config/configuration.yml.sample ./redmine/config/configuration.yml
	cp ./redmine/config/database.yml.sample ./redmine/config/database.yml
install_deps:
	apt-get -y install pv
fetch:
	cd $(path) && git fetch --all
addrepo:
	cd ./redmine/repos && git clone --mirror $(url) $(name)
	@echo "*/30 * * * *    cd $(PWD)/ && make fetch path=./redmine/repos/$(name) >> /tmp/cron.log" >> /var/spool/cron/crontabs/$(USER)
backup:
	@mkdir -p backups
	@tar czf - postgres/data/ redmine/ | pv > backups/`date +%Y%m%d%H%M%S`.tgz
	@echo 'Backup done'
restore:
	@make backup
	@test -s $(file) || { echo -e 'File "$(file)" not found'; exit 1; }
	@rm -rf postgres/data/ redmine/
	@tar xzf $(file) -C ./
	@echo 'Restored successful'
