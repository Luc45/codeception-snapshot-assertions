.PHONY: wp_dump cs_sniff cs_fix cs_fix_n_sniff phpstan

cs_sniff:
	vendor/bin/phpcs --colors -p --standard=PSR2 $(SRC) --ignore=src/data,src/includes,src/tad/scripts -s src

cs_fix:
	vendor/bin/phpcbf --colors -p --standard=PSR2 $(SRC) --ignore=src/data,src/includes,src/tad/scripts -s src tests

cs_fix_n_sniff: cs_fix cs_sniff

# Updates Composer dependencies using PHP 5.6.
composer_update: composer.lock
	docker run --rm -v ${CURDIR}:/app composer/composer:master-php5 update

# Runs phpstan on the source files.
phpstan:
	docker run --rm -v ${CURDIR}:/app phpstan/phpstan analyse -l 5 /app/src
