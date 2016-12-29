clear
rm $M2/python/mildred/db/generated/*.p*

mysql mildred  < $M2/db/mildred.sql
mysql mildred_action < $M2/db/action.sql
mysql mildred_introspection < $M2/db/introspection.sql
mysql scratch < $M2/db/scratch.sql

touch $M2/python/mildred/db/__init__.py
touch $M2/python/mildred/db/generated/__init__.py
sqlacodegen mysql://root:steel@localhost/media > $M2/python/mildred/db/generated/sqla_media.py
sqlacodegen mysql://root:steel@localhost/mildred > $M2/python/mildred/db/generated/sqla_mildred.py
sqlacodegen mysql://root:steel@localhost/mildred_action > $M2/python/mildred/db/generated/sqla_action.py
sqlacodegen mysql://root:steel@localhost/mildred_admin > $M2/python/mildred/db/generated/sqla_admin.py
sqlacodegen mysql://root:steel@localhost/mildred_introspection > $M2/python/mildred/db/generated/sqla_introspection.py
sqlacodegen mysql://root:steel@localhost/scratch > $M2/python/mildred/db/generated/sqla_scratch.py
# cat $M2/python/mildred/db/mysql/*.pys
