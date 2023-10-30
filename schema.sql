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
  CONSTRAINT species_pkey PRIMARY KEY (id)
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

CREATE TABLE vets (
  id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
  name character(50),
  age integer,
  date_of_graduation date,
  CONSTRAINT vets_pkey PRIMARY KEY (id)
);

CREATE TABLE specializations (
    species_id integer,
    vets_id integer,
    CONSTRAINT species_id_fkey 
    FOREIGN KEY (species_id)
    REFERENCES public.species (id),
    CONSTRAINT vets_id_fkey 
    FOREIGN KEY (vets_id)
    REFERENCES public.vets (id) 
)

CREATE TABLE visits (
    animals_id integer,
    vets_id integer,
    date_of_visits date,
    CONSTRAINT animals_visit_fkey 
    FOREIGN KEY (animals_id)
    REFERENCES public.animals (id),
    CONSTRAINT vets_visit_fkey 
    FOREIGN KEY (vets_id)
    REFERENCES public.vets (id)
)

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

ALTER TABLE owners ALTER COLUMN age DROP NOT NULL;

CREATE INDEX idx_animals_id ON visits(animals_id);
CREATE INDEX idx_vets_id ON visits(vets_id);
CREATE INDEX idx_email ON owners(email);
