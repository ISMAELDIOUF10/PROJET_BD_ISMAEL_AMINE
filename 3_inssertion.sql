USE EcoVoya;


INSERT INTO Client (id_client, prenom_client, nom_client, email_client, telephone_client, pays_resident_client) VALUES
(1, 'Alice', 'Martin', 'alice.martin@gmail.com', '+33 612345678', 'France'),
(2, 'Ousmane', 'Diop', 'ousmane.diop@outlook.fr', '+221 771234567', 'Sénégal'),
(3, 'Clara', 'Lopez', 'clara.lopez@yahoo.fr', '+34 678901234', 'Espagne'),
(4, 'Luca', 'Bianchi', 'luca.bianchi@gmail.com', '+39 331223344', 'Italie'),
(5, 'Sophie', 'Dubois', 'sophie.dubois@hotmail.fr', '+33 699887766', 'France'),
(6, 'David', 'Nguyen', 'david.nguyen@efrei.net', '+33 677112233', 'France'),
(7, 'Fatou', 'Ba', 'fatou.ba@gmail.com', '+221 771234987', 'Sénégal'),
(8, 'Maya', 'Schneider', 'maya.schneider@protonmail.com', '+49 151224466', 'Allemagne'),
(9, 'Hugo', 'Fernandez', 'hugo.fernandez@live.com', '+34 612233445', 'Espagne'),
(10, 'Leila', 'Haddad', 'leila.haddad@gmail.com', '+212 612334455', 'Maroc');

INSERT INTO Partenaire (id_partenaire, nom_partenaire, type_partenaire, pays_operation) VALUES
(1, 'TerraNova', 'ONG', 'France'),
(2, 'EcoTravel Agency', 'Agence', 'Maroc'),
(3, 'Green Horizons', 'Association', 'Suisse'),
(4, 'SolidEarth', 'Entreprise locale', 'Sénégal'),
(5, 'BluePlanet', 'Collectif', 'Italie');

INSERT INTO Hebergement (id_hebergement, nom_hebergement, type_hebergement, capacite_max, niveau_eco, id_partenaire) VALUES
(1, 'Auberge du Soleil', 'Auberge', 20, 'Argent', 1),
(2, 'Gîte des Cimes', 'Gîte', 15, 'Or', 3),
(3, 'Maison Verte', 'Maison d’hôte', 10, 'Platinium', 2),
(4, 'Camping Naturel', 'Camping', 40, 'Bronze', 4),
(5, 'Hôtel EcoVista', 'Hôtel', 25, 'Or', 5);

INSERT INTO Voyage (id_voyage, nom_voyage, destination_voyage, date_debut, date_fin, prix_total_voyage, niveau_impact_ecologique) VALUES
(1, 'Découverte du Sénégal', 'Sénégal', '2025-01-15', '2025-01-25', 1200.00, 'moyen'),
(2, 'Randonnée écologique au Maroc', 'Maroc', '2025-02-10', '2025-02-20', 900.00, 'faible'),
(3, 'Séjour alpin solidaire', 'Suisse', '2025-03-01', '2025-03-10', 1500.00, 'élevé'),
(4, 'Circuit culturel en Italie', 'Italie', '2025-04-05', '2025-04-15', 1100.00, 'moyen'),
(5, 'Voyage vert au Portugal', 'Portugal', '2025-05-01', '2025-05-10', 950.00, 'faible'),
(6, 'Écotour solidaire au Maroc', 'Maroc', '2025-06-12', '2025-06-22', 1000.00, 'moyen'),
(7, 'Découverte de la faune suisse', 'Suisse', '2025-07-10', '2025-07-20', 1300.00, 'élevé'),
(8, 'Immersion culturelle au Sénégal', 'Sénégal', '2025-08-15', '2025-08-25', 1150.00, 'faible');

INSERT INTO Guide (id_guide, nom_guide, niveau_experience, langue_guide, region_affectation) VALUES
(1, 'Abdoulaye Sarr', 'Expérimenté', 'Français', 'Sénégal'),
(2, 'Maria Rossi', 'Intermédiaire', 'Italien', 'Italie'),
(3, 'Thomas Keller', 'Expérimenté', 'Allemand', 'Suisse'),
(4, 'Youssef Amrani', 'Intermédiaire', 'Arabe', 'Maroc'),
(5, 'Camille Martin', 'Débutant', 'Français', 'France'),
(6, 'Aisha Ndiaye', 'Expérimenté', 'Anglais', 'Sénégal');

INSERT INTO Activite (id_activite, id_voyage, nom_activite, type_activite) VALUES
(1, 1, 'Atelier d’artisanat local', 'Atelier'),
(2, 2, 'Randonnée dans l’Atlas', 'Randonnée'),
(3, 3, 'Observation des glaciers', 'Excursion'),
(4, 4, 'Visite du Colisée', 'Visite culturelle'),
(5, 5, 'Bénévolat dans un parc naturel', 'Bénévolat écologique'),
(6, 6, 'Balade dans le désert', 'Excursion'),
(7, 7, 'Photographie de la faune', 'Atelier'),
(8, 8, 'Cuisine traditionnelle', 'Atelier');

INSERT INTO Reservation (id_reservation, id_client, id_voyage, date_reservation, statut_reservation, nb_personne, reduction_applique) VALUES
(1, 1, 1, '2024-12-01', 'confirmée', 2, 5.00),
(2, 2, 2, '2024-12-05', 'confirmée', 1, 0.00),
(3, 3, 3, '2024-12-10', 'en attente', 4, 10.00),
(4, 4, 4, '2024-12-15', 'confirmée', 2, 0.00),
(5, 5, 5, '2024-12-20', 'annulée', 1, 0.00),
(6, 6, 6, '2024-12-25', 'confirmée', 3, 15.00),
(7, 7, 7, '2025-01-01', 'en attente', 2, 5.00),
(8, 8, 8, '2025-01-10', 'confirmée', 1, 0.00),
(9, 9, 1, '2025-01-15', 'confirmée', 2, 10.00),
(10, 10, 2, '2025-01-20', 'en attente', 1, 0.00);

INSERT INTO Paiement (id_paiement, id_reservation, montant_paiement, mode_paiement, date_paiement) VALUES
(1, 1, 1140.00, 'CB', '2024-12-02'),
(2, 2, 900.00, 'Virement', '2024-12-06'),
(3, 3, 5400.00, 'CB', '2024-12-12'),
(4, 4, 2200.00, 'Espèces', '2024-12-18'),
(5, 5, 0.00, 'Chèque', '2024-12-21'),
(6, 6, 2550.00, 'CB', '2024-12-26'),
(7, 7, 2470.00, 'Virement', '2025-01-02'),
(8, 8, 1150.00, 'CB', '2025-01-11'),
(9, 9, 2280.00, 'Espèces', '2025-01-17'),
(10, 10, 900.00, 'Virement', '2025-01-21');

INSERT INTO Proposer (id_voyage, id_hebergement) VALUES
(1, 1), (2, 3), (3, 2), (4, 5), (5, 4), (6, 3), (7, 2), (8, 1);

INSERT INTO Encadrer (id_guide, id_activite) VALUES
(1, 1), (4, 2), (3, 3), (2, 4), (5, 5), (4, 6), (3, 7), (6, 8);

INSERT INTO Collaborer (id_partenaire, id_guide) VALUES
(1, 1), (2, 4), (3, 3), (4, 6), (5, 2);

INSERT INTO Superviser (id_guide_superviseur, id_guide_supervise) VALUES
(1, 5), (3, 2), (4, 6);

INSERT INTO Recommander (id_client_parrain, id_client_filleul) VALUES
(1, 2), (2, 7), (3, 4), (5, 6), (8, 9);
