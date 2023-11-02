/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name text,
    date_of_birth date,
    escape_attemps  INT,
    neutered boolean,
    weight_kg decimal
);
ALTER TABLE animals
ADD species text;