#!/bin/bash

source /etc/apache2/envvars
chgrp www-data bob/data/logs/
chgrp www-data bob/data/cache/
chgrp www-data bob/migrations/build/
echo "127.0.0.1    alice.dev" >> /etc/hosts
echo "127.0.0.1    bob.dev" >> /etc/hosts
exec apache2 -D FOREGROUND