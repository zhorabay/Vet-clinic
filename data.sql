/* Populate database with sample data. */

INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Agumon', '03.02.2020', '0', true, '10.23');

INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES 	('Gabumon', '11.15.2018', '2', true, '8.00');

INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Pikachu', '01.07.2021', '1', false, '15.04');

INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Devimon', '05.12.2017', '5', true, '11.00');

INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Charmander', '2020-02-08', '0', false, '-11.00'),
	('Plantmon', '2021-11-15', '2', true, '-5.7'),
        ('Squirtle', '1993-04-02', '3', false, '-12.13'),
	('Angemon', '2005-06-12', '1', true, '-45.00'),
	('Boarmon', '2005-06-07', '7', true, '20.40'),
	('Blossom', '1998-10-13', '3', true, '17.00'),
	('Ditto', '2022-05-14', '4', true, '22.00');

INSERT INTO public.owners(
	full_name, age)
	VALUES ('Sam Smith', '34'),
	('Jennifer Orwell', '19'),
	('Bob', '45'),
	('Melody Pond', '77'),
	('Dean Winchester', '14'),
	('Jodie Whittaker', '38');

INSERT INTO public.species(
	name)
	VALUES ('Pokemon'),
	('Digimon);

UPDATE animals
SET species_id = species.id
FROM species
WHERE
    (animals.name LIKE '%mon%' AND species.name = 'Digimon')
    OR
    (animals.species_id IS NULL AND species.name = 'Pokemon');

SELECT * FROM animals;
	
UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE
    CASE
        WHEN animals.name = 'Agumon' THEN owners.full_name = 'Sam Smith'
        WHEN animals.name IN ('Gabumon', 'Pikachu') THEN owners.full_name = 'Jennifer Orwell'
        WHEN animals.name IN ('Devimon', 'Plantmon') THEN owners.full_name = 'Bob'
        WHEN animals.name IN ('Charmander', 'Squirtle', 'Blossom') THEN owners.full_name = 'Melody Pond'
        WHEN animals.name IN ('Angemon', 'Boarmon') THEN owners.full_name = 'Dean Winchester'
    END;
	
SELECT * FROM animals;
