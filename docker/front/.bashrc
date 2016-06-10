#!/usr/bin/env bash

# Tests
alias test="php vendor/phpunit/phpunit/phpunit -c app --colors=always"
alias testblock="php vendor/phpunit/phpunit/phpunit -c app --colors=always --stop-on-failure --debug -v"
