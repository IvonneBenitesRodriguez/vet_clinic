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

--First Transaction
BEGIN;

UPDATE animals
SET species = 'unspecified';

SELECT species from animals;
ROLLBACK;

SELECT species FROM animals;

--Transaction
/* Update the animals table by setting the species column to digimon
for all animals that have a name ending in mon */
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
SELECT * FROM animals

/*Update the animals table by setting the species column
to pokemon for all animals that do not have species already set*/
UPDATE animals
SET species='pokemon'
WHERE species IS NULL OR TRIM(species)='';

SELECT * FROM animals;

COMMIT;

SELECT * FROM animals;

/*delete all records in the animals table, then roll back the transaction */
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;

/*rolling back the transaction*/
ROLLBACK;
SELECT * FROM animals;

--Transaction
/*delete all animals born after Jan 1st, 2022*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

/*create a SavePoint for the transaction*/
SAVEPOINT SP1;
SELECT * FROM animals;

/* update all animals weight to be their weight multiplied by -1 */
UPDATE animals
SET weight_kg = weight_kg * -1;
SELECT * FROM animals;

/* rollback to the savepoint */
ROLLBACK to SP1;

/* update all animals weights that are negative to be their weight
multiplied by -1 */
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
SELECT * FROM animals;

/* commit transaction */
COMMIT;

--Queries
/* how many animals are there? */ 
SELECT count(*) FROM animals;

/* how many animals have never tried to escape? */
SELECT count(*) FROM animals WHERE escape_attemps = 0;

/* what is the average weight of animals */
SELECT AVG(weight_kg) FROM animals;

/* who escapes the most, neutered or not neutered animals */
SELECT neutered, MAX(escape_attemps) as "Maximum Escape Attempts"
FROM animals
GROUP BY neutered
HAVING MAX(escape_attemps) = (SELECT MAX(escape_attemps) FROM animals);

/*what is the minimum and maximum weight of each type of animal*/
SELECT species, MIN(weight_kg) AS "Minimum Weight", MAX(weight_kg) AS "Maximum Weight"
FROM animals
GROUP BY species;

/*what is the average number of escape attemps per animal type
of those born between 1990 and 2000 */
SELECT species, AVG(escape_attemps) AS "Average Escape Attempts"
 FROM animals
 WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
 GROUP BY species
 HAVING AVG(escape_attemps) IS NOT NULL;