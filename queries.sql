/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE escape_attempts <3 and neutered = true;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT (name, escape_attempts) FROM animals WHERE weight_kg > 10.50;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.40 AND 17.30;

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon%';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals
WHERE birthdate > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals
SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO SP1;
SELECT * FROM animals;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

BEGIN;
SELECT COUNT(*) FROM animals;
SELECT 
   COUNT(escape_attempts) 
FROM 
   animals
WHERE escape_attempts = '0';
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(*)
FROM animals
WHERE escape_attempts > 0
GROUP BY neutered;
SELECT
       MIN(weight_kg),
       MAX(weight_kg)
FROM animals
SELECT species,
       AVG(escape_attempts)
FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY species;

SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners
LEFT JOIN animals animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(animals.id) FROM species
LEFT JOIN animals animals ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name FROM animals
INNER JOIN species ON animals.species_id = species.id
INNER JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE animals.escape_attempts = '0' AND owners.full_name = 'Dean Winchester';

SELECT owners.full_name, COUNT(animals.id) FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id 
GROUP BY owners.full_name
ORDER BY count DESC
LIMIT 1;

SELECT a.name FROM visits v
JOIN animals a ON v.animals_id = a.id
JOIN vets v2 ON v.vets_id = v2.id
WHERE v2.name = 'William Tatcher'
ORDER BY v.date_of_visits DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animals_id) FROM visits v
JOIN vets v2 ON v.vets_id = v2.id
WHERE v2.name = 'Stephanie Mendez';

SELECT v.name, COALESCE(s.name, 'No Specialty') specialty FROM vets v
LEFT JOIN specializations sp ON v.id = sp.vets_id
LEFT JOIN species s ON sp.species_id = s.id;

SELECT a.name FROM visits v
JOIN animals a ON v.animals_id = a.id
JOIN vets v2 ON v.vets_id = v2.id
WHERE v2.name = 'Stephanie Mendez' AND v.date_of_visits BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name, COUNT(*) FROM visits v
JOIN animals a ON v.animals_id = a.id
GROUP BY a.name
ORDER BY count DESC
LIMIT 1;

SELECT v2.name, a.name, v.date_of_visits FROM visits v
JOIN vets v2 ON v.vets_id = v2.id
JOIN animals a ON v.animals_id = a.id
WHERE v2.name = 'Maisy Smith'
ORDER BY v.date_of_visits
LIMIT 1;

SELECT a.name, v2.name, v.date_of_visits FROM visits v
JOIN vets v2 ON v.vets_id = v2.id
JOIN animals a ON v.animals_id = a.id
ORDER BY v.date_of_visits DESC
LIMIT 1;

SELECT COUNT(*) FROM visits v
JOIN vets v2 ON v.vets_id = v2.id
JOIN animals a ON v.animals_id = a.id
LEFT JOIN specializations sp ON v2.id = sp.vets_id AND a.species_id = sp.species_id
WHERE sp.vets_id IS NULL;

SELECT s.name, COUNT(*) FROM visits v
JOIN animals a ON v.animals_id = a.id
JOIN species s ON a.species_id = s.id
JOIN vets v2 ON v.vets_id = v2.id
WHERE v2.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY count DESC
LIMIT 1;

