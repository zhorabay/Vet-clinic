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
