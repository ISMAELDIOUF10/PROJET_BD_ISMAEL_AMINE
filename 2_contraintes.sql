USE EcoVoya;

ALTER TABLE Client
    ADD CONSTRAINT chk_prenom_client CHECK (prenom_client <> ''),
    ADD CONSTRAINT chk_nom_client CHECK (nom_client <> ''),
    ADD CONSTRAINT chk_email_valide CHECK (email_client LIKE '%@%.%'),
    ADD CONSTRAINT chk_pays_resident_valide CHECK (pays_resident_client IN (
        'France','Espagne','Italie','Allemagne','Suisse','Portugal','Belgique',
        'Canada','Maroc','Sénégal','Tunisie','États-Unis','Royaume-Uni'
    ));

ALTER TABLE Voyage
    ADD CONSTRAINT chk_prix_positif CHECK (prix_total_voyage >= 0),
    ADD CONSTRAINT chk_dates_voyage_coherentes CHECK (date_debut < date_fin),
    ADD CONSTRAINT chk_impact_ecologique CHECK (niveau_impact_ecologique IN ('faible','moyen','élevé'));

ALTER TABLE Reservation
    ADD CONSTRAINT chk_nb_personnes_valide CHECK (nb_personne BETWEEN 1 AND 20),
    ADD CONSTRAINT chk_reduction_valide CHECK (reduction_applique BETWEEN 0 AND 100),
    ADD CONSTRAINT chk_statut_valide CHECK (statut_reservation IN ('confirmée','annulée','en attente')),
    ADD CONSTRAINT fk_client_reservation FOREIGN KEY (id_client)
        REFERENCES Client(id_client)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    ADD CONSTRAINT fk_voyage_reservation FOREIGN KEY (id_voyage)
        REFERENCES Voyage(id_voyage)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

ALTER TABLE Paiement
    ADD CONSTRAINT chk_montant_paiement CHECK (montant_paiement >= 0),
    ADD CONSTRAINT chk_mode_paiement CHECK (mode_paiement IN ('CB','Virement','Chèque','Espèces')),
    ADD CONSTRAINT fk_reservation_paiement FOREIGN KEY (id_reservation)
        REFERENCES Reservation(id_reservation)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

ALTER TABLE Partenaire
    ADD CONSTRAINT chk_nom_partenaire_non_vide CHECK (nom_partenaire <> ''),
    ADD CONSTRAINT chk_type_partenaire CHECK (type_partenaire IN (
        'ONG','Agence','Association','Collectif','Entreprise locale'
    )),
    ADD CONSTRAINT chk_pays_operation_valide CHECK (pays_operation <> '');

ALTER TABLE Hebergement
    ADD CONSTRAINT chk_nom_hebergement_non_vide CHECK (nom_hebergement <> ''),
    ADD CONSTRAINT chk_type_hebergement CHECK (type_hebergement IN (
        'Hôtel','Auberge','Gîte','Maison d’hôte','Camping'
    )),
    ADD CONSTRAINT chk_capacite_positif CHECK (capacite_max > 0),
    ADD CONSTRAINT chk_niveau_eco_valide CHECK (niveau_eco IN ('Bronze','Argent','Or','Platinium')),
    ADD CONSTRAINT fk_partenaire_hebergement FOREIGN KEY (id_partenaire)
        REFERENCES Partenaire(id_partenaire)
        ON DELETE SET NULL
        ON UPDATE CASCADE;

ALTER TABLE Activite
    ADD CONSTRAINT chk_nom_activite_non_vide CHECK (nom_activite <> ''),
    ADD CONSTRAINT chk_type_activite_valide CHECK (type_activite IN (
        'Randonnée','Atelier','Excursion','Visite culturelle','Bénévolat écologique','Observation'
    )),
    ADD CONSTRAINT fk_voyage_activite FOREIGN KEY (id_voyage)
        REFERENCES Voyage(id_voyage)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

ALTER TABLE Guide
    ADD CONSTRAINT chk_nom_guide_non_vide CHECK (nom_guide <> ''),
    ADD CONSTRAINT chk_experience_valide CHECK (niveau_experience IN ('Débutant','Intermédiaire','Expérimenté')),
    ADD CONSTRAINT chk_langue_guide_valide CHECK (langue_guide IN ('Français','Anglais','Espagnol','Arabe','Italien','Allemand')),
    ADD CONSTRAINT chk_region_non_vide CHECK (region_affectation <> '');

ALTER TABLE Superviser
    ADD CONSTRAINT fk_superviseur FOREIGN KEY (id_guide_superviseur)
        REFERENCES Guide(id_guide)
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_supervise FOREIGN KEY (id_guide_supervise)
        REFERENCES Guide(id_guide)
        ON DELETE CASCADE,
    ADD CONSTRAINT chk_supervision_valide CHECK (id_guide_superviseur <> id_guide_supervise);

ALTER TABLE Proposer
    ADD CONSTRAINT fk_voyage_proposer FOREIGN KEY (id_voyage)
        REFERENCES Voyage(id_voyage)
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_hebergement_proposer FOREIGN KEY (id_hebergement)
        REFERENCES Hebergement(id_hebergement)
        ON DELETE CASCADE;

ALTER TABLE Encadrer
    ADD CONSTRAINT fk_guide_encadrer FOREIGN KEY (id_guide)
        REFERENCES Guide(id_guide)
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_activite_encadrer FOREIGN KEY (id_activite)
        REFERENCES Activite(id_activite)
        ON DELETE CASCADE;

ALTER TABLE Collaborer
    ADD CONSTRAINT fk_partenaire_collaborer FOREIGN KEY (id_partenaire)
        REFERENCES Partenaire(id_partenaire)
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_guide_collaborer FOREIGN KEY (id_guide)
        REFERENCES Guide(id_guide)
        ON DELETE CASCADE;

ALTER TABLE Recommander
    ADD CONSTRAINT fk_parrain FOREIGN KEY (id_client_parrain)
        REFERENCES Client(id_client)
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_filleul FOREIGN KEY (id_client_filleul)
        REFERENCES Client(id_client)
        ON DELETE CASCADE,
    ADD CONSTRAINT chk_non_auto_recommandation CHECK (id_client_parrain <> id_client_filleul);
