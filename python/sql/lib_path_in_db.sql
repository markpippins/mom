-- path_in_db: verify that path exists by pulling a row
-- params: index_name, asset_type, absolute_path
--
select id, absolute_path
  from asset
 where index_name = '%s'
   and asset_type = '%s'
   and absolute_path like '%s*' limit 1
