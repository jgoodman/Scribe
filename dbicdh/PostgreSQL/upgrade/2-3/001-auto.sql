-- Convert schema '/Users/jgoodman/repos/github/Scribe/bin/upgrade_db/../../dbicdh/_source/deploy/2/001-auto.yml' to '/Users/jgoodman/repos/github/Scribe/bin/upgrade_db/../../dbicdh/_source/deploy/3/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "character_project" (
  "character_project_id" serial NOT NULL,
  "character_id" integer NOT NULL,
  "project_id" integer NOT NULL,
  PRIMARY KEY ("character_project_id"),
  CONSTRAINT "character_project_character_id_project_id" UNIQUE ("character_id", "project_id")
);
CREATE INDEX "character_project_idx_character_id" on "character_project" ("character_id");
CREATE INDEX "character_project_idx_project_id" on "character_project" ("project_id");

;
ALTER TABLE "character_project" ADD CONSTRAINT "character_project_fk_character_id" FOREIGN KEY ("character_id")
  REFERENCES "character" ("character_id") DEFERRABLE;

;
ALTER TABLE "character_project" ADD CONSTRAINT "character_project_fk_project_id" FOREIGN KEY ("project_id")
  REFERENCES "project" ("project_id") DEFERRABLE;

;
ALTER TABLE scene DROP CONSTRAINT scene_fk_chapter_id;

;
ALTER TABLE scene ADD CONSTRAINT scene_fk_chapter_id FOREIGN KEY (chapter_id)
  REFERENCES chapter (chapter_id) ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;

COMMIT;

