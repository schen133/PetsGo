LOAD DATA LOCAL INFILE 'shelter.csv' INTO TABLE Shelter
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (shelter_ID, type_of_shelter, street, city, state, zip);

LOAD DATA LOCAL INFILE 'medicalrecord.csv' INTO TABLE MedicalRecord
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (medical_record_ID, microchipped, vaccination_status, medical_conditions, date_of_last_visit, notes);

LOAD DATA LOCAL INFILE 'pastrecord.csv' INTO TABLE PastRecord
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (past_record_ID, start_date, end_date, description, outcome, related_animal_ID);

LOAD DATA LOCAL INFILE 'animal.csv' INTO TABLE Animal
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (animal_ID, medical_record_ID, shelter_ID, age, weight, species, name);

LOAD DATA LOCAL INFILE 'owner.csv' INTO TABLE Owner
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (owner_ID, past_record_ID, age, firstname, lastname, livingsituation, email, password);

LOAD DATA LOCAL INFILE 'adoptionrequest.csv' INTO TABLE AdoptionRequest
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (adoptionRequest_ID, animal_ID, owner_ID, request_date, request_status);

LOAD DATA LOCAL INFILE 'breed.csv' INTO TABLE Breed
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (animal_ID, breed, species, description);


LOAD DATA LOCAL INFILE 'surgeries.csv' INTO TABLE Surgeries
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (surgery_ID, medical_record_ID, surgery_date, surgery_type, surgeon_name, anesthesia_used, surgery_notes);

LOAD DATA LOCAL INFILE 'used_to_be_on.csv' INTO TABLE UsedToBeOn
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (past_record_ID, animal_ID, start_date, end_date, reason);

LOAD DATA LOCAL INFILE 'vaccinations.csv' INTO TABLE Vaccinations
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (vaccination_ID, medical_record_ID, vaccine_name, vaccine_brand, vaccination_date, next_due_date, administered_by);





  


