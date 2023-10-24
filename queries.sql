/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN 2016-01-01 AND 2019-12-31;
SELECT name FROM animals WHERE escape_attempts <3 and neutered = true;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT (name, escape_attempts) FROM animals WHERE weight_kg > 10.50;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.40 AND 17.30;
