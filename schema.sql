/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name text,
    date_of_birth date,
    escape_attemps  INT,
    neutered boolean,
    weight_kg decimal
);
ALTER TABLE animals ADD species VARCHAR(255);

/*create a table named owners*/
CREATE TABLE owners (
    id serial PRIMARY KEY,
    full_name varchar(255),
    age INT
);

/*create a table named species*/
CREATE TABLE species (
    id serial PRIMARY KEY,
    name varchar(255)
);

/* modify animals table */
/* remove column species */
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id);

ALTER TABLE animals
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners(id);

/* creating the table named vets */
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name varchar(100),
    age INT,
    date_of_graduation DATE
);

/* creating a join table called specializations */
CREATE TABLE specializations (
    vet_id INT REFERENCES vets(id),
    species_id INT REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);

/* creating a join table called visits */
CREATE TABLE visits (
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    visit_date DATE,
    PRIMARY KEY (animal_id, vet_id)
);

ALTER TABLE visits DROP CONSTRAINT visits_pkey;

ALTER TABLE visits ADD PRIMARY KEY (animal_id, vet_id, visit_date);

/* database performance audit */
-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

/* improving execution time strategies */
ANALYZE visits;

CREATE INDEX idx_animal_id ON visits (animal_id);

CREATE INDEX idx_vet_id ON visits (vet_id);

CREATE INDEX idx_email_id ON owners (email);
