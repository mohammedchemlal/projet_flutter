-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 14 déc. 2024 à 10:05
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `flutterapp`
--

-- --------------------------------------------------------

--
-- Structure de la table `complaintes`
--

CREATE TABLE `complaintes` (
  `auteur` varchar(255) NOT NULL,
  `batiment` varchar(11) NOT NULL,
  `coupable` varchar(255) NOT NULL,
  `heure` varchar(255) NOT NULL,
  `idC` int(11) NOT NULL,
  `jour` varchar(255) NOT NULL,
  `numSalle` int(11) NOT NULL,
  `text` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `complaintes`
--

INSERT INTO `complaintes` (`auteur`, `batiment`, `coupable`, `heure`, `idC`, `jour`, `numSalle`, `text`) VALUES
('Salma', 'EMSI AGDAL', 'Etudiant ID234', '10:00', 1, 'lundi', 1, 'fumé dans la classe');

-- --------------------------------------------------------

--
-- Structure de la table `cours`
--

CREATE TABLE `cours` (
  `annee` varchar(255) NOT NULL,
  `filiere` varchar(255) NOT NULL,
  `id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prof` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `cours`
--

INSERT INTO `cours` (`annee`, `filiere`, `id`, `nom`, `prof`) VALUES
('2024', 'Informatique et Réseaux', 1, 'Deep learning', 'oussama'),
('2024', 'informatique et Réseaux', 2, 'JAVA', 'Salma');

-- --------------------------------------------------------

--
-- Structure de la table `notifs`
--

CREATE TABLE `notifs` (
  `batiment` varchar(11) NOT NULL,
  `idN` int(11) NOT NULL,
  `notif` varchar(255) NOT NULL,
  `prof` varchar(255) NOT NULL,
  `salle` int(11) NOT NULL,
  `recu` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `notifs`
--

INSERT INTO `notifs` (`batiment`, `idN`, `notif`, `prof`, `salle`, `recu`) VALUES
('EMSI AGDAL', 1, 'Veuillez ouvrir la salle n°2', 'SALMA', 2, '--');

-- --------------------------------------------------------

--
-- Structure de la table `reservations`
--

CREATE TABLE `reservations` (
  `batiment` varchar(11) NOT NULL,
  `dateRes` date NOT NULL,
  `etage` int(11) NOT NULL,
  `heure` varchar(255) NOT NULL,
  `idR` int(11) NOT NULL,
  `prof` int(11) NOT NULL,
  `salle` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `reservations`
--

INSERT INTO `reservations` (`batiment`, `dateRes`, `etage`, `heure`, `idR`, `prof`, `salle`) VALUES
('EMSI AGDAL', '2024-11-01', 1, '08:30-10:30', 1, 3, 2),
('EMSI1', '2024-11-01', 1, '10h30-12h30', 2, 2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `salles`
--

CREATE TABLE `salles` (
  `batiment` varchar(255) NOT NULL,
  `etage` int(255) NOT NULL,
  `idSalle` int(255) NOT NULL,
  `num` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `salles`
--

INSERT INTO `salles` (`batiment`, `etage`, `idSalle`, `num`) VALUES
('EMSI 1', 1, 1, 1),
('EMSI1', 1, 2, 2),
('EMSI HASSAN', 1, 3, 1),
('EMSI HASSAN', 1, 4, 2),
('EMSI AGDAL', 2, 5, 1),
('EMSI AGDAL', 2, 6, 2),
('EMSI AGDAL', 2, 7, 4);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `batiment` int(11) NOT NULL,
  `cours` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `idU` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phoneNumber` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `userType` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`batiment`, `cours`, `email`, `idU`, `name`, `password`, `phoneNumber`, `username`, `userType`) VALUES
(22, '---', 'med@gmail.com', 1, 'Mohammed', 'admin', '212654120785', 'mohammed', 'Admin'),
(1, 'Deep learning', 'oussama@gmail.com', 2, 'Oussama', 'prof', '21234768906', 'oussama', 'Prof'),
(223, 'JAVA ', 'Salma@gmail.com', 3, 'Salma ', 'prof', '212654120788', 'salma', 'Prof'),
(0, '---', 'younes@hdjd', 4, 'Younes', 'agent', '212634567890', 'younes', 'Agent'),
(0, 'DATA', 'wis@gmail.com', 7, 'Wissam', 'prof', '', 'wissal', 'Prof');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `complaintes`
--
ALTER TABLE `complaintes`
  ADD PRIMARY KEY (`idC`);

--
-- Index pour la table `cours`
--
ALTER TABLE `cours`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `notifs`
--
ALTER TABLE `notifs`
  ADD PRIMARY KEY (`idN`);

--
-- Index pour la table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`idR`);

--
-- Index pour la table `salles`
--
ALTER TABLE `salles`
  ADD PRIMARY KEY (`idSalle`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`idU`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `complaintes`
--
ALTER TABLE `complaintes`
  MODIFY `idC` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `cours`
--
ALTER TABLE `cours`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `notifs`
--
ALTER TABLE `notifs`
  MODIFY `idN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `idR` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `salles`
--
ALTER TABLE `salles`
  MODIFY `idSalle` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `idU` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
