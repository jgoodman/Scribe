-- Convert schema '/Users/jgoodman/repos/github/Scribe/bin/upgrade_db/../../dbicdh/_source/deploy/3/001-auto.yml' to '/Users/jgoodman/repos/github/Scribe/bin/upgrade_db/../../dbicdh/_source/deploy/4/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "place_project" (
  "place_project_id" serial NOT NULL,
  "place_id" integer NOT NULL,
  "project_id" integer NOT NULL,
  PRIMARY KEY ("place_project_id"),
  CONSTRAINT "place_project_place_id_project_id" UNIQUE ("place_id", "project_id")
);
CREATE INDEX "place_project_idx_place_id" on "place_project" ("place_id");
CREATE INDEX "place_project_idx_project_id" on "place_project" ("project_id");

;
ALTER TABLE "place_project" ADD CONSTRAINT "place_project_fk_place_id" FOREIGN KEY ("place_id")
  REFERENCES "place" ("place_id") DEFERRABLE;

;
ALTER TABLE "place_project" ADD CONSTRAINT "place_project_fk_project_id" FOREIGN KEY ("project_id")
  REFERENCES "project" ("project_id") DEFERRABLE;

;

COMMIT;

