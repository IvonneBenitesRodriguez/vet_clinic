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

