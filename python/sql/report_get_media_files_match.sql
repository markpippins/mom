-- get_matches: get match_record documents for a supplied asset path
-- params: index_name, absolute_path
--
SELECT es.id, es.absolute_path FROM document es
 WHERE index_name = '%s'
   and es.absolute_path LIKE '%s*'
   and es.id IN (SELECT doc_id FROM match_record)
 ORDER BY es.absolute_path
