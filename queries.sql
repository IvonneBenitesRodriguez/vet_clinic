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
SET weight_kg = we



ight_kg * -1;
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

 /* Answers using JOIN */
 --what animals belong to Melody Pond?
 SELECT animals.name AS animal_name
 FROM animals
 JOIN owners ON animals.owner_id = owners.id
 WHERE owners.full_name = 'Melody Pond';

 /*list of all animals that are pokemon (their type is Pokemon)*/
SELECT animals.name AS animal_name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

/*list of all owners and their animals, include those that 
don't own any animal */
SELECT owners.full_name, animals.name AS animal_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

/* How many animals are there per species? */
SELECT species.name, COUNT(animals.id) AS total_animals
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

/* list all Digimon owned by Jennifer Orwell */
SELECT animals.name AS digimon_name
FROM animals 
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owners_id = owners_id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

/* list all animals owned by Dean Winchester that
have not tried to escape */
SELECT animals.name AS animal_name
FROM animals
JOIN owners ON animals.owner_id = owners_id
WHERE owners.full_name = 'Dean Winchester' AND 
animals.escape_attemps = 0;

/* who owns the most animals? */
SELECT owners.full_name, COUNT(animals.id) AS total_animals_owned
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY total_animals_owned DESC
LIMIT 1;

/* who was the last animal seen by William Tatcher? */
SELECT a.name AS animal_name
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vet ON v.vet_id = vet.id
WHERE vet.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

/* how many different animals did Stephanie Mendez see? */
SELECT COUNT(DISTINCT v.animal_id) AS animal_count
FROM visits v 
JOIN vets vet ON v.vet_id = vet.id
WHERE vet.name = 'Stephanie Mendez';

/* list all vets and their specialties, including vets 
with no specialties */
SELECT v.name AS vet_name, COALESCE(s.name, 'No Specialty') AS specialty
FROM vets v
LEFT JOIN specializations sp ON v.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;

/* list all animals that visited Stephanie Mendez between April 1st and
August 30th, 2020 */
SELECT a.name AS animal_name
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id 
WHERE vt.name = 'Stephanie Mendez'
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

/* what animal has the most visits to vet? */
SELECT a.name AS animal_name, COUNT(*) AS num_visits
FROM visits v 
JOIN animals a ON v.animal_id = a.id
GROUP BY a.name 
ORDER BY num_visits DESC 
LIMIT 1;

/* who was Maisy Smith 's first visit? */
SELECT a.name AS animal_name
FROM visits v
JOIN animals a ON v.animal_id = a.id 
JOIN vets vt ON v.vet_id = vt.id 
WHERE vt.name = 'Maisy Smith'
ORDER BY v.visit_date ASC
LIMIT 1;

/* details for most recent visit : animal information,
vet information, and date of visit */
SELECT a.name AS animal_name, vt.name AS vet_name, v.visit_date 
FROM visits v 
JOIN animals a ON v.animal_id = a.id 
JOIN vets vt ON v.vet_id = vt.id
ORDER BY v.visit_date DESC
LIMIT 1;

/* how many visits were with a vet that did not specialize 
in that animal's species? */
SELECT COUNT(*) AS num_visits_without_specialization
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.vet_id IS NULL;

/*what specialty should Maisy Smith consider getting ? look at the species 
she gets the most */
SELECT s.name AS specialty_name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
JOIN species s ON a.species_id = s.id
WHERE vt.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY COUNT(*) DESC
LIMIT 1;

/* project 5 */
SELECT COUNT(*) FROM visits where animal_id = 4;

SELECT * FROM visits where vet_id = 2;

SELECT * FROM owners where email = 'owner_18327@mail.com';

/* explain analyze on queries */
 EXPLAIN ANALYZE SELECT COUNT (*) FROM visits WHERE animal_id=4;

 EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;

 EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';

