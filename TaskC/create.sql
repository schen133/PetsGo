DROP DATABASE IF EXISTS `petsgodb`;
CREATE DATABASE `petsgodb`; 
USE `petsgodb`;

CREATE TABLE `Shelter` (
	`shelter_ID` INT NOT NULL,
	`type_of_shelter` VARCHAR(50) NOT NULL,
	`street` VARCHAR(100) NOT NULL,
	`city` VARCHAR(50) NOT NULL,
	`state` VARCHAR(50) NOT NULL,
	`zip` VARCHAR(10) NOT NULL,
	PRIMARY KEY (`shelter_ID`)
);

CREATE TABLE `MedicalRecord` (
	`medical_record_ID` INT NOT NULL,
	`microchipped` BOOLEAN NOT NULL,
	`vaccination_status` VARCHAR(100), 
	`medical_conditions` VARCHAR(100),
	`date_of_last_visit` DATE,
	`notes` TEXT,
	PRIMARY KEY (`medical_record_ID`)
);

CREATE TABLE `PastRecord` (
	`past_record_ID` INT NOT NULL, 
	`start_date` DATE NOT NULL, 
	`end_date` DATE,
	`description` TEXT, 
	`outcome` VARCHAR(100), 
	`related_animal_ID` INT, 
	PRIMARY KEY (`past_record_ID`)
);

CREATE TABLE `Animal` (
	`animal_ID` INT NOT NULL AUTO_INCREMENT,
    `medical_record_ID` INT,
    `shelter_ID` INT,
    `age` INT NOT NULL,
	`weight` DECIMAL(10, 2) NOT NULL,
	`species` VARCHAR(50) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`animal_ID`),
	FOREIGN KEY (`medical_record_ID`) REFERENCES `MedicalRecord`(`medical_record_ID`),
	FOREIGN KEY (`shelter_ID`) REFERENCES `Shelter`(`shelter_ID`)
);

CREATE TABLE `Owner` (
	`owner_ID` INT NOT NULL,
	`past_record_ID` INT,
	`age` INT,
	`firstname` VARCHAR(50) NOT NULL,
	`lastname` VARCHAR(50) NOT NULL,
	`livingsituation` VARCHAR(50) NOT NULL,
	`email` VARCHAR(50) NOT NULL,
	`password` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`owner_ID`),
	FOREIGN KEY (`past_record_ID`) REFERENCES `PastRecord`(`past_record_ID`)
);

CREATE TABLE `AdoptionRequest` (
	`adoptionRequest_ID` INT NOT NULL,
	`animal_ID` INT NOT NULL, 
	`owner_ID` INT NOT NULL,
	`request_date` DATE NOT NULL, 
	`request_status` VARCHAR(50) NOT NULL, 
	PRIMARY KEY (`adoptionRequest_ID`),
	FOREIGN KEY (`animal_ID`) REFERENCES `Animal`(`animal_ID`),
	FOREIGN KEY (`owner_ID`) REFERENCES `owner`(`owner_ID`)
);

CREATE TABLE `Breed` (
	`animal_ID` INT NOT NULL, 
	`breed` VARCHAR(100) NOT NULL, 
	`species` VARCHAR(100),
	`description` VARCHAR(500),
	PRIMARY KEY (`animal_ID`, `breed`),
	FOREIGN KEY (`animal_ID`) REFERENCES `Animal`(`animal_ID`)
);


CREATE TABLE `Surgeries` (
	`surgery_ID` INT NOT NULL,
	`medical_record_ID` INT NOT NULL,
	`surgery_date` DATE NOT NULL, 
	`surgery_type` VARCHAR(100) NOT NULL, 
	`surgeon_name` VARCHAR(100),
	`anesthesia_used` VARCHAR(100),
	`surgery_notes` TEXT,
	PRIMARY KEY (`surgery_ID`),
	FOREIGN KEY (`medical_record_ID`) REFERENCES `MedicalRecord`(`medical_record_ID`)
);

CREATE TABLE `UsedToBeOn` (
	`past_record_ID` INT NOT NULL, 
	`animal_ID` INT NOT NULL, 
	`start_date` DATE, 
	`end_date` DATE, 
	`reason` TEXT,
    PRIMARY KEY (`past_record_ID`, `animal_ID`),
	FOREIGN KEY (`past_record_ID`) REFERENCES `PastRecord`(`past_record_ID`),
	FOREIGN KEY (`animal_ID`) REFERENCES `Animal`(`animal_ID`)
);

CREATE TABLE `Vaccinations` (
	`vaccination_ID` INT NOT NULL, 
	`medical_record_ID` INT NOT NULL, 
	`vaccine_name` VARCHAR(100) NOT NULL,
	`vaccine_brand` VARCHAR(100),
	`vaccination_date` DATE NOT NULL,
	`next_due_date` DATE,
	`administered_by` VARCHAR(100),
	PRIMARY KEY (`vaccination_ID`),
	FOREIGN KEY (`medical_record_ID`) REFERENCES `MedicalRecord`(`medical_record_ID`)
);

