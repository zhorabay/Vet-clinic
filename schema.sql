/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name character(50),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg numeric,
    CONSTRAINT animals_pkey PRIMARY KEY (id)
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(50);

CREATE TABLE owners (
  id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
  full_name character(50),
  age integer,
  CONSTRAINT owners_pkey PRIMARY KEY (id)
);

CREATE TABLE species (
  id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
  name character(50),
  CONSTRAINT owners_pkey PRIMARY KEY (id)
);

ALTER TABLE animals
ADD PRIMARY KEY (id),
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD CONSTRAINT species_fkey
FOREIGN KEY (species_id)
REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD CONSTRAINT owners_fkey
FOREIGN KEY (owner_id)
REFERENCES owners(id);
