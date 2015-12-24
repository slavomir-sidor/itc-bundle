clean:
	#rm -rf composer.lock
	mkdir -p doc/phpunit
	mkdir -p doc/api
	# rm -rf vendor/
	composer clear


update:
	composer install
	composer dumpautoload --verbose --profile -o


install:


test:
	phpunit

cover:
	mkdi doc/phpunit
	phpunit --coverage-text --coverage-html=doc/phpunit

apidoc:
	mkdir -p doc/api
	apigen generate --title="ITC Bundle API" -d doc/api \
		-s src/ \
		-s tests