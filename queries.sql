/*Queries that provide answers to the questions from all projects.*/

/*Find all animals whose name ends in "mon"*/
SELECT * FROM animals WHERE name LIKE '%mon';

/*list the name of all animals born between 2016 and 2019*/
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/*list the name of all animals that are neutered and have less than 3 escape
attemps */
SELECT name FROM animals WHERE neutered=true AND escape_attemps < 3;

/*list the date of birth of all animals named either "Agumon" or "Pikacho"*/
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';

/*list name and escape attemps of animals that weight more than 10.5g*/
SELECT name, escape_attemps FROM animals WHERE weight_kg > 10.5;

/*find all animals that are neutered*/
SELECT * FROM animals WHERE neutered = true;

/*find all animals not named Gabumon*/
SELECT * FROM animals WHERE name <> 'Gabumon';

/*find all animals with a weight between 10.4kg and 17.3kg(including 
the weights that equals precisely 10.4kg or 17.3kg)*/
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
