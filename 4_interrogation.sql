-- ==============================================
-- 4_interrogation.sql
-- Projet : EcoVoyage Solidaire
-- Auteurs : Ismaël DIOUF, Mohammed-AMINE
-- Scénario d'utilisation :
--  Rôle : Responsable Marketing / Opérations d'EcoVoyage Solidaire
--  Objectif : extraire des informations pour le pilotage commercial et logistique :
--    - lister les clients et leurs réservations,
--    - calculer des statistiques par destination et hébergement,
--    - identifier les guides très sollicités ou mal couverts,
--    - vérifier cohérence paiements / réservations,
--    - trouver opportunités commerciales (destinations populaires, clients parrains).
-- ==============================================



-- ===== Projections et sélections (avec tri, DISTINCT, LIKE, IN, BETWEEN) =====


-- Q1 : Liste distincte des destinations proposées (projection DISTINCT).
-- Données recherchées : quelles destinations sont disponibles.
SELECT DISTINCT destination_voyage
FROM Voyage
ORDER BY destination_voyage;


-- Q2 : Clients français ayant effectué une réservation (sélection + tri).
-- Données recherchées : identification des clients locaux engagés.
SELECT c.id_client, c.prenom_client, c.nom_client, c.email_client
FROM Client c
JOIN Reservation r ON c.id_client = r.id_client
WHERE c.pays_resident_client = 'France'
GROUP BY c.id_client
ORDER BY c.nom_client, c.prenom_client;


-- Q3 : Réservations effectuées entre deux dates (BETWEEN) triées par date.
-- Données recherchées : volume des réservations sur une période donnée.
SELECT id_reservation, id_client, id_voyage, date_reservation, statut_reservation
FROM Reservation
WHERE date_reservation BETWEEN '2024-10-01' AND '2024-12-31'
ORDER BY date_reservation DESC;


-- Q4 : Voyages dont la destination contient 'a' (utilisation de LIKE et masque).
-- Données recherchées : destinations répondant à un critère textuel.
SELECT id_voyage, destination_voyage, date_debut, date_fin
FROM Voyage
WHERE destination_voyage LIKE '%a%'
ORDER BY date_debut;


-- Q5 : Hébergements dont le type est dans une liste (IN).
-- Données recherchées : liste d'hébergements utiles pour une campagne ciblée.
SELECT id_hebergement, nom_hebergement, type_hebergement, capacite_max
FROM Hebergement
WHERE type_hebergement IN ('Gîte','Auberge')
ORDER BY capacite_max DESC;


-- ===== Agrégations (GROUP BY, HAVING) =====


-- Q6 : Nombre de réservations par destination et prix moyen (GROUP BY).
-- Données recherchées : destinations les plus réservées et tarifs moyens.
SELECT v.destination_voyage,
       COUNT(r.id_reservation) AS nb_reservations,
       ROUND(AVG(v.prix_total_voyage),2) AS prix_moyen
FROM Voyage v
LEFT JOIN Reservation r ON v.id_voyage = r.id_voyage
GROUP BY v.destination_voyage
ORDER BY nb_reservations DESC;


-- Q7 : Nombre de clients ayant parrainé au moins un autre client (utilise RECOMMANDER).
-- Données recherchées : mesurer l'effet parrainage.
SELECT c.id_client, c.prenom_client, c.nom_client, COUNT(rec.id_client_filleul) AS nb_filleuls
FROM Client c
JOIN Recommander rec ON c.id_client = rec.id_client_parrain
GROUP BY c.id_client
HAVING nb_filleuls >= 1
ORDER BY nb_filleuls DESC;


-- Q8 : Hébergements avec capacité moyenne des voyages proposés > 10 (exemple d'agrégation + HAVING).
-- Données recherchées : hébergements adaptés pour groupes.
SELECT h.id_hebergement, h.nom_hebergement, COUNT(p.id_voyage) AS nb_voyages_proposes
FROM Hebergement h
JOIN Proposer p ON h.id_hebergement = p.id_hebergement
GROUP BY h.id_hebergement
HAVING nb_voyages_proposes >= 2
ORDER BY nb_voyages_proposes DESC;


-- Q9 : Total des paiements par réservation et sélectionner celles partiellement payées (HAVING).
-- Données recherchées : réservations dont le total payé est inférieur au prix du voyage.
SELECT r.id_reservation, r.id_voyage, SUM(p.montant_paiement) AS total_payes, v.prix_total_voyage
FROM Reservation r
LEFT JOIN Paiement p ON r.id_reservation = p.id_reservation
JOIN Voyage v ON r.id_voyage = v.id_voyage
GROUP BY r.id_reservation
HAVING total_payes < v.prix_total_voyage;


-- Q10 : Guides les plus sollicités (nombre d'activités encadrées) — top 5.
-- Données recherchées : identifier les guides très utilisés pour équilibrer la charge.
SELECT g.id_guide, g.nom_guide, COUNT(e.id_activite) AS nb_activites
FROM Guide g
LEFT JOIN Encadrer e ON g.id_guide = e.id_guide
GROUP BY g.id_guide
HAVING nb_activites > 0
ORDER BY nb_activites DESC
LIMIT 5;


-- ===== Jointures (INNER, LEFT/RIGHT/OUTER, multiples) =====


-- Q11 : Détail des réservations avec info client et voyage (INNER JOIN).
-- Données recherchées : vue complète pour le service client.
SELECT r.id_reservation, c.prenom_client, c.nom_client, v.destination_voyage, r.date_reservation, r.statut_reservation
FROM Reservation r
INNER JOIN Client c ON r.id_client = c.id_client
INNER JOIN Voyage v ON r.id_voyage = v.id_voyage
ORDER BY r.date_reservation DESC;


-- Q12 : Liste de tous les voyages et hébergements associés (LEFT JOIN pour afficher voyages sans hébergement).
-- Données recherchées : détecter voyages sans propositions d'hébergement.
SELECT v.id_voyage, v.destination_voyage, h.nom_hebergement, h.type_hebergement
FROM Voyage v
LEFT JOIN Proposer p ON v.id_voyage = p.id_voyage
LEFT JOIN Hebergement h ON p.id_hebergement = h.id_hebergement
ORDER BY v.id_voyage;


-- Q13 : Récapitulatif multi-join : paiement -> réservation -> client -> voyage.
-- Données recherchées : traçabilité financière complète.
SELECT p.id_paiement, p.montant_paiement, p.date_paiement, r.id_reservation, c.prenom_client, c.nom_client, v.destination_voyage
FROM Paiement p
JOIN Reservation r ON p.id_reservation = r.id_reservation
JOIN Client c ON r.id_client = c.id_client
JOIN Voyage v ON r.id_voyage = v.id_voyage
ORDER BY p.date_paiement DESC;


-- Q14 : Guides et partenaires (jointure via Collaborer) — quels partenaires travaillent avec quels guides.
-- Données recherchées : cartographie des collaborations locales.
SELECT pa.nom_partenaire, g.nom_guide, g.langue_guide
FROM Partenaire pa
JOIN Collaborer co ON pa.id_partenaire = co.id_partenaire
JOIN Guide g ON co.id_guide = g.id_guide
ORDER BY pa.nom_partenaire;


-- Q15 : Activités sans guide assigné (LEFT JOIN + IS NULL).
-- Données recherchées : repérer activités non encadrées pour intervention opérationnelle.
SELECT a.id_activite, a.nom_activite, a.type_activite, v.destination_voyage
FROM Activite a
JOIN Voyage v ON a.id_voyage = v.id_voyage
LEFT JOIN Encadrer e ON a.id_activite = e.id_activite
WHERE e.id_guide IS NULL;


-- ===== Requêtes imbriquées / sous-requêtes (NOT IN, EXISTS, ANY, ALL) =====


-- Q16 : Clients n'ayant jamais effectué de paiement (NOT EXISTS).
-- Données recherchées : clients avec réservations mais sans paiement - relance.
SELECT DISTINCT c.id_client, c.prenom_client, c.nom_client, c.email_client
FROM Client c
JOIN Reservation r ON c.id_client = r.id_client
WHERE NOT EXISTS (
    SELECT 1 FROM Paiement p WHERE p.id_reservation = r.id_reservation
);


-- Q17 : Voyages dont le prix est supérieur à tous les voyages d'une destination donnée (ALL).
-- Données recherchées : voyages premium comparés à leur destination.
SELECT v.id_voyage, v.destination_voyage, v.prix_total_voyage
FROM Voyage v
WHERE v.prix_total_voyage > ALL (
    SELECT prix_total_voyage FROM Voyage v2 WHERE v2.destination_voyage = v.destination_voyage AND v2.id_voyage <> v.id_voyage
);


-- Q18 : Réservations liées à voyages populaires (ANY / sous-requête) - au moins un voyage avec plus de X réservations.
-- Données recherchées : concentrer actions marketing sur voyages populaires.
SELECT r.id_reservation, r.id_voyage, v.destination_voyage
FROM Reservation r
JOIN Voyage v ON r.id_voyage = v.id_voyage
WHERE v.id_voyage = ANY (
    SELECT id_voyage FROM (
        SELECT id_voyage FROM Reservation GROUP BY id_voyage HAVING COUNT(*) >= 2
    ) AS sub
);


-- Q19 : Guides n'ayant pas été supervisés (NOT IN).
-- Données recherchées : guides autonomes n'ayant pas de superviseur attribué.
SELECT g.id_guide, g.nom_guide
FROM Guide g
WHERE g.id_guide NOT IN (
    SELECT id_guide_supervise FROM Superviser
);


-- Q20 : Clients ayant recommandé des clients qui ont réservé (sous-requête corrélée).
-- Données recherchées : efficacité du parrainage en terme de conversion.
SELECT DISTINCT c.id_client, c.prenom_client, c.nom_client
FROM Client c
WHERE EXISTS (
    SELECT 1 FROM Recommander rec
    JOIN Reservation r ON rec.id_client_filleul = r.id_client
    WHERE rec.id_client_parrain = c.id_client
);


-- ===== Requêtes supplémentaires (complexes / mixtes) =====


-- Q21 : Top 3 destinations par revenu (somme des paiements) — jointure + agrégation.
-- Données recherchées : identifier les destinations génératrices de chiffre d'affaires.
SELECT v.destination_voyage, ROUND(SUM(p.montant_paiement),2) AS total_revenu
FROM Paiement p
JOIN Reservation r ON p.id_reservation = r.id_reservation
JOIN Voyage v ON r.id_voyage = v.id_voyage
GROUP BY v.destination_voyage
ORDER BY total_revenu DESC
LIMIT 3;


-- Q22 : Clients et montant total payé (classement) — agrégation, HAVING pour mettre en avant clients payants.
-- Données recherchées : clients VIP / meilleurs payeurs.
SELECT c.id_client, c.prenom_client, c.nom_client, ROUND(SUM(p.montant_paiement),2) AS total_payes
FROM Client c
JOIN Reservation r ON c.id_client = r.id_client
JOIN Paiement p ON r.id_reservation = p.id_reservation
GROUP BY c.id_client
HAVING total_payes > 1000
ORDER BY total_payes DESC;


-- Q23 : Vérifier cohérence : réservations dont la somme des paiements dépasse le prix du voyage (anomalies).
-- Données recherchées : détecter erreurs ou remboursements non enregistrés.
SELECT r.id_reservation, v.prix_total_voyage, SUM(p.montant_paiement) AS total_paye
FROM Reservation r
JOIN Paiement p ON r.id_reservation = p.id_reservation
JOIN Voyage v ON r.id_voyage = v.id_voyage
GROUP BY r.id_reservation
HAVING SUM(p.montant_paiement) > v.prix_total_voyage;


-- Q24 : Activités par langue des guides (jointure + agrégation) — quelles activités nécessitent traducteurs.
-- Données recherchées : planification linguistique selon activité.
SELECT a.type_activite, g.langue_guide, COUNT(*) AS nb_activites
FROM Activite a
JOIN Encadrer e ON a.id_activite = e.id_activite
JOIN Guide g ON e.id_guide = g.id_guide
GROUP BY a.type_activite, g.langue_guide
ORDER BY a.type_activite;


-- Q25 : Réservations pour voyages avec impact 'élevé' mais prix inférieur à la médiane (sous-requête) — détection opportunités.
-- Données recherchées : offres à promouvoir pour améliorer l'impact sans surcoût.
SELECT r.id_reservation, r.id_voyage, v.destination_voyage, v.prix_total_voyage, v.niveau_impact_ecologique
FROM Reservation r
JOIN Voyage v ON r.id_voyage = v.id_voyage
WHERE v.niveau_impact_ecologique = 'élevé'
  AND v.prix_total_voyage < (
      SELECT AVG(prix_total_voyage) FROM Voyage
  );