-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Wed May  6 03:45:11 2015
-- 
--
-- Table: access_user
--
DROP TABLE access_user CASCADE;
CREATE TABLE access_user (
  access_user_id serial NOT NULL,
  name text NOT NULL,
  password text NOT NULL,
  email text,
  PRIMARY KEY (access_user_id),
  CONSTRAINT access_user_unique_key_name UNIQUE (name)
);

--
-- Table: character
--
DROP TABLE character CASCADE;
CREATE TABLE character (
  character_id serial NOT NULL,
  name text,
  PRIMARY KEY (character_id)
);

--
-- Table: goal
--
DROP TABLE goal CASCADE;
CREATE TABLE goal (
  goal_id serial NOT NULL,
  name text NOT NULL,
  PRIMARY KEY (goal_id)
);

--
-- Table: label
--
DROP TABLE label CASCADE;
CREATE TABLE label (
  label_id serial NOT NULL,
  name text NOT NULL,
  color text NOT NULL,
  PRIMARY KEY (label_id),
  CONSTRAINT label_unique_key_name UNIQUE (name)
);

--
-- Table: place
--
DROP TABLE place CASCADE;
CREATE TABLE place (
  place_id serial NOT NULL,
  name text,
  PRIMARY KEY (place_id)
);

--
-- Table: project_group
--
DROP TABLE project_group CASCADE;
CREATE TABLE project_group (
  group_id serial NOT NULL,
  name text NOT NULL,
  PRIMARY KEY (group_id)
);

--
-- Table: note
--
DROP TABLE note CASCADE;
CREATE TABLE note (
  note_id serial NOT NULL,
  name text,
  text text,
  label_id integer,
  weight integer,
  PRIMARY KEY (note_id)
);
CREATE INDEX note_idx_label_id on note (label_id);

--
-- Table: project
--
DROP TABLE project CASCADE;
CREATE TABLE project (
  project_id serial NOT NULL,
  name text NOT NULL,
  group_id integer,
  PRIMARY KEY (project_id)
);
CREATE INDEX project_idx_group_id on project (group_id);

--
-- Table: character_goal
--
DROP TABLE character_goal CASCADE;
CREATE TABLE character_goal (
  character_id integer NOT NULL,
  goal_id integer NOT NULL,
  CONSTRAINT character_goal_character_id_goal_id UNIQUE (character_id, goal_id)
);
CREATE INDEX character_goal_idx_character_id on character_goal (character_id);
CREATE INDEX character_goal_idx_goal_id on character_goal (goal_id);

--
-- Table: character_note
--
DROP TABLE character_note CASCADE;
CREATE TABLE character_note (
  character_id integer NOT NULL,
  note_id integer NOT NULL,
  CONSTRAINT character_note_character_id_note_id UNIQUE (character_id, note_id)
);
CREATE INDEX character_note_idx_character_id on character_note (character_id);
CREATE INDEX character_note_idx_note_id on character_note (note_id);

--
-- Foreign Key Definitions
--

ALTER TABLE note ADD CONSTRAINT note_fk_label_id FOREIGN KEY (label_id)
  REFERENCES label (label_id) DEFERRABLE;

ALTER TABLE project ADD CONSTRAINT project_fk_group_id FOREIGN KEY (group_id)
  REFERENCES project_group (group_id) DEFERRABLE;

ALTER TABLE character_goal ADD CONSTRAINT character_goal_fk_character_id FOREIGN KEY (character_id)
  REFERENCES character (character_id) DEFERRABLE;

ALTER TABLE character_goal ADD CONSTRAINT character_goal_fk_goal_id FOREIGN KEY (goal_id)
  REFERENCES goal (goal_id) DEFERRABLE;

ALTER TABLE character_note ADD CONSTRAINT character_note_fk_character_id FOREIGN KEY (character_id)
  REFERENCES character (character_id) DEFERRABLE;

ALTER TABLE character_note ADD CONSTRAINT character_note_fk_note_id FOREIGN KEY (note_id)
  REFERENCES note (note_id) DEFERRABLE;

