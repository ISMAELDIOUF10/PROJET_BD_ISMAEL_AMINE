USE EcoVoya;


-- 1. Afficher la liste des clients français, triés par nom
SELECT prenom_client, nom_client, email_client, pays_resident_client
FROM Client
WHERE pays_resident_client = 'France'
ORDER BY nom_client ASC;


SELECT nom_voyage, destination_voyage, prix_total_voyage
FROM Voyage
WHERE prix_total_voyage BETWEEN 800 AND 2000;

SELECT nom_guide, langue_guide, niveau_experience
FROM Guide
WHERE langue_guide IN ('Français', 'Anglais');

SELECT nom_hebergement, type_hebergement, niveau_eco
FROM Hebergement
WHERE niveau_eco IN ('Or', 'Platinium');

SELECT *
FROM Client
WHERE nom_client LIKE '%Diouf%';


SELECT c.pays_resident_client, COUNT(r.id_reservation) AS nb_reservations
FROM Client c
JOIN Reservation r ON c.id_client = r.id_client
GROUP BY c.pays_resident_client
ORDER BY nb_reservations DESC;

SELECT niveau_impact_ecologique, AVG(prix_total_voyage) AS prix_moyen
FROM Voyage
GROUP BY niveau_impact_ecologique;

SELECT mode_paiement, COUNT(*) AS nb_paiements
FROM Paiement
GROUP BY mode_paiement;

SELECT statut_reservation, AVG(nb_personne) AS moyenne_personnes
FROM Reservation
GROUP BY statut_reservation;

SELECT v.destination_voyage, SUM(p.montant_paiement) AS total_ventes
FROM Paiement p
JOIN Reservation r ON p.id_reservation = r.id_reservation
JOIN Voyage v ON r.id_voyage = v.id_voyage
GROUP BY v.destination_voyage
HAVING total_ventes > 4000
ORDER BY total_ventes DESC;

SELECT r.id_reservation, c.nom_client, v.destination_voyage, r.date_reservation
FROM Reservation r
JOIN Client c ON r.id_client = c.id_client
JOIN Voyage v ON r.id_voyage = v.id_voyage;

SELECT v.nom_voyage, a.nom_activite, a.type_activite
FROM Voyage v
LEFT JOIN Activite a ON v.id_voyage = a.id_voyage;

SELECT g.nom_guide, p.nom_partenaire, p.type_partenaire
FROM Guide g
JOIN Collaborer c ON g.id_guide = c.id_guide
JOIN Partenaire p ON c.id_partenaire = p.id_partenaire;

SELECT v.nom_voyage, h.nom_hebergement, h.type_hebergement
FROM Proposer pr
JOIN Voyage v ON pr.id_voyage = v.id_voyage
JOIN Hebergement h ON pr.id_hebergement = h.id_hebergement;

SELECT g.nom_guide, a.nom_activite, a.type_activite
FROM Guide g
JOIN Encadrer e ON g.id_guide = e.id_guide
JOIN Activite a ON e.id_activite = a.id_activite;

SELECT nom_client, prenom_client
FROM Client
WHERE id_client IN (SELECT id_client FROM Reservation);

SELECT nom_voyage
FROM Voyage
WHERE id_voyage NOT IN (SELECT id_voyage FROM Reservation);

SELECT nom_guide, niveau_experience
FROM Guide
WHERE niveau_experience IN ('Expérimenté');

SELECT DISTINCT c.nom_client, c.prenom_client
FROM Client c
JOIN Reservation r ON c.id_client = r.id_client
JOIN Paiement p ON r.id_reservation = p.id_reservation
WHERE p.montant_paiement > (SELECT AVG(montant_paiement) FROM Paiement);

SELECT v.nom_voyage, v.destination_voyage
FROM Voyage v
WHERE v.id_voyage IN (
    SELECT pr.id_voyage
    FROM Proposer pr
    JOIN Hebergement h ON pr.id_hebergement = h.id_hebergement
    WHERE h.niveau_eco = 'Or'
);
