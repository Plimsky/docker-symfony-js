#!/bin/bash
if [ "SYMFONY_ENV" -eq "test" ]
then
    php5enmod xdebug
fi

exec supervisord