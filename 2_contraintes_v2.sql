-- ==============================================
-- Fichier : 2_contraintes.sql
-- Projet : EcoVoyage Solidaire
-- Auteurs : Ismaël DIOUF, Mohammed-AMINE
-- ==============================================

USE EcoVoyageSolidaire;

-- ========================
-- CLIENT
-- ========================
ALTER TABLE Client
ADD CONSTRAINT chk_nom_client CHECK (nom_client <> ''),
ADD CONSTRAINT chk_prenom_client CHECK (prenom_client <> ''),
ADD CONSTRAINT chk_tel_client CHECK (telephone_client REGEXP '^[0-9]+$'),
ADD CONSTRAINT chk_email_client CHECK (email_client LIKE '%@%.%'),
ADD CONSTRAINT chk_pays_client CHECK (pays_resident_client IS NOT NULL AND pays_resident_client <> '');

-- ========================
-- VOYAGE
-- ========================
ALTER TABLE Voyage
ADD CONSTRAINT chk_dates_voyage CHECK (date_debut < date_fin),
ADD CONSTRAINT chk_prix_voyage CHECK (prix_total_voyage >= 0),
ADD CONSTRAINT chk_impact_ecologique CHECK (niveau_impact_ecologique IN ('faible','moyen','élevé'));

-- ========================
-- RESERVATION
-- ========================
ALTER TABLE Reservation
ADD CONSTRAINT chk_nb_personne CHECK (nb_personne BETWEEN 1 AND 20),
ADD CONSTRAINT chk_reduction CHECK (reduction_applique BETWEEN 0 AND 100),
ADD CONSTRAINT chk_statut_reservation CHECK (statut_reservation IN ('confirmée','annulée','en attente'));

-- Cohérence temporelle entre réservation et voyage
-- (Remplacé par un trigger si nécessaire dans MySQL)

-- ========================
-- PAIEMENT
-- ========================
ALTER TABLE Paiement
ADD CONSTRAINT chk_montant_paiement CHECK (montant_paiement >= 0),
ADD CONSTRAINT chk_mode_paiement CHECK (mode_paiement IN ('CB','Virement','Chèque','Espèces'));

-- ========================
-- HEBERGEMENT
-- ========================
ALTER TABLE Hebergement
ADD CONSTRAINT chk_capacite CHECK (capacite_max > 0),
ADD CONSTRAINT chk_type_hebergement CHECK (type_hebergement IN ('Hôtel','Gîte','Auberge','Maison d’hôte'));

-- ========================
-- GUIDE
-- ========================
ALTER TABLE Guide
ADD CONSTRAINT chk_experience CHECK (niveau_experience IN ('Débutant','Intermédiaire','Expérimenté')),
ADD CONSTRAINT chk_langue_guide CHECK (langue_guide IS NOT NULL AND langue_guide <> '');

ALTER TABLE Superviser
ADD CONSTRAINT chk_superviser CHECK (id_guide_superviseur <> id_guide_supervise);

-- ========================
-- RECOMMANDER
-- ========================
ALTER TABLE Recommander
ADD CONSTRAINT chk_recommander CHECK (id_client_parrain <> id_client_filleul);

-- ========================
-- INTÉGRITÉ RÉFÉRENTIELLE
-- ========================
ALTER TABLE Reservation
ADD CONSTRAINT fk_resa_client FOREIGN KEY (id_client) REFERENCES Client(id_client) ON DELETE RESTRICT,
ADD CONSTRAINT fk_resa_voyage FOREIGN KEY (id_voyage) REFERENCES Voyage(id_voyage) ON DELETE RESTRICT;

ALTER TABLE Hebergement
ADD CONSTRAINT fk_hebergement_partenaire FOREIGN KEY (id_partenaire) REFERENCES Partenaire(id_partenaire) ON DELETE SET NULL;

ALTER TABLE Paiement
ADD CONSTRAINT fk_paiement_resa FOREIGN KEY (id_reservation) REFERENCES Reservation(id_reservation) ON DELETE CASCADE;

ALTER TABLE Activite
ADD CONSTRAINT fk_activite_voyage FOREIGN KEY (id_voyage) REFERENCES Voyage(id_voyage) ON DELETE CASCADE;

-- ========================
-- FIN DU FICHIER
-- ========================
