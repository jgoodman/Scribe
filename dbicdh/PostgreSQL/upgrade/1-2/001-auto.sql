-- Convert schema '/home/jgoodma2/github/Scribe/bin/upgrade_db/../../dbicdh/_source/deploy/1/001-auto.yml' to '/home/jgoodma2/github/Scribe/bin/upgrade_db/../../dbicdh/_source/deploy/2/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE scene ADD COLUMN summ_tasks text;

;

COMMIT;

