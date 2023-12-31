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

INSERT INTO public.vets(
	name, age, date_of_graduation)
	VALUES ('William Tatcher', '45', '2000-04-23'),
	('Maisy Smith', '26', '2019-01-17'),
	('Stephanie Mendez', '64', '1981-05-04'),
	('Jack Harkness', '38', '2008-06-08');
SELECT * FROM vets;

INSERT INTO public.specializations(
	species_id, vets_id)
	VALUES
	((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'William Tatcher')),
	((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
	((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
	((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'));
SELECT * FROM specializations;

INSERT INTO public.visits(
	animals_id, vets_id, date_of_visits)
	VALUES 
	((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-05-24'),
	((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22'),
	((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-02'),
	((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05'),
	((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08'),
	((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14'),
	((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-05-04'),
	((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-24'),
	((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
	((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10'),
	((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07'),
	((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-09-29'),
	((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03'),
	((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-04'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03'),
	((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24'),
	((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');
SELECT * FROM visits;


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, date_of_visits) SELECT * FROM (SELECT id FROM animals) animals_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
