-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Wed Mar 16 03:48:08 2016
-- 
;
--
-- Table: access_user
--
CREATE TABLE "access_user" (
  "access_user_id" serial NOT NULL,
  "name" text NOT NULL,
  "password" text NOT NULL,
  "email" text,
  PRIMARY KEY ("access_user_id"),
  CONSTRAINT "access_user_unique_key_name" UNIQUE ("name")
);

;
--
-- Table: character
--
CREATE TABLE "character" (
  "character_id" serial NOT NULL,
  "name" text,
  PRIMARY KEY ("character_id")
);

;
--
-- Table: document
--
CREATE TABLE "document" (
  "document_id" serial NOT NULL,
  "name" text,
  "url_address" text NOT NULL,
  PRIMARY KEY ("document_id"),
  CONSTRAINT "document__unique_key__url_address" UNIQUE ("url_address")
);

;
--
-- Table: goal
--
CREATE TABLE "goal" (
  "goal_id" serial NOT NULL,
  "name" text NOT NULL,
  PRIMARY KEY ("goal_id")
);

;
--
-- Table: label
--
CREATE TABLE "label" (
  "label_id" serial NOT NULL,
  "name" text NOT NULL,
  "color" text NOT NULL,
  PRIMARY KEY ("label_id"),
  CONSTRAINT "label__unique_key__name" UNIQUE ("name")
);

;
--
-- Table: place
--
CREATE TABLE "place" (
  "place_id" serial NOT NULL,
  "name" text,
  "parent_place_id" integer,
  PRIMARY KEY ("place_id")
);

;
--
-- Table: project_group
--
CREATE TABLE "project_group" (
  "group_id" serial NOT NULL,
  "name" text NOT NULL,
  PRIMARY KEY ("group_id")
);

;
--
-- Table: character_meta
--
CREATE TABLE "character_meta" (
  "meta_id" serial NOT NULL,
  "character_id" integer NOT NULL,
  "key" text,
  "value" text,
  PRIMARY KEY ("meta_id")
);
CREATE INDEX "character_meta_idx_character_id" on "character_meta" ("character_id");

;
--
-- Table: place_meta
--
CREATE TABLE "place_meta" (
  "meta_id" serial NOT NULL,
  "place_id" integer NOT NULL,
  "key" text,
  "value" text,
  PRIMARY KEY ("meta_id")
);
CREATE INDEX "place_meta_idx_place_id" on "place_meta" ("place_id");

;
--
-- Table: project
--
CREATE TABLE "project" (
  "project_id" serial NOT NULL,
  "number" integer,
  "name" text NOT NULL,
  "group_id" integer,
  PRIMARY KEY ("project_id")
);
CREATE INDEX "project_idx_group_id" on "project" ("group_id");

;
--
-- Table: chapter
--
CREATE TABLE "chapter" (
  "chapter_id" serial NOT NULL,
  "number" integer NOT NULL,
  "name" text,
  "project_id" integer NOT NULL,
  PRIMARY KEY ("chapter_id")
);
CREATE INDEX "chapter_idx_project_id" on "chapter" ("project_id");

;
--
-- Table: character_goal
--
CREATE TABLE "character_goal" (
  "character_id" integer NOT NULL,
  "goal_id" integer NOT NULL,
  CONSTRAINT "character_goal_character_id_goal_id" UNIQUE ("character_id", "goal_id")
);
CREATE INDEX "character_goal_idx_character_id" on "character_goal" ("character_id");
CREATE INDEX "character_goal_idx_goal_id" on "character_goal" ("goal_id");

;
--
-- Table: note
--
CREATE TABLE "note" (
  "note_id" serial NOT NULL,
  "name" text,
  "text" text,
  "label_id" integer,
  "weight" integer,
  "document_id" integer,
  PRIMARY KEY ("note_id")
);
CREATE INDEX "note_idx_document_id" on "note" ("document_id");
CREATE INDEX "note_idx_label_id" on "note" ("label_id");

;
--
-- Table: character_note
--
CREATE TABLE "character_note" (
  "character_id" integer NOT NULL,
  "note_id" integer NOT NULL,
  CONSTRAINT "character_note_character_id_note_id" UNIQUE ("character_id", "note_id")
);
CREATE INDEX "character_note_idx_character_id" on "character_note" ("character_id");
CREATE INDEX "character_note_idx_note_id" on "character_note" ("note_id");

;
--
-- Table: goal_note
--
CREATE TABLE "goal_note" (
  "goal_id" integer NOT NULL,
  "note_id" integer NOT NULL,
  CONSTRAINT "goal_note_goal_id_note_id" UNIQUE ("goal_id", "note_id")
);
CREATE INDEX "goal_note_idx_goal_id" on "goal_note" ("goal_id");
CREATE INDEX "goal_note_idx_note_id" on "goal_note" ("note_id");

;
--
-- Table: place_note
--
CREATE TABLE "place_note" (
  "place_id" integer NOT NULL,
  "note_id" integer NOT NULL,
  CONSTRAINT "place_note_place_id_note_id" UNIQUE ("place_id", "note_id")
);
CREATE INDEX "place_note_idx_note_id" on "place_note" ("note_id");
CREATE INDEX "place_note_idx_place_id" on "place_note" ("place_id");

;
--
-- Table: scene
--
CREATE TABLE "scene" (
  "scene_id" serial NOT NULL,
  "name" text,
  "summary" text,
  "weight" integer,
  "label_id" integer,
  "document_id" integer,
  "chapter_id" integer,
  "place_id" integer,
  PRIMARY KEY ("scene_id")
);
CREATE INDEX "scene_idx_chapter_id" on "scene" ("chapter_id");
CREATE INDEX "scene_idx_document_id" on "scene" ("document_id");
CREATE INDEX "scene_idx_label_id" on "scene" ("label_id");
CREATE INDEX "scene_idx_place_id" on "scene" ("place_id");

;
--
-- Table: character_scene
--
CREATE TABLE "character_scene" (
  "character_scene_id" serial NOT NULL,
  "character_id" integer NOT NULL,
  "scene_id" integer NOT NULL,
  PRIMARY KEY ("character_scene_id"),
  CONSTRAINT "character_scene_character_id_scene_id" UNIQUE ("character_id", "scene_id")
);
CREATE INDEX "character_scene_idx_character_id" on "character_scene" ("character_id");
CREATE INDEX "character_scene_idx_scene_id" on "character_scene" ("scene_id");

;
--
-- Table: task
--
CREATE TABLE "task" (
  "task_id" serial NOT NULL,
  "name" text,
  "summary" text,
  "weight" integer,
  "label_id" integer,
  "scene_id" integer,
  "character_id" integer,
  PRIMARY KEY ("task_id")
);
CREATE INDEX "task_idx_character_id" on "task" ("character_id");
CREATE INDEX "task_idx_label_id" on "task" ("label_id");
CREATE INDEX "task_idx_scene_id" on "task" ("scene_id");

;
--
-- Foreign Key Definitions
--

;
ALTER TABLE "character_meta" ADD CONSTRAINT "character_meta_fk_character_id" FOREIGN KEY ("character_id")
  REFERENCES "character" ("character_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "place_meta" ADD CONSTRAINT "place_meta_fk_place_id" FOREIGN KEY ("place_id")
  REFERENCES "place" ("place_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "project" ADD CONSTRAINT "project_fk_group_id" FOREIGN KEY ("group_id")
  REFERENCES "project_group" ("group_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "chapter" ADD CONSTRAINT "chapter_fk_project_id" FOREIGN KEY ("project_id")
  REFERENCES "project" ("project_id") DEFERRABLE;

;
ALTER TABLE "character_goal" ADD CONSTRAINT "character_goal_fk_character_id" FOREIGN KEY ("character_id")
  REFERENCES "character" ("character_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "character_goal" ADD CONSTRAINT "character_goal_fk_goal_id" FOREIGN KEY ("goal_id")
  REFERENCES "goal" ("goal_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "note" ADD CONSTRAINT "note_fk_document_id" FOREIGN KEY ("document_id")
  REFERENCES "document" ("document_id") DEFERRABLE;

;
ALTER TABLE "note" ADD CONSTRAINT "note_fk_label_id" FOREIGN KEY ("label_id")
  REFERENCES "label" ("label_id") DEFERRABLE;

;
ALTER TABLE "character_note" ADD CONSTRAINT "character_note_fk_character_id" FOREIGN KEY ("character_id")
  REFERENCES "character" ("character_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "character_note" ADD CONSTRAINT "character_note_fk_note_id" FOREIGN KEY ("note_id")
  REFERENCES "note" ("note_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "goal_note" ADD CONSTRAINT "goal_note_fk_goal_id" FOREIGN KEY ("goal_id")
  REFERENCES "goal" ("goal_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "goal_note" ADD CONSTRAINT "goal_note_fk_note_id" FOREIGN KEY ("note_id")
  REFERENCES "note" ("note_id") DEFERRABLE;

;
ALTER TABLE "place_note" ADD CONSTRAINT "place_note_fk_note_id" FOREIGN KEY ("note_id")
  REFERENCES "note" ("note_id") DEFERRABLE;

;
ALTER TABLE "place_note" ADD CONSTRAINT "place_note_fk_place_id" FOREIGN KEY ("place_id")
  REFERENCES "place" ("place_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "scene" ADD CONSTRAINT "scene_fk_chapter_id" FOREIGN KEY ("chapter_id")
  REFERENCES "chapter" ("chapter_id") DEFERRABLE;

;
ALTER TABLE "scene" ADD CONSTRAINT "scene_fk_document_id" FOREIGN KEY ("document_id")
  REFERENCES "document" ("document_id") DEFERRABLE;

;
ALTER TABLE "scene" ADD CONSTRAINT "scene_fk_label_id" FOREIGN KEY ("label_id")
  REFERENCES "label" ("label_id") DEFERRABLE;

;
ALTER TABLE "scene" ADD CONSTRAINT "scene_fk_place_id" FOREIGN KEY ("place_id")
  REFERENCES "place" ("place_id") DEFERRABLE;

;
ALTER TABLE "character_scene" ADD CONSTRAINT "character_scene_fk_character_id" FOREIGN KEY ("character_id")
  REFERENCES "character" ("character_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "character_scene" ADD CONSTRAINT "character_scene_fk_scene_id" FOREIGN KEY ("scene_id")
  REFERENCES "scene" ("scene_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "task" ADD CONSTRAINT "task_fk_character_id" FOREIGN KEY ("character_id")
  REFERENCES "character" ("character_id") DEFERRABLE;

;
ALTER TABLE "task" ADD CONSTRAINT "task_fk_label_id" FOREIGN KEY ("label_id")
  REFERENCES "label" ("label_id") DEFERRABLE;

;
ALTER TABLE "task" ADD CONSTRAINT "task_fk_scene_id" FOREIGN KEY ("scene_id")
  REFERENCES "scene" ("scene_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
