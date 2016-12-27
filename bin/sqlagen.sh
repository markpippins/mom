clear
rm $M2/python/mildred/db/mysql/*.p*

mysql mildred  < $M2/db/mildred.sql
mysql mildred_action < $M2/db/action.sql
mysql mildred_introspection < $M2/db/introspection.sql
mysql scratch < $M2/db/scratch.sql

touch $M2/python/mildred/db/mysql/__init__.py
sqlacodegen mysql://root:steel@localhost/media > $M2/python/mildred/db/mysql/media.py
sqlacodegen mysql://root:steel@localhost/mildred > $M2/python/mildred/db/mysql/mildred.py
sqlacodegen mysql://root:steel@localhost/mildred_action > $M2/python/mildred/db/mysql/action.py
sqlacodegen mysql://root:steel@localhost/mildred_admin > $M2/python/mildred/db/mysql/admin.py
sqlacodegen mysql://root:steel@localhost/mildred_introspection > $M2/python/mildred/db/mysql/introspection.py
sqlacodegen mysql://root:steel@localhost/scratch > $M2/python/mildred/db/mysql/scratch.py
# cat $M2/python/mildred/db/mysql/*.pys