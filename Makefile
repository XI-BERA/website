-include custom.mk

WEBHOST?=xibera.com
WEBUSER?=$(USER)
WEBROOT?=/var/www/xibera

SRC := index.html favicon.ico style.css

# Define file patterns
PATTERNS# Define file patterns

PATTERNS := *.html *.png *.jpg *.css

# Convert patterns into rsync --include options
INCLUDE_FLAGS := $(foreach pattern,$(PATTERNS),--include="$(pattern)")

# Define remote location
REMOTE := $(WEBUSER)@$(WENHOST):$(WEBROOT)

# Rsync rule
sync:
	rsync -av --include="*/" $(INCLUDE_FLAGS) --exclude="*" ./ $(REMOTE)

all: $(SRC) 
	rsync -rvzP --delete $^ $(WEBHOST):$(WEBROOT)
	ssh $(WEBHOST) "chown -R $(WEBUSER):www-data /var/www/xibera/"
	ssh $(WEBHOST) "chmod -R a+r /var/www/xibera/"
