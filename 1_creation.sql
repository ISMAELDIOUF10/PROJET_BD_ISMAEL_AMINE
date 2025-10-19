-- ==============================================
-- Base de données : EcoVoyage Solidaire
-- Auteurs : Ismaël DIOUF, Mohammed-AMINE
-- ==============================================

CREATE DATABASE IF NOT EXISTS EcoVoyageSolidaire;
USE EcoVoyageSolidaire;

-- ========================
-- Table CLIENT
-- ========================
CREATE TABLE Client (
    id_client INT PRIMARY KEY,
    prenom_client VARCHAR(30) NOT NULL,
    nom_client VARCHAR(30) NOT NULL,
    email_client VARCHAR(100) UNIQUE NOT NULL,
    telephone_client VARCHAR(15),
    pays_resident_client VARCHAR(50)
);

-- ========================
-- Table VOYAGE
-- ========================
CREATE TABLE Voyage (
    id_voyage INT PRIMARY KEY,
    destination_voyage VARCHAR(50) NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    prix_total_voyage DECIMAL(8,2) CHECK (prix_total_voyage >= 0),
    niveau_impact_ecologique VARCHAR(20)
);

-- ========================
-- Table RESERVATION
-- ========================
CREATE TABLE Reservation (
    id_reservation INT PRIMARY KEY,
    id_client INT NOT NULL,
    id_voyage INT NOT NULL,
    date_reservation DATE NOT NULL,
    statut_reservation VARCHAR(20) CHECK (statut_reservation IN ('confirmée', 'annulée', 'en attente')),
    nb_personne INT CHECK (nb_personne > 0),
    reduction_applique DECIMAL(4,2) DEFAULT 0,
    FOREIGN KEY (id_client) REFERENCES Client(id_client),
    FOREIGN KEY (id_voyage) REFERENCES Voyage(id_voyage)
);

-- ========================
-- Table PAIEMENT (association porteuse)
-- ========================
CREATE TABLE Paiement (
    id_paiement INT PRIMARY KEY,
    id_reservation INT NOT NULL,
    montant_paiement DECIMAL(8,2) CHECK (montant_paiement >= 0),
    mode_paiement VARCHAR(20),
    date_paiement DATE,
    FOREIGN KEY (id_reservation) REFERENCES Reservation(id_reservation)
);

-- ========================
-- Table ACTIVITE
-- ========================
CREATE TABLE Activite (
    id_activite INT PRIMARY KEY,
    id_voyage INT NOT NULL,
    nom_activite VARCHAR(50),
    type_activite VARCHAR(30),
    FOREIGN KEY (id_voyage) REFERENCES Voyage(id_voyage)
);

-- ========================
-- Table GUIDE
-- ========================
CREATE TABLE Guide (
    id_guide INT PRIMARY KEY,
    nom_guide VARCHAR(50) NOT NULL,
    niveau_experience VARCHAR(20),
    langue_guide VARCHAR(30)
);

-- ========================
-- Table SUPERVISER (récursive GUIDE)
-- ========================
CREATE TABLE Superviser (
    id_guide_superviseur INT,
    id_guide_supervise INT,
    PRIMARY KEY (id_guide_superviseur, id_guide_supervise),
    FOREIGN KEY (id_guide_superviseur) REFERENCES Guide(id_guide),
    FOREIGN KEY (id_guide_supervise) REFERENCES Guide(id_guide)
);

-- ========================
-- Table PARTENAIRE
-- ========================
CREATE TABLE Partenaire (
    id_partenaire INT PRIMARY KEY,
    nom_partenaire VARCHAR(50) NOT NULL,
    type_partenaire VARCHAR(30)
);

-- ========================
-- Table HEBERGEMENT
-- ========================
CREATE TABLE Hebergement (
    id_hebergement INT PRIMARY KEY,
    nom_hebergement VARCHAR(50),
    type_hebergement VARCHAR(30),
    capacite_max INT CHECK (capacite_max > 0),
    id_partenaire INT,
    FOREIGN KEY (id_partenaire) REFERENCES Partenaire(id_partenaire)
);

-- ========================
-- Table PROPOSER (Voyage <-> Hebergement)
-- ========================
CREATE TABLE Proposer (
    id_voyage INT,
    id_hebergement INT,
    PRIMARY KEY (id_voyage, id_hebergement),
    FOREIGN KEY (id_voyage) REFERENCES Voyage(id_voyage),
    FOREIGN KEY (id_hebergement) REFERENCES Hebergement(id_hebergement)
);

-- ========================
-- Table ENCADRER (Guide <-> Activite)
-- ========================
CREATE TABLE Encadrer (
    id_guide INT,
    id_activite INT,
    PRIMARY KEY (id_guide, id_activite),
    FOREIGN KEY (id_guide) REFERENCES Guide(id_guide),
    FOREIGN KEY (id_activite) REFERENCES Activite(id_activite)
);

-- ========================
-- Table COLLABORER (Partenaire <-> Guide)
-- ========================
CREATE TABLE Collaborer (
    id_partenaire INT,
    id_guide INT,
    PRIMARY KEY (id_partenaire, id_guide),
    FOREIGN KEY (id_partenaire) REFERENCES Partenaire(id_partenaire),
    FOREIGN KEY (id_guide) REFERENCES Guide(id_guide)
);

-- ========================
-- Table RECOMMANDER (récursive Client)
-- ========================
CREATE TABLE Recommander (
    id_client_parrain INT,
    id_client_filleul INT,
    PRIMARY KEY (id_client_parrain, id_client_filleul),
    FOREIGN KEY (id_client_parrain) REFERENCES Client(id_client),
    FOREIGN KEY (id_client_filleul) REFERENCES Client(id_client)
);
