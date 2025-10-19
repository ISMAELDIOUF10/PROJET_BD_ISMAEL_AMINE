-- ==============================================
-- 3_insertion.sql
-- Projet : EcoVoyage Solidaire
-- Auteurs : Ismaël DIOUF, Mohammed-AMINE
-- ==============================================

-- ===== PROMPT UTILISÉ =====
/*
Tu es un générateur de données réalistes pour une base de données de tourisme solidaire.
Les tables concernées sont : Client, Voyage, Réservation, Paiement, Activité, Guide, Hébergement et Partenaire.
Les données doivent être cohérentes : 
- Un client fait plusieurs réservations,
- Les voyages ont des prix réalistes et des dates valides,
- Les paiements correspondent à des réservations existantes,
- Les guides ont différents niveaux d’expérience et langues,
- Les hébergements appartiennent à des partenaires locaux.
Génère environ 15 lignes par table.
*/

-- ===== DONNÉES GÉNÉRÉES =====
-- Table CLIENT

INSERT INTO Client VALUES (1, 'Hugo', 'Diouf', 'client1@mail.com', '0673186982', 'Allemagne');
INSERT INTO Client VALUES (2, 'Lea', 'Bernard', 'client2@mail.com', '0654995645', 'Maroc');
INSERT INTO Client VALUES (3, 'Manon', 'Gauthier', 'client3@mail.com', '0688992082', 'Canada');
INSERT INTO Client VALUES (4, 'Noah', 'Martin', 'client4@mail.com', '0670428587', 'Espagne');
INSERT INTO Client VALUES (5, 'Lucas', 'Diouf', 'client5@mail.com', '0644237818', 'Espagne');
INSERT INTO Client VALUES (6, 'Nina', 'Lefevre', 'client6@mail.com', '0671211116', 'Canada');
INSERT INTO Client VALUES (7, 'Amine', 'Lefevre', 'client7@mail.com', '0661647460', 'Suisse');
INSERT INTO Client VALUES (8, 'Emma', 'Lefevre', 'client8@mail.com', '0623329411', 'Suisse');
INSERT INTO Client VALUES (9, 'Nina', 'Dubois', 'client9@mail.com', '0645612329', 'Maroc');
INSERT INTO Client VALUES (10, 'Emma', 'Rousseau', 'client10@mail.com', '0620249761', 'Canada');


-- Table PARTENAIRE

INSERT INTO Partenaire VALUES (1, 'ONG Horizon Vert', 'ONG');
INSERT INTO Partenaire VALUES (2, 'Agence Solidaire', 'Agence');
INSERT INTO Partenaire VALUES (3, 'EcoTerre', 'Association');
INSERT INTO Partenaire VALUES (4, 'Voyage Durable', 'Collectif');
INSERT INTO Partenaire VALUES (5, 'GreenStep', 'Entreprise locale');


-- Table VOYAGE

INSERT INTO Voyage VALUES (1, 'Reykjavik', '2025-06-19', '2025-06-29', 962.88, 'faible');
INSERT INTO Voyage VALUES (2, 'Tokyo', '2025-04-01', '2025-04-08', 2032.6, 'élevé');
INSERT INTO Voyage VALUES (3, 'Dakar', '2025-05-13', '2025-05-25', 2494.4, 'moyen');
INSERT INTO Voyage VALUES (4, 'Athènes', '2025-06-06', '2025-06-19', 1547.53, 'moyen');
INSERT INTO Voyage VALUES (5, 'Kathmandu', '2025-06-05', '2025-06-11', 2412.59, 'élevé');
INSERT INTO Voyage VALUES (6, 'Marrakech', '2025-01-06', '2025-01-21', 822.72, 'faible');
INSERT INTO Voyage VALUES (7, 'Bali', '2025-01-17', '2025-01-22', 1251.86, 'élevé');
INSERT INTO Voyage VALUES (8, 'Lisbonne', '2025-03-08', '2025-03-14', 889.86, 'faible');
INSERT INTO Voyage VALUES (9, 'Kathmandu', '2025-02-16', '2025-03-02', 1795.77, 'faible');
INSERT INTO Voyage VALUES (10, 'Dakar', '2025-05-05', '2025-05-20', 1000.3, 'moyen');
INSERT INTO Voyage VALUES (11, 'Bali', '2025-06-14', '2025-06-24', 2259.06, 'faible');
INSERT INTO Voyage VALUES (12, 'Lisbonne', '2025-04-15', '2025-04-30', 1032.03, 'moyen');
INSERT INTO Voyage VALUES (13, 'Rome', '2025-03-02', '2025-03-13', 2365.04, 'faible');
INSERT INTO Voyage VALUES (14, 'Tokyo', '2025-05-01', '2025-05-10', 2473.46, 'élevé');
INSERT INTO Voyage VALUES (15, 'Athènes', '2025-06-18', '2025-07-01', 2726.66, 'élevé');


-- Table RESERVATION

INSERT INTO Reservation VALUES (1, 10, 9, '2024-12-13', 'annulée', 4, 3.77);
INSERT INTO Reservation VALUES (2, 15, 6, '2024-10-04', 'annulée', 5, 19.25);
INSERT INTO Reservation VALUES (3, 15, 2, '2024-11-08', 'en attente', 2, 7.77);
INSERT INTO Reservation VALUES (4, 9, 3, '2024-11-12', 'annulée', 3, 15.35);
INSERT INTO Reservation VALUES (5, 7, 11, '2024-10-05', 'confirmée', 2, 19.68);
INSERT INTO Reservation VALUES (6, 9, 2, '2024-12-26', 'annulée', 3, 8.31);
INSERT INTO Reservation VALUES (7, 2, 5, '2024-10-05', 'confirmée', 3, 11.37);
INSERT INTO Reservation VALUES (8, 10, 2, '2024-10-02', 'confirmée', 1, 2.72);
INSERT INTO Reservation VALUES (9, 14, 5, '2024-11-14', 'confirmée', 5, 8.91);
INSERT INTO Reservation VALUES (10, 1, 3, '2024-12-06', 'annulée', 3, 19.8);
INSERT INTO Reservation VALUES (11, 1, 3, '2024-12-10', 'annulée', 4, 4.56);
INSERT INTO Reservation VALUES (12, 9, 8, '2024-12-02', 'en attente', 1, 7.29);
INSERT INTO Reservation VALUES (13, 12, 10, '2024-12-10', 'en attente', 4, 10.43);
INSERT INTO Reservation VALUES (14, 8, 11, '2024-12-05', 'confirmée', 4, 13.42);
INSERT INTO Reservation VALUES (15, 8, 12, '2024-12-03', 'annulée', 2, 7.01);


-- Table PAIEMENT

INSERT INTO Paiement VALUES (1, 1, 1592.75, 'CB', '2024-11-11');
INSERT INTO Paiement VALUES (2, 2, 893.04, 'CB', '2024-12-26');
INSERT INTO Paiement VALUES (3, 3, 1200.14, 'CB', '2024-11-27');
INSERT INTO Paiement VALUES (4, 4, 1389.67, 'Espèces', '2024-11-08');
INSERT INTO Paiement VALUES (5, 5, 547.6, 'Virement', '2024-12-16');
INSERT INTO Paiement VALUES (6, 6, 1141.01, 'CB', '2024-11-01');
INSERT INTO Paiement VALUES (7, 7, 1983.34, 'CB', '2024-11-27');
INSERT INTO Paiement VALUES (8, 8, 2480.85, 'Chèque', '2024-11-01');
INSERT INTO Paiement VALUES (9, 9, 1200.44, 'CB', '2024-12-21');
INSERT INTO Paiement VALUES (10, 10, 1774.12, 'Espèces', '2024-12-04');
INSERT INTO Paiement VALUES (11, 11, 1977.56, 'Chèque', '2024-11-01');
INSERT INTO Paiement VALUES (12, 12, 573.72, 'CB', '2024-11-24');
INSERT INTO Paiement VALUES (13, 13, 1524.93, 'Chèque', '2024-11-27');
INSERT INTO Paiement VALUES (14, 14, 1590.5, 'Virement', '2024-11-08');
INSERT INTO Paiement VALUES (15, 15, 1941.63, 'CB', '2024-11-06');


-- Table ACTIVITE

INSERT INTO Activite VALUES (1, 9, 'Activité 1', 'Visite culturelle');
INSERT INTO Activite VALUES (2, 13, 'Activité 2', 'Bénévolat');
INSERT INTO Activite VALUES (3, 8, 'Activité 3', 'Visite culturelle');
INSERT INTO Activite VALUES (4, 5, 'Activité 4', 'Randonnée');
INSERT INTO Activite VALUES (5, 13, 'Activité 5', 'Bénévolat');
INSERT INTO Activite VALUES (6, 8, 'Activité 6', 'Randonnée');
INSERT INTO Activite VALUES (7, 9, 'Activité 7', 'Bénévolat');
INSERT INTO Activite VALUES (8, 12, 'Activité 8', 'Excursion');
INSERT INTO Activite VALUES (9, 11, 'Activité 9', 'Bénévolat');
INSERT INTO Activite VALUES (10, 5, 'Activité 10', 'Atelier');
INSERT INTO Activite VALUES (11, 8, 'Activité 11', 'Visite culturelle');
INSERT INTO Activite VALUES (12, 4, 'Activité 12', 'Visite culturelle');
INSERT INTO Activite VALUES (13, 9, 'Activité 13', 'Atelier');
INSERT INTO Activite VALUES (14, 2, 'Activité 14', 'Bénévolat');
INSERT INTO Activite VALUES (15, 10, 'Activité 15', 'Atelier');


-- Table GUIDE

INSERT INTO Guide VALUES (1, 'Guide1', 'Débutant', 'Italien');
INSERT INTO Guide VALUES (2, 'Guide2', 'Intermédiaire', 'Anglais');
INSERT INTO Guide VALUES (3, 'Guide3', 'Intermédiaire', 'Français');
INSERT INTO Guide VALUES (4, 'Guide4', 'Débutant', 'Espagnol');
INSERT INTO Guide VALUES (5, 'Guide5', 'Expérimenté', 'Espagnol');
INSERT INTO Guide VALUES (6, 'Guide6', 'Expérimenté', 'Anglais');
INSERT INTO Guide VALUES (7, 'Guide7', 'Intermédiaire', 'Arabe');
INSERT INTO Guide VALUES (8, 'Guide8', 'Expérimenté', 'Français');
INSERT INTO Guide VALUES (9, 'Guide9', 'Débutant', 'Espagnol');
INSERT INTO Guide VALUES (10, 'Guide10', 'Débutant', 'Anglais');
INSERT INTO Guide VALUES (11, 'Guide11', 'Expérimenté', 'Anglais');
INSERT INTO Guide VALUES (12, 'Guide12', 'Intermédiaire', 'Arabe');
INSERT INTO Guide VALUES (13, 'Guide13', 'Débutant', 'Espagnol');
INSERT INTO Guide VALUES (14, 'Guide14', 'Débutant', 'Espagnol');
INSERT INTO Guide VALUES (15, 'Guide15', 'Expérimenté', 'Français');


-- Table HEBERGEMENT

INSERT INTO Hebergement VALUES (1, 'Hebergement1', 'Maison d’hôte', 6, 1);
INSERT INTO Hebergement VALUES (2, 'Hebergement2', 'Maison d’hôte', 43, 5);
INSERT INTO Hebergement VALUES (3, 'Hebergement3', 'Gîte', 49, 4);
INSERT INTO Hebergement VALUES (4, 'Hebergement4', 'Auberge', 50, 5);
INSERT INTO Hebergement VALUES (5, 'Hebergement5', 'Hôtel', 14, 5);
INSERT INTO Hebergement VALUES (6, 'Hebergement6', 'Maison d’hôte', 27, 1);
INSERT INTO Hebergement VALUES (7, 'Hebergement7', 'Maison d’hôte', 11, 3);
INSERT INTO Hebergement VALUES (8, 'Hebergement8', 'Auberge', 25, 1);
INSERT INTO Hebergement VALUES (9, 'Hebergement9', 'Auberge', 37, 2);
INSERT INTO Hebergement VALUES (10, 'Hebergement10', 'Hôtel', 7, 3);
INSERT INTO Hebergement VALUES (11, 'Hebergement11', 'Gîte', 7, 5);
INSERT INTO Hebergement VALUES (12, 'Hebergement12', 'Auberge', 18, 3);
INSERT INTO Hebergement VALUES (13, 'Hebergement13', 'Hôtel', 7, 2);
INSERT INTO Hebergement VALUES (14, 'Hebergement14', 'Auberge', 35, 3);
INSERT INTO Hebergement VALUES (15, 'Hebergement15', 'Maison d’hôte', 45, 1);