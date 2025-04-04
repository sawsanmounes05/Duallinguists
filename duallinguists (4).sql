-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Apr 04, 2025 at 06:23 PM
-- Server version: 9.2.0
-- PHP Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `duallinguists`
--

-- --------------------------------------------------------

--
-- Table structure for table `AssessmentAnswers`
--

CREATE TABLE `AssessmentAnswers` (
  `AnswerID` int NOT NULL,
  `QuestionID` int NOT NULL,
  `AnswerText` text NOT NULL,
  `IsCorrect` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `AssessmentAnswers`
--

INSERT INTO `AssessmentAnswers` (`AnswerID`, `QuestionID`, `AnswerText`, `IsCorrect`) VALUES
(1, 1, 'Endless', 0),
(2, 1, 'Temporary', 1),
(3, 1, 'Frequent', 0),
(4, 2, 'Generous', 0),
(5, 2, 'Stingy', 1),
(6, 2, 'Outgoing', 0),
(7, 3, 'To clarify', 0),
(8, 3, 'To confuse', 1),
(9, 3, 'To simplify', 0),
(10, 4, 'Practical', 0),
(11, 4, 'Unrealistically idealistic', 1),
(12, 4, 'Realistic', 0),
(13, 5, 'Rare', 0),
(14, 5, 'Present everywhere', 1),
(15, 5, 'Limited', 0),
(16, 6, 'Silent', 0),
(17, 6, 'Talkative', 1),
(18, 6, 'Brief', 0),
(19, 7, 'She enervated her essay.', 0),
(20, 7, 'The heat enervated the runners.', 1),
(21, 7, 'They enervated the cake.', 0),
(22, 8, 'He wore esoteric shoes.', 0),
(23, 8, 'The book contained esoteric philosophical ideas.', 1),
(24, 8, 'The esoteric light was bright.', 0),
(25, 9, 'Shy and quiet', 0),
(26, 9, 'Noisy and difficult to control', 1),
(27, 9, 'Careful and calm', 0),
(28, 10, 'Forgetful', 0),
(29, 10, 'Wise', 1),
(30, 10, 'Naive', 0),
(31, 11, 'Thorough', 0),
(32, 11, 'Superficial', 1),
(33, 11, 'Enthusiastic', 0),
(34, 12, 'Obedient', 0),
(35, 12, 'Stubborn', 1),
(36, 12, 'Flexible', 0),
(37, 13, 'Open', 0),
(38, 13, 'Secret', 1),
(39, 13, 'Honest', 0),
(40, 14, 'To hate', 0),
(41, 14, 'To respect deeply', 1),
(42, 14, 'To ignore', 0),
(43, 15, 'Consistent', 0),
(44, 15, 'Impulsive and unpredictable', 1),
(45, 15, 'Reliable', 0),
(46, 16, 'rain', 0),
(47, 16, 'rains', 1),
(48, 16, 'raining', 0),
(49, 17, 'She go to school.', 0),
(50, 17, 'She is going to school.', 1),
(51, 17, 'She are going.', 0),
(52, 18, 'Tiny', 0),
(53, 18, 'Huge', 1),
(54, 18, 'Narrow', 0),
(55, 19, 'Always', 0),
(56, 19, 'Often', 1),
(57, 19, 'Never', 0),
(58, 20, 'Does', 0),
(59, 20, 'Do', 1),
(60, 20, 'Did', 0),
(61, 21, 'She eat lunch.', 0),
(62, 21, 'She has eaten lunch.', 1),
(63, 21, 'She eats lunch.', 0),
(64, 22, 'Can I has water?', 0),
(65, 22, 'Can I have some water?', 1),
(66, 22, 'Can I water?', 0),
(67, 23, 'I playing football.', 0),
(68, 23, 'I played football.', 1),
(69, 23, 'I plays football.', 0),
(70, 24, 'a', 0),
(71, 24, 'an', 1),
(72, 24, 'the', 0),
(73, 25, 'Easy', 0),
(74, 25, 'Difficult', 1),
(75, 25, 'Hard', 0),
(76, 26, 'More easy', 0),
(77, 26, 'Easier', 1),
(78, 26, 'Most easier', 0),
(79, 27, 'She swim.', 0),
(80, 27, 'She can swim.', 1),
(81, 27, 'She is swim.', 0),
(82, 28, 'goes', 0),
(83, 28, 'go', 1),
(84, 28, 'going', 0),
(85, 29, 'The boy eats the cake.', 0),
(86, 29, 'The cake was eaten by the boy.', 1),
(87, 29, 'The boy eating the cake.', 0),
(88, 30, 'Eats she breakfast every morning.', 0),
(89, 30, 'She eats breakfast every morning.', 1),
(90, 30, 'Breakfast she eats.', 0),
(91, 31, 'soy', 0),
(92, 31, 'fui', 1),
(93, 31, 'ser', 0),
(94, 32, 'librería', 0),
(95, 32, 'biblioteca', 1),
(96, 32, 'escuela', 0),
(97, 33, 'why', 0),
(98, 33, 'because', 1),
(99, 33, 'therefore', 0),
(100, 34, 'Estoy hambre', 0),
(101, 34, 'Tengo hambre', 1),
(102, 34, 'Soy hambre', 0),
(103, 35, 'vamos', 0),
(104, 35, 'van', 1),
(105, 35, 'vais', 0),
(106, 36, 'a', 0),
(107, 36, 'en', 1),
(108, 36, 'de', 0),
(109, 37, 'No nado.', 0),
(110, 37, 'No puedo nadar.', 1),
(111, 37, 'No puede nadar.', 0),
(112, 38, 'Ella va al mercado.', 0),
(113, 38, 'Ella irá al mercado.', 1),
(114, 38, 'Ella fue al mercado.', 0),
(115, 39, '¿Qué haces?', 0),
(116, 39, '¿Dónde vas?', 1),
(117, 39, '¿Quién es?', 0),
(118, 40, 'red', 0),
(119, 40, 'blue', 1),
(120, 40, 'green', 0),
(121, 41, 'libroes', 0),
(122, 41, 'libros', 1),
(123, 41, 'libro', 0),
(124, 42, 'Un manzana', 0),
(125, 42, 'Una manzana', 1),
(126, 42, 'El manzana', 0),
(127, 43, 'correr', 0),
(128, 43, 'caminar', 1),
(129, 43, 'saltar', 0),
(130, 44, 'templado', 0),
(131, 44, 'caliente', 1),
(132, 44, 'helado', 0),
(133, 45, 'Gracias', 0),
(134, 45, 'Hola', 1),
(135, 45, 'Adiós', 0),
(136, 46, 'comes', 0),
(137, 46, 'como', 1),
(138, 46, 'comer', 0),
(139, 47, 'What is your name?', 0),
(140, 47, 'Where are you from?', 1),
(141, 47, 'Where do you live?', 0),
(142, 48, 'Mi nombre es...', 0),
(143, 48, 'Me llamo...', 1),
(144, 48, 'Yo llamo...', 0),
(145, 49, 'Como', 0),
(146, 49, 'Comí', 1),
(147, 49, 'Comeré', 0),
(148, 50, '¡Ayúdame!', 0),
(149, 50, '¿Podrías ayudarme, por favor?', 1),
(150, 50, 'Tú ayudar ahora?', 0),
(151, 51, 'No bien.', 0),
(152, 51, 'Estoy bien, gracias.', 1),
(153, 51, 'Déjame en paz.', 0),
(154, 52, 'gato', 0),
(155, 52, 'mesa', 1),
(156, 52, 'perro', 0),
(157, 53, 'Hay una libros.', 0),
(158, 53, 'Hay un libro en la mesa.', 1),
(159, 53, 'Hay libros es.', 0),
(160, 31, 'soy', 0),
(161, 31, 'fui', 1),
(162, 31, 'ser', 0),
(163, 32, 'librería', 0),
(164, 32, 'biblioteca', 1),
(165, 32, 'escuela', 0),
(166, 33, 'why', 0),
(167, 33, 'because', 1),
(168, 33, 'therefore', 0),
(169, 34, 'Estoy hambre', 0),
(170, 34, 'Tengo hambre', 1),
(171, 34, 'Soy hambre', 0),
(172, 35, 'vamos', 0),
(173, 35, 'van', 1),
(174, 35, 'vais', 0),
(175, 36, 'a', 0),
(176, 36, 'en', 1),
(177, 36, 'de', 0),
(178, 37, 'No nado.', 0),
(179, 37, 'No puedo nadar.', 1),
(180, 37, 'No puede nadar.', 0),
(181, 38, 'Ella va al mercado.', 0),
(182, 38, 'Ella irá al mercado.', 1),
(183, 38, 'Ella fue al mercado.', 0),
(184, 39, '¿Qué haces?', 0),
(185, 39, '¿Dónde vas?', 1),
(186, 39, '¿Quién es?', 0),
(187, 40, 'red', 0),
(188, 40, 'blue', 1),
(189, 40, 'green', 0),
(190, 41, 'libroes', 0),
(191, 41, 'libros', 1),
(192, 41, 'libro', 0),
(193, 42, 'Un manzana', 0),
(194, 42, 'Una manzana', 1),
(195, 42, 'El manzana', 0),
(196, 43, 'correr', 0),
(197, 43, 'caminar', 1),
(198, 43, 'saltar', 0),
(199, 44, 'templado', 0),
(200, 44, 'caliente', 1),
(201, 44, 'helado', 0),
(202, 45, 'Gracias', 0),
(203, 45, 'Hola', 1),
(204, 45, 'Adiós', 0),
(205, 46, 'comes', 0),
(206, 46, 'como', 1),
(207, 46, 'comer', 0),
(208, 47, 'What is your name?', 0),
(209, 47, 'Where are you from?', 1),
(210, 47, 'Where do you live?', 0),
(211, 48, 'Mi nombre es...', 0),
(212, 48, 'Me llamo...', 1),
(213, 48, 'Yo llamo...', 0),
(214, 49, 'Como', 0),
(215, 49, 'Comí', 1),
(216, 49, 'Comeré', 0),
(217, 50, '¡Ayúdame!', 0),
(218, 50, '¿Podrías ayudarme, por favor?', 1),
(219, 50, 'Tú ayudar ahora?', 0),
(220, 51, 'No bien.', 0),
(221, 51, 'Estoy bien, gracias.', 1),
(222, 51, 'Déjame en paz.', 0),
(223, 52, 'gato', 0),
(224, 52, 'mesa', 1),
(225, 52, 'perro', 0),
(226, 53, 'Hay una libros.', 0),
(227, 53, 'Hay un libro en la mesa.', 1),
(228, 53, 'Hay libros es.', 0),
(229, 31, 'soy', 0),
(230, 31, 'fui', 1),
(231, 31, 'ser', 0),
(232, 32, 'librería', 0),
(233, 32, 'biblioteca', 1),
(234, 32, 'escuela', 0),
(235, 33, 'why', 0),
(236, 33, 'because', 1),
(237, 33, 'therefore', 0),
(238, 34, 'Estoy hambre', 0),
(239, 34, 'Tengo hambre', 1),
(240, 34, 'Soy hambre', 0),
(241, 35, 'vamos', 0),
(242, 35, 'van', 1),
(243, 35, 'vais', 0),
(244, 36, 'a', 0),
(245, 36, 'en', 1),
(246, 36, 'de', 0),
(247, 37, 'No nado.', 0),
(248, 37, 'No puedo nadar.', 1),
(249, 37, 'No puede nadar.', 0),
(250, 38, 'Ella va al mercado.', 0),
(251, 38, 'Ella irá al mercado.', 1),
(252, 38, 'Ella fue al mercado.', 0),
(253, 39, '¿Qué haces?', 0),
(254, 39, '¿Dónde vas?', 1),
(255, 39, '¿Quién es?', 0),
(256, 40, 'red', 0),
(257, 40, 'blue', 1),
(258, 40, 'green', 0),
(259, 41, 'libroes', 0),
(260, 41, 'libros', 1),
(261, 41, 'libro', 0),
(262, 42, 'Un manzana', 0),
(263, 42, 'Una manzana', 1),
(264, 42, 'El manzana', 0),
(265, 43, 'correr', 0),
(266, 43, 'caminar', 1),
(267, 43, 'saltar', 0),
(268, 44, 'templado', 0),
(269, 44, 'caliente', 1),
(270, 44, 'helado', 0),
(271, 45, 'Gracias', 0),
(272, 45, 'Hola', 1),
(273, 45, 'Adiós', 0),
(274, 46, 'comes', 0),
(275, 46, 'como', 1),
(276, 46, 'comer', 0),
(277, 47, 'What is your name?', 0),
(278, 47, 'Where are you from?', 1),
(279, 47, 'Where do you live?', 0),
(280, 48, 'Mi nombre es...', 0),
(281, 48, 'Me llamo...', 1),
(282, 48, 'Yo llamo...', 0),
(283, 49, 'Como', 0),
(284, 49, 'Comí', 1),
(285, 49, 'Comeré', 0),
(286, 50, '¡Ayúdame!', 0),
(287, 50, '¿Podrías ayudarme, por favor?', 1),
(288, 50, 'Tú ayudar ahora?', 0),
(289, 51, 'No bien.', 0),
(290, 51, 'Estoy bien, gracias.', 1),
(291, 51, 'Déjame en paz.', 0),
(292, 52, 'gato', 0),
(293, 52, 'mesa', 1),
(294, 52, 'perro', 0),
(295, 53, 'Hay una libros.', 0),
(296, 53, 'Hay un libro en la mesa.', 1),
(297, 53, 'Hay libros es.', 0),
(298, 54, 'I understand.', 0),
(299, 54, 'I don\'t understand.', 1),
(300, 54, 'I can\'t understand.', 0),
(301, 55, 'after', 0),
(302, 55, 'before', 1),
(303, 55, 'during', 0),
(304, 56, '¡Hola!', 0),
(305, 56, '¿Dónde?', 1),
(306, 56, '¿Por qué no?', 0),
(307, 59, 'Music is good.', 0),
(308, 59, 'I like music.', 1),
(309, 59, 'Music is mine.', 0),
(310, 60, 'Voy a levantar.', 0),
(311, 60, 'Me levanto a las 7.', 1),
(312, 60, 'Estoy levantando.', 0),
(313, 61, 'est', 0),
(314, 61, 'été', 1),
(315, 61, 'était', 0),
(316, 62, 'librairie', 0),
(317, 62, 'bibliothèque', 1),
(318, 62, 'école', 0),
(319, 63, 'so', 0),
(320, 63, 'because', 1),
(321, 63, 'although', 0),
(322, 64, 'Je suis faim', 0),
(323, 64, 'J\'ai faim', 1),
(324, 64, 'Je ai faim', 0),
(325, 65, 'allez', 0),
(326, 65, 'vont', 1),
(327, 65, 'allons', 0),
(328, 66, 'dans', 0),
(329, 66, 'vers', 1),
(330, 66, 'chez', 0),
(331, 67, 'Je sais pas.', 0),
(332, 67, 'Je ne sais pas.', 1),
(333, 67, 'Je ne sais.', 0),
(334, 68, 'Elle va au marché.', 0),
(335, 68, 'Elle ira au marché.', 1),
(336, 68, 'Elle est allée au marché.', 0),
(337, 69, 'Quoi fais-tu ?', 0),
(338, 69, 'Où vas-tu ?', 1),
(339, 69, 'Quand vas-tu ?', 0),
(340, 70, 'green', 0),
(341, 70, 'blue', 1),
(342, 70, 'black', 0),
(343, 71, 'livreses', 0),
(344, 71, 'livres', 1),
(345, 71, 'livrez', 0),
(346, 72, 'Le livre', 0),
(347, 72, 'Un livre', 1),
(348, 72, 'Une livre', 0),
(349, 73, 'courir', 0),
(350, 73, 'marcher', 1),
(351, 73, 'sauter', 0),
(352, 74, 'tiède', 0),
(353, 74, 'chaud', 1),
(354, 74, 'brumeux', 0),
(355, 75, 'Merci', 0),
(356, 75, 'Bonjour', 1),
(357, 75, 'Au revoir', 0),
(358, 76, 'manges', 0),
(359, 76, 'mange', 1),
(360, 76, 'mangent', 0),
(361, 77, 'What do you do?', 0),
(362, 77, 'Where are you from?', 1),
(363, 77, 'Where are you going?', 0),
(364, 78, 'Mon nom est...', 0),
(365, 78, 'Je m\'appelle...', 1),
(366, 78, 'Je nomme...', 0),
(367, 79, 'Je finis', 0),
(368, 79, 'J\'ai fini', 1),
(369, 79, 'Je finirai', 0),
(370, 80, 'Aidez-moi !', 0),
(371, 80, 'Pourriez-vous m\'aider, s\'il vous plaît ?', 1),
(372, 80, 'Tu aides maintenant ?', 0),
(373, 81, 'Pas bien.', 0),
(374, 81, 'Ça va bien, merci.', 1),
(375, 81, 'Va-t\'en.', 0),
(376, 82, 'chat', 0),
(377, 82, 'table', 1),
(378, 82, 'chien', 0),
(379, 83, 'Il y a livres.', 0),
(380, 83, 'Il y a un livre sur la table.', 1),
(381, 83, 'Il y un livre.', 0),
(382, 84, 'I understand.', 0),
(383, 84, 'I don\'t understand.', 1),
(384, 84, 'I can\'t understand.', 0),
(385, 85, 'after', 0),
(386, 85, 'before', 1),
(387, 85, 'during', 0),
(388, 86, 'Quand', 0),
(389, 86, 'Où', 1),
(390, 86, 'Alors', 0),
(391, 87, 'La salle de bain est où ?', 0),
(392, 87, 'Où est la salle de bain ?', 1),
(393, 87, 'Est où la salle de bain ?', 0),
(394, 88, 'te', 0),
(395, 88, 'me', 1),
(396, 88, 'se', 0),
(397, 89, 'Music is nice.', 0),
(398, 89, 'I like music.', 1),
(399, 89, 'I enjoy sound.', 0),
(400, 90, 'Je vais lever.', 0),
(401, 90, 'Je me lève à 7h.', 1),
(402, 90, 'Je levais.', 0),
(403, 91, 'essere', 0),
(404, 91, 'stato', 1),
(405, 91, 'era', 0),
(406, 92, 'libreria', 0),
(407, 92, 'biblioteca', 1),
(408, 92, 'scuola', 0),
(409, 93, 'why', 0),
(410, 93, 'because', 1),
(411, 93, 'however', 0),
(412, 94, 'Sono fame', 0),
(413, 94, 'Ho fame', 1),
(414, 94, 'Io fame', 0),
(415, 95, 'andiamo', 0),
(416, 95, 'vanno', 1),
(417, 95, 'andate', 0),
(418, 96, 'di', 0),
(419, 96, 'alle', 1),
(420, 96, 'per', 0),
(421, 97, 'Io non nuotare.', 0),
(422, 97, 'Non posso nuotare.', 1),
(423, 97, 'No nuoto.', 0),
(424, 98, 'Lei va al mercato.', 0),
(425, 98, 'Lei andrà al mercato.', 1),
(426, 98, 'Lei è andata al mercato.', 0),
(427, 99, 'Che fai?', 0),
(428, 99, 'Dove vai?', 1),
(429, 99, 'Quando vai?', 0),
(430, 100, 'green', 0),
(431, 100, 'blue', 1),
(432, 100, 'black', 0),
(433, 101, 'libros', 0),
(434, 101, 'libri', 1),
(435, 101, 'libre', 0),
(436, 102, 'La libro', 0),
(437, 102, 'Un libro', 1),
(438, 102, 'Uno libro', 0),
(439, 103, 'correre', 0),
(440, 103, 'camminare', 1),
(441, 103, 'saltare', 0),
(442, 104, 'umido', 0),
(443, 104, 'caldo', 1),
(444, 104, 'piovoso', 0),
(445, 105, 'Grazie', 0),
(446, 105, 'Ciao', 1),
(447, 105, 'Per favore', 0),
(448, 106, 'mangi', 0),
(449, 106, 'mangio', 1),
(450, 106, 'mangia', 0),
(451, 107, 'Where do you go?', 0),
(452, 107, 'Where are you from?', 1),
(453, 107, 'Where is the school?', 0),
(454, 108, 'Il mio nome è...', 0),
(455, 108, 'Mi chiamo...', 1),
(456, 108, 'Io nome...', 0),
(457, 109, 'Mangio', 0),
(458, 109, 'Ho mangiato', 1),
(459, 109, 'Mangerò', 0),
(460, 110, 'Aiutami!', 0),
(461, 110, 'Mi può aiutare, per favore?', 1),
(462, 110, 'Tu aiutare ora?', 0),
(463, 111, 'Male.', 0),
(464, 111, 'Sto bene, grazie.', 1),
(465, 111, 'Non buono.', 0),
(466, 112, 'gatto', 0),
(467, 112, 'tavolo', 1),
(468, 112, 'cane', 0),
(469, 113, 'Ci sono una libro.', 0),
(470, 113, 'C\'è un libro sul tavolo.', 1),
(471, 113, 'C\'è libri.', 0),
(472, 114, 'I do understand.', 0),
(473, 114, 'I don\'t understand.', 1),
(474, 114, 'I cannot understanding.', 0),
(475, 115, 'after', 0),
(476, 115, 'before', 1),
(477, 115, 'soon', 0),
(478, 116, 'Perché', 0),
(479, 116, 'Dove', 1),
(480, 116, 'Allora', 0),
(481, 117, 'Il bagno si trova dove?', 0),
(482, 117, 'Dove si trova il bagno?', 1),
(483, 117, 'Trova dove il bagno?', 0),
(484, 118, 'ti', 0),
(485, 118, 'mi', 1),
(486, 118, 'si', 0),
(487, 119, 'Music is good.', 0),
(488, 119, 'I like music.', 1),
(489, 119, 'I enjoy music.', 0),
(490, 120, 'Sto svegliando.', 0),
(491, 120, 'Mi sveglio alle 7.', 1),
(492, 120, 'Mi svegliai.', 0),
(493, 121, 'olmak', 0),
(494, 121, 'oldu', 1),
(495, 121, 'oluyor', 0),
(496, 122, 'okul', 0),
(497, 122, 'kütüphane', 1),
(498, 122, 'kitaplık', 0),
(499, 123, 'therefore', 0),
(500, 123, 'because', 1),
(501, 123, 'but', 0),
(502, 124, 'Ben aç', 0),
(503, 124, 'Açım', 1),
(504, 124, 'Ben acıktım', 0),
(505, 125, 'giderim', 0),
(506, 125, 'giderler', 1),
(507, 125, 'gideriz', 0),
(508, 126, 'üst', 0),
(509, 126, 'doğru', 1),
(510, 126, 'alt', 0),
(511, 127, 'Ben yüzme.', 0),
(512, 127, 'Yüzemem.', 1),
(513, 127, 'Yüzme yok.', 0),
(514, 128, 'Okula gidiyorum.', 0),
(515, 128, 'Okula gideceğim.', 1),
(516, 128, 'Okula gittim.', 0),
(517, 129, 'Ne kalem?', 0),
(518, 129, 'Kalem nerede?', 1),
(519, 129, 'Kim kalem?', 0),
(520, 130, 'red', 0),
(521, 130, 'blue', 1),
(522, 130, 'yellow', 0),
(523, 131, 'kitaps', 0),
(524, 131, 'kitaplar', 1),
(525, 131, 'kitaplarlar', 0),
(526, 132, 'Bir kitap masada.', 0),
(527, 132, 'Kitap masada.', 1),
(528, 132, 'Kitap bir masada.', 0),
(529, 133, 'koşmak', 0),
(530, 133, 'yürümek', 1),
(531, 133, 'atlamak', 0),
(532, 134, 'nemli', 0),
(533, 134, 'sıcak', 1),
(534, 134, 'serin', 0),
(535, 135, 'Teşekkürler', 0),
(536, 135, 'Merhaba', 1),
(537, 135, 'Lütfen', 0),
(538, 136, 'bir tane', 0),
(539, 136, 'bir', 1),
(540, 136, 'birini', 0),
(541, 137, 'Where are you going?', 0),
(542, 137, 'Where are you from?', 1),
(543, 137, 'What do you want?', 0),
(544, 138, 'Adım ben...', 0),
(545, 138, 'Benim adım...', 1),
(546, 138, 'Adı ben...', 0),
(547, 139, 'Gelirim', 0),
(548, 139, 'Geldim', 1),
(549, 139, 'Geleceğim', 0),
(550, 140, 'Yardım et!', 0),
(551, 140, 'Yardım eder misiniz lütfen?', 1),
(552, 140, 'Sen yardım şimdi?', 0),
(553, 141, 'Kötüyüm.', 0),
(554, 141, 'İyiyim, teşekkürler.', 1),
(555, 141, 'Hiç iyi değil.', 0),
(556, 142, 'kedi', 0),
(557, 142, 'masa', 1),
(558, 142, 'köpek', 0),
(559, 143, 'Kalem yoktur.', 0),
(560, 143, 'Kalem var.', 1),
(561, 143, 'Kalem değil var.', 0),
(562, 144, 'I do understand.', 0),
(563, 144, 'I don\'t understand.', 1),
(564, 144, 'I am not understanding.', 0),
(565, 145, 'after', 0),
(566, 145, 'before', 1),
(567, 145, 'again', 0),
(568, 146, 'Hayır', 0),
(569, 146, 'Nerede', 1),
(570, 146, 'Güle güle', 0),
(571, 147, 'Nedir bu?', 0),
(572, 147, 'Bu nedir?', 1),
(573, 147, 'Bu ne mi?', 0),
(574, 148, 'kendi', 0),
(575, 148, 'kendim', 1),
(576, 148, 'kendini', 0),
(577, 149, 'Music is nice.', 0),
(578, 149, 'I like music.', 1),
(579, 149, 'Music loves me.', 0),
(580, 150, 'Kahvaltı yapacağım.', 0),
(581, 150, 'Her sabah kahvaltı yaparım.', 1),
(582, 150, 'Sabahları kahvaltı yapıyordum.', 0);

-- --------------------------------------------------------

--
-- Table structure for table `AssessmentDetails`
--

CREATE TABLE `AssessmentDetails` (
  `AssessmentDetailID` int NOT NULL,
  `AssessmentType` enum('Regular','Student') NOT NULL,
  `LanguageID` int NOT NULL,
  `Title` varchar(100) NOT NULL,
  `Description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `AssessmentDetails`
--

INSERT INTO `AssessmentDetails` (`AssessmentDetailID`, `AssessmentType`, `LanguageID`, `Title`, `Description`) VALUES
(1, 'Regular', 1, 'English Regular Assessment', 'General practice assessment for language learners.'),
(2, 'Student', 1, 'English Student Assessment', 'Assessment based on student-level (GCSE-style) questions.'),
(3, 'Regular', 2, 'Spanish Regular Assessment', 'General practice assessment for language learners.'),
(4, 'Student', 2, 'Spanish Student Assessment', 'Assessment based on student-level (GCSE-style) questions.'),
(5, 'Regular', 3, 'French Regular Assessment', 'General practice assessment for language learners.'),
(6, 'Student', 3, 'French Student Assessment', 'Assessment based on student-level (GCSE-style) questions.'),
(7, 'Regular', 4, 'Italian Regular Assessment', 'General practice assessment for language learners.'),
(8, 'Student', 4, 'Italian Student Assessment', 'Assessment based on student-level (GCSE-style) questions.'),
(9, 'Regular', 5, 'Turkish Regular Assessment', 'General practice assessment for language learners.'),
(10, 'Student', 5, 'Turkish Student Assessment', 'Assessment based on student-level (GCSE-style) questions.');

-- --------------------------------------------------------

--
-- Table structure for table `AssessmentQuestions`
--

CREATE TABLE `AssessmentQuestions` (
  `QuestionID` int NOT NULL,
  `AssessmentType` enum('Regular','Student') NOT NULL,
  `LanguageID` int NOT NULL,
  `QuestionText` text NOT NULL,
  `AssessmentDetailID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `AssessmentQuestions`
--

INSERT INTO `AssessmentQuestions` (`QuestionID`, `AssessmentType`, `LanguageID`, `QuestionText`, `AssessmentDetailID`) VALUES
(1, 'Regular', 1, 'What is the synonym of \"ephemeral\"?', 1),
(2, 'Regular', 1, 'Which word best describes a person who is parsimonious?', 1),
(3, 'Regular', 1, 'Identify the meaning of \"obfuscate\".', 1),
(4, 'Regular', 1, 'What does \"quixotic\" mean?', 1),
(5, 'Regular', 1, 'Choose the correct definition of \"ubiquitous\".', 1),
(6, 'Regular', 1, 'What is the antonym of \"laconic\"?', 1),
(7, 'Regular', 1, 'Which sentence uses \"enervate\" correctly?', 1),
(8, 'Regular', 1, 'Identify the correct usage of \"esoteric\".', 1),
(9, 'Regular', 1, 'What does \"obstreperous\" mean?', 1),
(10, 'Regular', 1, 'Choose the meaning of \"sagacious\".', 1),
(11, 'Regular', 1, 'What is the synonym of \"perfunctory\"?', 1),
(12, 'Regular', 1, 'Identify the meaning of \"recalcitrant\".', 1),
(13, 'Regular', 1, 'Which word is closest in meaning to \"surreptitious\"?', 1),
(14, 'Regular', 1, 'What does \"venerate\" mean?', 1),
(15, 'Regular', 1, 'Choose the correct definition of \"capricious\".', 1),
(16, 'Student', 1, 'Choose the correct form: \"If it ___ tomorrow, we will stay inside.\"', 2),
(17, 'Student', 1, 'Identify the correct sentence:', 2),
(18, 'Student', 1, 'Which word is a synonym for \"big\"?', 2),
(19, 'Student', 1, 'What does the word \"usually\" mean?', 2),
(20, 'Student', 1, 'Choose the correct question form: \"___ you like tea?\"', 2),
(21, 'Student', 1, 'Select the correct use of the present perfect tense.', 2),
(22, 'Student', 1, 'Which sentence uses \"some\" correctly?', 2),
(23, 'Student', 1, 'Find the correct sentence using past simple tense.', 2),
(24, 'Student', 1, 'Choose the correct article: \"She bought ___ apple.\"', 2),
(25, 'Student', 1, 'What is the opposite of \"easy\"?', 2),
(26, 'Student', 1, 'Choose the correct comparative form: \"This test is ___ than the last one.\"', 2),
(27, 'Student', 1, 'Select the sentence with a modal verb.', 2),
(28, 'Student', 1, 'Choose the word that best completes the sentence: \"They ___ to the cinema every weekend.\"', 2),
(29, 'Student', 1, 'Which sentence is in the passive voice?', 2),
(30, 'Student', 1, 'Identify the correct word order:', 2),
(31, 'Regular', 2, 'What is the past tense of the verb \"to be\"?', 3),
(32, 'Regular', 2, 'Translate \"library\" to Spanish.', 3),
(33, 'Regular', 2, 'What does the word \"porque\" mean?', 3),
(34, 'Regular', 2, 'How do you say \"I am hungry\" in Spanish?', 3),
(35, 'Regular', 2, 'Choose the correct form of \"ir\" for \"they\".', 3),
(36, 'Regular', 2, 'Identify the correct preposition for location.', 3),
(37, 'Regular', 2, 'Select the correct negative sentence in Spanish.', 3),
(38, 'Regular', 2, 'Which sentence is in the future tense?', 3),
(39, 'Regular', 2, 'Find the question using \"dónde\".', 3),
(40, 'Regular', 2, 'Choose the correct translation for \"azul\".', 3),
(41, 'Regular', 2, 'What is the plural form of \"libro\"?', 3),
(42, 'Regular', 2, 'Select the sentence with the correct article.', 3),
(43, 'Regular', 2, 'Choose the word that means \"to walk\".', 3),
(44, 'Regular', 2, 'What is the opposite of \"frío\"?', 3),
(45, 'Regular', 2, 'Which is a greeting in Spanish?', 3),
(46, 'Student', 2, 'Fill in the blank: Yo ___ manzanas.', 4),
(47, 'Student', 2, 'Translate: ¿De dónde eres?', 4),
(48, 'Student', 2, 'What is the correct way to say \"My name is...\"?', 4),
(49, 'Student', 2, 'Choose the correct tense for a completed action.', 4),
(50, 'Student', 2, 'Which of these is a polite question in Spanish?', 4),
(51, 'Student', 2, 'What is a good response to \"¿Cómo estás?\"', 4),
(52, 'Student', 2, 'Choose the word that doesn’t belong: gato, perro, mesa', 4),
(53, 'Student', 2, 'Find the correct form of \"hay\" (there is/are).', 4),
(54, 'Student', 2, 'Translate: \"No entiendo\".', 4),
(55, 'Student', 2, 'What does \"antes\" mean?', 4),
(56, 'Student', 2, 'Which of these is a Spanish question word?', 4),
(57, 'Student', 2, 'Choose the correct word order for a question.', 4),
(58, 'Student', 2, 'Select the correct reflexive pronoun for \"yo\".', 4),
(59, 'Student', 2, 'Translate \"Me gusta la música\".', 4),
(60, 'Student', 2, 'Which sentence describes a daily routine?', 4),
(61, 'Regular', 3, 'What is the past tense of the verb \"être\"?', 5),
(62, 'Regular', 3, 'Translate \"library\" to French.', 5),
(63, 'Regular', 3, 'What does the word \"parce que\" mean?', 5),
(64, 'Regular', 3, 'How do you say \"I am hungry\" in French?', 5),
(65, 'Regular', 3, 'Choose the correct form of \"aller\" for \"ils\".', 5),
(66, 'Regular', 3, 'Identify the correct preposition for direction.', 5),
(67, 'Regular', 3, 'Select the correct negative sentence in French.', 5),
(68, 'Regular', 3, 'Which sentence is in the future tense?', 5),
(69, 'Regular', 3, 'Find the question using \"où\".', 5),
(70, 'Regular', 3, 'Choose the correct translation for \"bleu\".', 5),
(71, 'Regular', 3, 'What is the plural form of \"livre\"?', 5),
(72, 'Regular', 3, 'Select the sentence with the correct article.', 5),
(73, 'Regular', 3, 'Choose the word that means \"to walk\".', 5),
(74, 'Regular', 3, 'What is the opposite of \"froid\"?', 5),
(75, 'Regular', 3, 'Which is a greeting in French?', 5),
(76, 'Student', 3, 'Fill in the blank: Je ___ des pommes.', 6),
(77, 'Student', 3, 'Translate: D\'où viens-tu ?', 6),
(78, 'Student', 3, 'What is the correct way to say \"My name is...\" in French?', 6),
(79, 'Student', 3, 'Choose the correct tense for a completed action.', 6),
(80, 'Student', 3, 'Which of these is a polite question in French?', 6),
(81, 'Student', 3, 'What is a good response to \"Comment ça va?\"', 6),
(82, 'Student', 3, 'Choose the word that doesn’t belong: chat, chien, table', 6),
(83, 'Student', 3, 'Find the correct form of \"il y a\".', 6),
(84, 'Student', 3, 'Translate: \"Je ne comprends pas.\"', 6),
(85, 'Student', 3, 'What does \"avant\" mean?', 6),
(86, 'Student', 3, 'Which of these is a French question word?', 6),
(87, 'Student', 3, 'Choose the correct word order for a question.', 6),
(88, 'Student', 3, 'Select the correct reflexive pronoun for \"je\".', 6),
(89, 'Student', 3, 'Translate \"J’aime la musique\".', 6),
(90, 'Student', 3, 'Which sentence describes a daily routine?', 6),
(91, 'Regular', 4, 'What is the past tense of the verb \"essere\"?', 7),
(92, 'Regular', 4, 'Translate \"library\" to Italian.', 7),
(93, 'Regular', 4, 'What does the word \"perché\" mean?', 7),
(94, 'Regular', 4, 'How do you say \"I am hungry\" in Italian?', 7),
(95, 'Regular', 4, 'Choose the correct form of \"andare\" for \"loro\".', 7),
(96, 'Regular', 4, 'Identify the correct preposition for time.', 7),
(97, 'Regular', 4, 'Select the correct negative sentence in Italian.', 7),
(98, 'Regular', 4, 'Which sentence is in the future tense?', 7),
(99, 'Regular', 4, 'Find the question using \"dove\".', 7),
(100, 'Regular', 4, 'Choose the correct translation for \"blu\".', 7),
(101, 'Regular', 4, 'What is the plural form of \"libro\"?', 7),
(102, 'Regular', 4, 'Select the sentence with the correct article.', 7),
(103, 'Regular', 4, 'Choose the word that means \"to walk\".', 7),
(104, 'Regular', 4, 'What is the opposite of \"freddo\"?', 7),
(105, 'Regular', 4, 'Which is a greeting in Italian?', 7),
(106, 'Student', 4, 'Fill in the blank: Io ___ le mele.', 8),
(107, 'Student', 4, 'Translate: Di dove sei?', 8),
(108, 'Student', 4, 'What is the correct way to say \"My name is...\" in Italian?', 8),
(109, 'Student', 4, 'Choose the correct tense for a completed action.', 8),
(110, 'Student', 4, 'Which of these is a polite question in Italian?', 8),
(111, 'Student', 4, 'What is a good response to \"Come stai?\"', 8),
(112, 'Student', 4, 'Choose the word that doesn’t belong: gatto, cane, tavolo', 8),
(113, 'Student', 4, 'Find the correct use of \"c\'è\" or \"ci sono\".', 8),
(114, 'Student', 4, 'Translate: \"Non capisco\".', 8),
(115, 'Student', 4, 'What does \"prima\" mean?', 8),
(116, 'Student', 4, 'Which of these is an Italian question word?', 8),
(117, 'Student', 4, 'Choose the correct word order for a question.', 8),
(118, 'Student', 4, 'Select the correct reflexive pronoun for \"io\".', 8),
(119, 'Student', 4, 'Translate \"Mi piace la musica\".', 8),
(120, 'Student', 4, 'Which sentence describes a daily routine?', 8),
(121, 'Regular', 5, 'What is the past tense of the verb \"olmak\"?', 9),
(122, 'Regular', 5, 'Translate \"library\" to Turkish.', 9),
(123, 'Regular', 5, 'What does the word \"çünkü\" mean?', 9),
(124, 'Regular', 5, 'How do you say \"I am hungry\" in Turkish?', 9),
(125, 'Regular', 5, 'Choose the correct form of \"gitmek\" for \"onlar\".', 9),
(126, 'Regular', 5, 'Identify the correct preposition for direction.', 9),
(127, 'Regular', 5, 'Select the correct negative sentence in Turkish.', 9),
(128, 'Regular', 5, 'Which sentence is in the future tense?', 9),
(129, 'Regular', 5, 'Find the question using \"nerede\".', 9),
(130, 'Regular', 5, 'Choose the correct translation for \"mavi\".', 9),
(131, 'Regular', 5, 'What is the plural form of \"kitap\"?', 9),
(132, 'Regular', 5, 'Select the sentence with the correct article (if any).', 9),
(133, 'Regular', 5, 'Choose the word that means \"to walk\".', 9),
(134, 'Regular', 5, 'What is the opposite of \"soğuk\"?', 9),
(135, 'Regular', 5, 'Which is a greeting in Turkish?', 9),
(136, 'Student', 5, 'Fill in the blank: Ben ___ elma yerim.', 10),
(137, 'Student', 5, 'Translate: Nerelisin?', 10),
(138, 'Student', 5, 'What is the correct way to say \"My name is...\" in Turkish?', 10),
(139, 'Student', 5, 'Choose the correct tense for a completed action.', 10),
(140, 'Student', 5, 'Which of these is a polite question in Turkish?', 10),
(141, 'Student', 5, 'What is a good response to \"Nasılsın?\"', 10),
(142, 'Student', 5, 'Choose the word that doesn’t belong: kedi, köpek, masa', 10),
(143, 'Student', 5, 'Find the correct form of \"var\" or \"yok\".', 10),
(144, 'Student', 5, 'Translate: \"Anlamıyorum\".', 10),
(145, 'Student', 5, 'What does \"önce\" mean?', 10),
(146, 'Student', 5, 'Which of these is a Turkish question word?', 10),
(147, 'Student', 5, 'Choose the correct word order for a question.', 10),
(148, 'Student', 5, 'Select the correct reflexive form for \"ben\".', 10),
(149, 'Student', 5, 'Translate \"Müziği severim\".', 10),
(150, 'Student', 5, 'Which sentence describes a daily routine?', 10);

-- --------------------------------------------------------

--
-- Table structure for table `AssessmentResponses`
--

CREATE TABLE `AssessmentResponses` (
  `ResponseID` int NOT NULL,
  `AssessmentID` int NOT NULL,
  `QuestionID` int NOT NULL,
  `SelectedAnswerID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Assessments`
--

CREATE TABLE `Assessments` (
  `AssessmentID` int NOT NULL,
  `UserID` varchar(50) DEFAULT NULL,
  `AssessmentType` enum('Regular','Student') NOT NULL,
  `LanguageID` int NOT NULL,
  `Score` int DEFAULT NULL,
  `DateTaken` datetime DEFAULT CURRENT_TIMESTAMP,
  `AssessmentDetailID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CulturalInsights`
--

CREATE TABLE `CulturalInsights` (
  `InsightID` int NOT NULL,
  `LanguageID` int NOT NULL,
  `CountryDescription` text NOT NULL,
  `FunFacts` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `CulturalInsights`
--

INSERT INTO `CulturalInsights` (`InsightID`, `LanguageID`, `CountryDescription`, `FunFacts`) VALUES
(1, 1, 'A country made up of four nations: England, Scotland, Wales, and Northern Ireland. The UK has a rich history, from medieval monarchies to the British Empire, and is known for its cultural influence in music, literature, and politics.', 'The King technically owns all the swans in open water in England.\nBig Ben is actually the bell inside the clock tower — not the tower itself.\nLondon has more Indian restaurants than Delhi or Mumbai!'),
(2, 4, 'A boot-shaped country in southern Europe, known for its art, architecture, food, and ancient history. Home to the Roman Empire and the birthplace of the Renaissance.', 'Italy has the most UNESCO World Heritage Sites in the world.\nPizza was invented in Naples in the 18th century.\nThe Vatican City, the smallest country in the world, is located entirely within Rome.'),
(3, 3, 'A country known for its fashion, cuisine, art, and revolutionary history. From the Eiffel Tower to the French Riviera, it blends elegance with deep historical roots.', 'The French eat around 30,000 tons of snails each year.\nFrance has the most time zones of any country (12!), thanks to its overseas territories.\n\"The Louvre\" is the world’s most visited museum — and home of the Mona Lisa.'),
(4, 2, 'A vibrant country on the Iberian Peninsula known for its beaches, flamenco dancing, football, and passionate culture. Spain has a mix of unique regions like Catalonia and Andalusia.', 'Spain has the second-highest number of UNESCO World Heritage Sites (after Italy).\nThe Spanish national anthem has no official lyrics.\nThe \"La Tomatina\" festival involves throwing over 100 tons of tomatoes!'),
(5, 5, 'A transcontinental country bridging Europe and Asia, rich in cultural diversity and history, from the Byzantine to the Ottoman Empires. Istanbul, once Constantinople, is a key historical city.', 'Turkey is home to Göbekli Tepe — the world’s oldest known temple, over 11,000 years old.\nTulips actually originated in Turkey, not the Netherlands.\nThe Turkish language has a unique suffix system — one word can turn into a long chain of meaning!');

-- --------------------------------------------------------

--
-- Table structure for table `GroupChatMembers`
--

CREATE TABLE `GroupChatMembers` (
  `MemberID` int NOT NULL,
  `GroupChatID` int DEFAULT NULL,
  `UserID` varchar(50) DEFAULT NULL,
  `JoinedAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `GroupChatMessages`
--

CREATE TABLE `GroupChatMessages` (
  `MessageID` int NOT NULL,
  `GroupChatID` int DEFAULT NULL,
  `UserID` varchar(50) DEFAULT NULL,
  `MessageText` text,
  `SentAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `GroupChats`
--

CREATE TABLE `GroupChats` (
  `GroupChatID` int NOT NULL,
  `LanguageID` int DEFAULT NULL,
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `GroupChats`
--

INSERT INTO `GroupChats` (`GroupChatID`, `LanguageID`, `CreatedAt`) VALUES
(1, 1, '2025-04-04 17:23:18'),
(2, 2, '2025-04-04 17:23:18'),
(3, 3, '2025-04-04 17:23:18'),
(4, 4, '2025-04-04 17:23:18'),
(5, 5, '2025-04-04 17:23:18');

-- --------------------------------------------------------

--
-- Table structure for table `LanguageList`
--

CREATE TABLE `LanguageList` (
  `LanguageID` int NOT NULL,
  `LanguageName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `LanguageList`
--

INSERT INTO `LanguageList` (`LanguageID`, `LanguageName`) VALUES
(1, 'English'),
(3, 'French'),
(4, 'Italian'),
(2, 'Spanish'),
(5, 'Turkish');

-- --------------------------------------------------------

--
-- Table structure for table `QuizAnswers`
--

CREATE TABLE `QuizAnswers` (
  `AnswerID` int NOT NULL,
  `QuestionID` int NOT NULL,
  `AnswerText` text NOT NULL,
  `IsCorrect` tinyint(1) NOT NULL DEFAULT '0',
  `LanguageID` int NOT NULL,
  `CategoryID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `QuizAnswers`
--

INSERT INTO `QuizAnswers` (`AnswerID`, `QuestionID`, `AnswerText`, `IsCorrect`, `LanguageID`, `CategoryID`) VALUES
(1, 1, 'She has gone to the store.', 0, 1, 1),
(2, 1, 'She had gone to the store.', 1, 1, 1),
(3, 1, 'She goes to the store.', 0, 1, 1),
(4, 2, 'Identify the semicolon usage;', 0, 1, 2),
(5, 2, 'Identify: the semicolon usage.', 1, 1, 2),
(6, 2, 'Identify; the semicolon usage.', 0, 1, 2),
(7, 3, 'Essential', 0, 1, 1),
(8, 3, 'Necessary', 1, 1, 1),
(9, 3, 'Unimportant', 0, 1, 1),
(10, 4, 'To provide statistical evidence', 0, 1, 2),
(11, 4, 'To persuade the reader', 1, 1, 2),
(12, 4, 'To describe a setting', 0, 1, 2),
(13, 5, 'The boy ran home.', 0, 1, 1),
(14, 5, 'Because the boy ran home, he was late.', 1, 1, 1),
(15, 5, 'The boy ran home because he was late.', 0, 1, 1),
(16, 6, 'The wind howled through the night.', 0, 1, 2),
(17, 6, 'The trees waved their hands.', 1, 1, 2),
(18, 6, 'The sun smiled at us.', 0, 1, 2),
(19, 7, 'He comido', 1, 2, 1),
(20, 7, 'Yo comé', 0, 2, 1),
(21, 7, 'Comí', 0, 2, 1),
(22, 8, 'Azul', 0, 2, 2),
(23, 8, 'Caminar', 0, 2, 2),
(24, 8, 'Feliz', 1, 2, 2),
(25, 9, 'Porque', 1, 2, 1),
(26, 9, 'Pero', 0, 2, 1),
(27, 9, 'Aunque', 0, 2, 1),
(28, 10, 'Tuve', 1, 2, 2),
(29, 10, 'Tuvé', 0, 2, 2),
(30, 10, 'Tienes', 0, 2, 2),
(31, 11, '\'Por\' expresses duration, \'Para\' expresses purpose', 1, 2, 1),
(32, 11, '\'Para\' expresses duration, \'Por\' expresses purpose', 0, 2, 1),
(33, 11, 'They are interchangeable', 0, 2, 1),
(34, 12, 'En mi opinión', 1, 2, 2),
(35, 12, 'Yo quiero', 0, 2, 2),
(36, 12, 'Me llamo', 0, 2, 2),
(37, 13, 'Elle est heureuse', 1, 3, 1),
(38, 13, 'Elle a heureuse', 0, 3, 1),
(39, 13, 'Elle heureux', 0, 3, 1),
(40, 14, 'Le', 1, 3, 2),
(41, 14, 'La', 0, 3, 2),
(42, 14, 'Les', 0, 3, 2),
(43, 15, 'Très', 1, 3, 1),
(44, 15, 'Peu', 0, 3, 1),
(45, 15, 'Beaucoup', 0, 3, 1),
(46, 16, 'J\'ai mangé une pomme.', 1, 3, 2),
(47, 16, 'Je mange une pomme.', 0, 3, 2),
(48, 16, 'Manger une pomme.', 0, 3, 2),
(49, 17, 'To express necessity', 0, 3, 1),
(50, 17, 'To express doubt or uncertainty', 1, 3, 1),
(51, 17, 'To indicate past actions', 0, 3, 1),
(52, 18, 'Avoir le cafard', 1, 3, 2),
(53, 18, 'Boire un coup', 0, 3, 2),
(54, 18, 'Coup de foudre', 0, 3, 2),
(55, 19, 'Buongiorno', 1, 4, 1),
(56, 19, 'Buonasera', 0, 4, 1),
(57, 19, 'Ciao', 0, 4, 1),
(58, 20, 'Mangiare', 1, 4, 2),
(59, 20, 'Bella', 0, 4, 2),
(60, 20, 'Gatto', 0, 4, 2),
(61, 21, 'E', 1, 4, 1),
(62, 21, 'Ma', 0, 4, 1),
(63, 21, 'O', 0, 4, 1),
(64, 22, 'Ho mangiato', 1, 4, 2),
(65, 22, 'Mangiai', 0, 4, 2),
(66, 22, 'Mangierò', 0, 4, 2),
(67, 23, 'Attendere (to wait)', 0, 4, 1),
(68, 23, 'Attendere (to pretend)', 1, 4, 1),
(69, 23, 'Aspettare (to wait)', 0, 4, 1),
(70, 24, 'Voglio andare', 1, 4, 2),
(71, 24, 'Vado a casa', 0, 4, 2),
(72, 24, 'Andrò a scuola', 0, 4, 2),
(73, 25, 'Merhaba', 1, 5, 1),
(74, 25, 'Selam', 0, 5, 1),
(75, 25, 'Nasılsın', 0, 5, 1),
(76, 26, 'Köpek', 1, 5, 2),
(77, 26, 'Büyük', 0, 5, 2),
(78, 26, 'Yavaş', 0, 5, 2),
(79, 27, 'Niçin', 1, 5, 1),
(80, 27, 'Nasıl', 0, 5, 1),
(81, 27, 'Kim', 0, 5, 1),
(82, 28, 'Ben okula gidiyorum.', 1, 5, 2),
(83, 28, 'Gidiyorum ben okula.', 0, 5, 2),
(84, 28, 'Okula ben gidiyorum.', 0, 5, 2),
(85, 29, '\'Var\' means exists, \'Yok\' means does not exist', 1, 5, 1),
(86, 29, '\'Var\' means does not exist, \'Yok\' means exists', 0, 5, 1),
(87, 29, 'They both mean the same', 0, 5, 1),
(88, 30, '-im', 1, 5, 2),
(89, 30, '-lar', 0, 5, 2),
(90, 30, '-de', 0, 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `QuizCategories`
--

CREATE TABLE `QuizCategories` (
  `CategoryID` int NOT NULL,
  `CategoryName` enum('Regular Quiz','Student Quiz') NOT NULL,
  `Description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `QuizCategories`
--

INSERT INTO `QuizCategories` (`CategoryID`, `CategoryName`, `Description`) VALUES
(1, 'Regular Quiz', 'Standard quiz for general practice.'),
(2, 'Student Quiz', 'Quiz designed for GCSES.');

-- --------------------------------------------------------

--
-- Table structure for table `QuizDetails`
--

CREATE TABLE `QuizDetails` (
  `QuizID` int NOT NULL,
  `CategoryID` int NOT NULL,
  `QuizTitle` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `QuizDetails`
--

INSERT INTO `QuizDetails` (`QuizID`, `CategoryID`, `QuizTitle`) VALUES
(1, 1, 'Regular Quiz'),
(2, 2, 'Student Quiz');

-- --------------------------------------------------------

--
-- Table structure for table `QuizQuestions`
--

CREATE TABLE `QuizQuestions` (
  `QuestionID` int NOT NULL,
  `QuizID` int NOT NULL,
  `QuestionText` text NOT NULL,
  `LanguageID` int NOT NULL,
  `CategoryID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `QuizQuestions`
--

INSERT INTO `QuizQuestions` (`QuestionID`, `QuizID`, `QuestionText`, `LanguageID`, `CategoryID`) VALUES
(1, 1, 'Which sentence is in the present perfect tense?', 1, 1),
(2, 1, 'Identify the correct use of a semicolon.', 1, 1),
(3, 1, 'Which of the following words is a synonym for \"important\"?', 1, 1),
(4, 2, 'What is the purpose of using rhetorical questions in persuasive writing?', 1, 2),
(5, 2, 'Which of the following contains a subordinate clause?', 1, 2),
(6, 2, 'In which sentence is a metaphor used?', 1, 2),
(7, 1, 'What is the correct translation for \"I have eaten\" in Spanish?', 2, 1),
(8, 1, 'Which of these Spanish words is an adjective?', 2, 1),
(9, 1, 'What is the Spanish equivalent of the English word \"because\"?', 2, 1),
(10, 2, 'Which of the following correctly conjugates \"tener\" in the preterite tense for \"yo\"?', 2, 2),
(11, 2, 'What is the difference between \"por\" and \"para\" in Spanish?', 2, 2),
(12, 2, 'Which of the following Spanish phrases expresses an opinion?', 2, 2),
(13, 1, 'Which of these is the correct translation of \"She is happy\"?', 3, 1),
(14, 1, 'Identify the correct definite article for \"livre\" (book).', 3, 1),
(15, 1, 'What is the French equivalent of \"very\"?', 3, 1),
(16, 2, 'Which of these sentences uses the passé composé correctly?', 3, 2),
(17, 2, 'What is the function of the subjunctive mood in French?', 3, 2),
(18, 2, 'Which of these is a correct French idiomatic expression?', 3, 2),
(19, 1, 'Which is the correct translation of \"Good morning\" in Italian?', 4, 1),
(20, 1, 'Which of these words is a verb in Italian?', 4, 1),
(21, 1, 'What is the Italian word for \"and\"?', 4, 1),
(22, 2, 'How do you correctly form the past tense of \"mangiare\" (to eat)?', 4, 2),
(23, 2, 'Which of these Italian words is a false cognate?', 4, 2),
(24, 2, 'Which of these phrases expresses future intention?', 4, 2),
(25, 1, 'What is the correct translation of \"Hello\" in Turkish?', 5, 1),
(26, 1, 'Which of these words is a noun in Turkish?', 5, 1),
(27, 1, 'What is the Turkish equivalent of the word \"why\"?', 5, 1),
(28, 2, 'Which of these sentences uses the correct word order in Turkish?', 5, 2),
(29, 2, 'What is the difference between \"var\" and \"yok\" in Turkish?', 5, 2),
(30, 2, 'Which Turkish suffix is used to express possession?', 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `SelectionOptions`
--

CREATE TABLE `SelectionOptions` (
  `SelectionID` int NOT NULL,
  `SelectionName` varchar(100) NOT NULL,
  `Description` text,
  `RedirectURL` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `SelectionOptions`
--

INSERT INTO `SelectionOptions` (`SelectionID`, `SelectionName`, `Description`, `RedirectURL`) VALUES
(1, 'Quiz', 'Take a regular or student quiz', '/quizcategories'),
(2, 'Assessment', 'Complete an assessment', '/assessment'),
(3, 'Progress Status', 'View progress reports', '/progress-status'),
(4, 'Cultural Insight', 'Learn about cultural insights', '/cultural-insight');

-- --------------------------------------------------------

--
-- Table structure for table `UserAnswers`
--

CREATE TABLE `UserAnswers` (
  `UserAnswerID` int NOT NULL,
  `AttemptID` int NOT NULL,
  `QuestionID` int NOT NULL,
  `AnswerID` int NOT NULL,
  `IsCorrect` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `UserAttempts`
--

CREATE TABLE `UserAttempts` (
  `AttemptID` int NOT NULL,
  `UserID` varchar(50) NOT NULL,
  `QuizID` int NOT NULL,
  `AttemptDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Score` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `UserID` varchar(50) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `ProfilePicture` varchar(255) DEFAULT NULL,
  `Bio` text,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`UserID`, `Name`, `Email`, `Password`, `ProfilePicture`, `Bio`, `PhoneNumber`, `CreatedAt`) VALUES
('U001', 'Safa Yusuf', 'safa.yusuf@icloud.com', 'password123', NULL, 'Language enthusiast.', '123-456-7890', '2025-03-12 16:45:04'),
('U002', 'Sawsan Mounes', 'sawsan.mounes@hotmail.com', 'password456', NULL, 'Loves learning new languages.', '234-567-8901', '2025-03-12 16:45:04'),
('U003', 'Baris Ocalan', 'baris.ocalan@gmail.com', 'password789', NULL, 'Interested in grammar and syntax.', '345-678-9012', '2025-03-12 16:45:04'),
('U004', 'Adam Maayni', 'adam.maayni@gmail.com', 'password321', NULL, 'Enjoys quizzes and challenges.', '456-789-0123', '2025-03-12 16:45:04'),
('U1803', 'baris', 'baris@gmail.com', '$2b$10$ljdk61oVUFwEUP7mhRSQPORfalRY3DCFJT7fgZ4kvspKEHpp/0iqe', NULL, '123\r\n', '123', '2025-04-03 20:29:08'),
('U2210', 'bob', 'a@gmail.com', 's', NULL, 'ffg', '55', '2025-03-14 15:19:58'),
('U4131', 'woowop', 'hi@gmail.com', '$2b$10$R1I33e.y0/Mu7EHgf0Pr.utVKF7KZHgzu4wRb7KTPz1NFedvOEIcq', NULL, 'hi', '077', '2025-04-03 12:34:49');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `AssessmentAnswers`
--
ALTER TABLE `AssessmentAnswers`
  ADD PRIMARY KEY (`AnswerID`),
  ADD KEY `QuestionID` (`QuestionID`);

--
-- Indexes for table `AssessmentDetails`
--
ALTER TABLE `AssessmentDetails`
  ADD PRIMARY KEY (`AssessmentDetailID`),
  ADD KEY `LanguageID` (`LanguageID`);

--
-- Indexes for table `AssessmentQuestions`
--
ALTER TABLE `AssessmentQuestions`
  ADD PRIMARY KEY (`QuestionID`),
  ADD KEY `LanguageID` (`LanguageID`),
  ADD KEY `AssessmentDetailID` (`AssessmentDetailID`);

--
-- Indexes for table `AssessmentResponses`
--
ALTER TABLE `AssessmentResponses`
  ADD PRIMARY KEY (`ResponseID`),
  ADD KEY `AssessmentID` (`AssessmentID`),
  ADD KEY `QuestionID` (`QuestionID`),
  ADD KEY `SelectedAnswerID` (`SelectedAnswerID`);

--
-- Indexes for table `Assessments`
--
ALTER TABLE `Assessments`
  ADD PRIMARY KEY (`AssessmentID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `LanguageID` (`LanguageID`),
  ADD KEY `AssessmentDetailID` (`AssessmentDetailID`);

--
-- Indexes for table `CulturalInsights`
--
ALTER TABLE `CulturalInsights`
  ADD PRIMARY KEY (`InsightID`),
  ADD KEY `LanguageID` (`LanguageID`);

--
-- Indexes for table `GroupChatMembers`
--
ALTER TABLE `GroupChatMembers`
  ADD PRIMARY KEY (`MemberID`),
  ADD KEY `GroupChatID` (`GroupChatID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `GroupChatMessages`
--
ALTER TABLE `GroupChatMessages`
  ADD PRIMARY KEY (`MessageID`),
  ADD KEY `GroupChatID` (`GroupChatID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `GroupChats`
--
ALTER TABLE `GroupChats`
  ADD PRIMARY KEY (`GroupChatID`),
  ADD KEY `LanguageID` (`LanguageID`);

--
-- Indexes for table `LanguageList`
--
ALTER TABLE `LanguageList`
  ADD PRIMARY KEY (`LanguageID`),
  ADD UNIQUE KEY `LanguageName` (`LanguageName`);

--
-- Indexes for table `QuizAnswers`
--
ALTER TABLE `QuizAnswers`
  ADD PRIMARY KEY (`AnswerID`);

--
-- Indexes for table `QuizCategories`
--
ALTER TABLE `QuizCategories`
  ADD PRIMARY KEY (`CategoryID`);

--
-- Indexes for table `QuizDetails`
--
ALTER TABLE `QuizDetails`
  ADD PRIMARY KEY (`QuizID`),
  ADD KEY `fk_quizdetails_categories` (`CategoryID`);

--
-- Indexes for table `QuizQuestions`
--
ALTER TABLE `QuizQuestions`
  ADD PRIMARY KEY (`QuestionID`),
  ADD KEY `fk_questions_language` (`LanguageID`);

--
-- Indexes for table `SelectionOptions`
--
ALTER TABLE `SelectionOptions`
  ADD PRIMARY KEY (`SelectionID`);

--
-- Indexes for table `UserAnswers`
--
ALTER TABLE `UserAnswers`
  ADD PRIMARY KEY (`UserAnswerID`),
  ADD KEY `fk_useranswers_attempt` (`AttemptID`),
  ADD KEY `fk_useranswers_question` (`QuestionID`),
  ADD KEY `fk_useranswers_answer` (`AnswerID`);

--
-- Indexes for table `UserAttempts`
--
ALTER TABLE `UserAttempts`
  ADD PRIMARY KEY (`AttemptID`),
  ADD KEY `fk_userattempts_user` (`UserID`),
  ADD KEY `fk_userattempts_quiz` (`QuizID`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `AssessmentAnswers`
--
ALTER TABLE `AssessmentAnswers`
  MODIFY `AnswerID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=583;

--
-- AUTO_INCREMENT for table `AssessmentDetails`
--
ALTER TABLE `AssessmentDetails`
  MODIFY `AssessmentDetailID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `AssessmentQuestions`
--
ALTER TABLE `AssessmentQuestions`
  MODIFY `QuestionID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `AssessmentResponses`
--
ALTER TABLE `AssessmentResponses`
  MODIFY `ResponseID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Assessments`
--
ALTER TABLE `Assessments`
  MODIFY `AssessmentID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `CulturalInsights`
--
ALTER TABLE `CulturalInsights`
  MODIFY `InsightID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `GroupChatMembers`
--
ALTER TABLE `GroupChatMembers`
  MODIFY `MemberID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `GroupChatMessages`
--
ALTER TABLE `GroupChatMessages`
  MODIFY `MessageID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `GroupChats`
--
ALTER TABLE `GroupChats`
  MODIFY `GroupChatID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `SelectionOptions`
--
ALTER TABLE `SelectionOptions`
  MODIFY `SelectionID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `UserAnswers`
--
ALTER TABLE `UserAnswers`
  MODIFY `UserAnswerID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `UserAttempts`
--
ALTER TABLE `UserAttempts`
  MODIFY `AttemptID` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `AssessmentAnswers`
--
ALTER TABLE `AssessmentAnswers`
  ADD CONSTRAINT `assessmentanswers_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `AssessmentQuestions` (`QuestionID`);

--
-- Constraints for table `AssessmentDetails`
--
ALTER TABLE `AssessmentDetails`
  ADD CONSTRAINT `assessmentdetails_ibfk_1` FOREIGN KEY (`LanguageID`) REFERENCES `LanguageList` (`LanguageID`);

--
-- Constraints for table `AssessmentQuestions`
--
ALTER TABLE `AssessmentQuestions`
  ADD CONSTRAINT `assessmentquestions_ibfk_1` FOREIGN KEY (`LanguageID`) REFERENCES `LanguageList` (`LanguageID`),
  ADD CONSTRAINT `assessmentquestions_ibfk_2` FOREIGN KEY (`AssessmentDetailID`) REFERENCES `AssessmentDetails` (`AssessmentDetailID`);

--
-- Constraints for table `AssessmentResponses`
--
ALTER TABLE `AssessmentResponses`
  ADD CONSTRAINT `assessmentresponses_ibfk_1` FOREIGN KEY (`AssessmentID`) REFERENCES `Assessments` (`AssessmentID`),
  ADD CONSTRAINT `assessmentresponses_ibfk_2` FOREIGN KEY (`QuestionID`) REFERENCES `AssessmentQuestions` (`QuestionID`),
  ADD CONSTRAINT `assessmentresponses_ibfk_3` FOREIGN KEY (`SelectedAnswerID`) REFERENCES `AssessmentAnswers` (`AnswerID`);

--
-- Constraints for table `Assessments`
--
ALTER TABLE `Assessments`
  ADD CONSTRAINT `assessments_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`),
  ADD CONSTRAINT `assessments_ibfk_2` FOREIGN KEY (`LanguageID`) REFERENCES `LanguageList` (`LanguageID`),
  ADD CONSTRAINT `assessments_ibfk_3` FOREIGN KEY (`AssessmentDetailID`) REFERENCES `AssessmentDetails` (`AssessmentDetailID`);

--
-- Constraints for table `CulturalInsights`
--
ALTER TABLE `CulturalInsights`
  ADD CONSTRAINT `culturalinsights_ibfk_1` FOREIGN KEY (`LanguageID`) REFERENCES `LanguageList` (`LanguageID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `GroupChatMembers`
--
ALTER TABLE `GroupChatMembers`
  ADD CONSTRAINT `groupchatmembers_ibfk_1` FOREIGN KEY (`GroupChatID`) REFERENCES `GroupChats` (`GroupChatID`),
  ADD CONSTRAINT `groupchatmembers_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`);

--
-- Constraints for table `GroupChatMessages`
--
ALTER TABLE `GroupChatMessages`
  ADD CONSTRAINT `groupchatmessages_ibfk_1` FOREIGN KEY (`GroupChatID`) REFERENCES `GroupChats` (`GroupChatID`),
  ADD CONSTRAINT `groupchatmessages_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`);

--
-- Constraints for table `GroupChats`
--
ALTER TABLE `GroupChats`
  ADD CONSTRAINT `groupchats_ibfk_1` FOREIGN KEY (`LanguageID`) REFERENCES `LanguageList` (`LanguageID`);

--
-- Constraints for table `QuizDetails`
--
ALTER TABLE `QuizDetails`
  ADD CONSTRAINT `fk_quizdetails_categories` FOREIGN KEY (`CategoryID`) REFERENCES `QuizCategories` (`CategoryID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `QuizQuestions`
--
ALTER TABLE `QuizQuestions`
  ADD CONSTRAINT `fk_questions_language` FOREIGN KEY (`LanguageID`) REFERENCES `LanguageList` (`LanguageID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `UserAnswers`
--
ALTER TABLE `UserAnswers`
  ADD CONSTRAINT `fk_useranswers_answer` FOREIGN KEY (`AnswerID`) REFERENCES `QuizAnswers` (`AnswerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_useranswers_attempt` FOREIGN KEY (`AttemptID`) REFERENCES `UserAttempts` (`AttemptID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_useranswers_question` FOREIGN KEY (`QuestionID`) REFERENCES `QuizQuestions` (`QuestionID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `UserAttempts`
--
ALTER TABLE `UserAttempts`
  ADD CONSTRAINT `fk_userattempts_quiz` FOREIGN KEY (`QuizID`) REFERENCES `QuizDetails` (`QuizID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_userattempts_user` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
