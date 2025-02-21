include -custom.mk

WEBHOST:=xibera.com
WEBUSER:=$(USER)
WEBROOT:=/var/www/xibera

SRC := index.html favicon.ico style.css $(wildcard ./img/*)

all: $(SRC)
	rsync --dry-run -rvzP --delete $^ $(WEBUSER)@$(WEBHOST):$(WEBROOT) && \
		echo "If this looks correct use makle upload to upload."

upload: $(SRC)
	rsync -rvzP --delete $^ $(WEBHOST):$(WEBROOT)
	ssh $(WEBHOST) "chown -R $(WEBUSER):www-data /var/www/xibera/"
