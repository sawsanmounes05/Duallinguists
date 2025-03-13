-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Mar 13, 2025 at 06:29 PM
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
-- Database: `Duallinguist`
--

-- --------------------------------------------------------

--
-- Table structure for table `LanguageDetail`
--

CREATE TABLE `LanguageDetail` (
  `DetailID` varchar(10) NOT NULL,
  `LanguageID` int NOT NULL,
  `Description` text,
  `Region` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `LanguageDetail`
--

INSERT INTO `LanguageDetail` (`DetailID`, `LanguageID`, `Description`, `Region`) VALUES
('D1', 1, 'English is a widely spoken global language, originating from England and commonly used in business and international communication.', 'Worldwide'),
('D2', 2, 'Spanish is a Romance language originating from the Iberian Peninsula, spoken across Spain and Latin America.', 'Spain, Latin America'),
('D3', 3, 'French is a Romance language with Latin roots, spoken widely in Europe, Canada, and parts of Africa.', 'France, Canada, Africa'),
('D4', 4, 'Italian is a Romance language known for its musicality and is closely related to Latin.', 'Italy, Switzerland'),
('D5', 5, 'Turkish is a Turkic language with unique vowel harmony and agglutinative structure, spoken mainly in Turkey.', 'Turkey, Cyprus');

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
  `IsCorrect` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `QuizAnswers`
--

INSERT INTO `QuizAnswers` (`AnswerID`, `QuestionID`, `AnswerText`, `IsCorrect`) VALUES
(1, 1, 'She has gone to the store.', 0),
(2, 1, 'She had gone to the store.', 1),
(3, 1, 'She goes to the store.', 0),
(4, 2, 'Identify the semicolon usage;', 0),
(5, 2, 'Identify: the semicolon usage.', 1),
(6, 2, 'Identify; the semicolon usage.', 0),
(7, 3, 'Essential', 0),
(8, 3, 'Necessary', 1),
(9, 3, 'Unimportant', 0),
(10, 4, 'To provide statistical evidence', 0),
(11, 4, 'To persuade the reader', 1),
(12, 4, 'To describe a setting', 0),
(13, 5, 'The boy ran home.', 0),
(14, 5, 'Because the boy ran home, he was late.', 1),
(15, 5, 'The boy ran home because he was late.', 0),
(16, 6, 'The wind howled through the night.', 0),
(17, 6, 'The trees waved their hands.', 1),
(18, 6, 'The sun smiled at us.', 0),
(19, 7, 'He comido', 1),
(20, 7, 'Yo comé', 0),
(21, 7, 'Comí', 0),
(22, 8, 'Azul', 0),
(23, 8, 'Caminar', 0),
(24, 8, 'Feliz', 1),
(25, 9, 'Porque', 1),
(26, 9, 'Pero', 0),
(27, 9, 'Aunque', 0),
(28, 10, 'Tuve', 1),
(29, 10, 'Tuvé', 0),
(30, 10, 'Tienes', 0),
(31, 11, '\'Por\' expresses duration, \'Para\' expresses purpose', 1),
(32, 11, '\'Para\' expresses duration, \'Por\' expresses purpose', 0),
(33, 11, 'They are interchangeable', 0),
(34, 12, 'En mi opinión', 1),
(35, 12, 'Yo quiero', 0),
(36, 12, 'Me llamo', 0),
(37, 13, 'Elle est heureuse', 1),
(38, 13, 'Elle a heureuse', 0),
(39, 13, 'Elle heureux', 0),
(40, 14, 'Le', 1),
(41, 14, 'La', 0),
(42, 14, 'Les', 0),
(43, 15, 'Très', 1),
(44, 15, 'Peu', 0),
(45, 15, 'Beaucoup', 0),
(46, 16, 'J\'ai mangé une pomme.', 1),
(47, 16, 'Je mange une pomme.', 0),
(48, 16, 'Manger une pomme.', 0),
(49, 17, 'To express necessity', 0),
(50, 17, 'To express doubt or uncertainty', 1),
(51, 17, 'To indicate past actions', 0),
(52, 18, 'Avoir le cafard', 1),
(53, 18, 'Boire un coup', 0),
(54, 18, 'Coup de foudre', 0),
(55, 19, 'Buongiorno', 1),
(56, 19, 'Buonasera', 0),
(57, 19, 'Ciao', 0),
(58, 20, 'Mangiare', 1),
(59, 20, 'Bella', 0),
(60, 20, 'Gatto', 0),
(61, 21, 'E', 1),
(62, 21, 'Ma', 0),
(63, 21, 'O', 0),
(64, 22, 'Ho mangiato', 1),
(65, 22, 'Mangiai', 0),
(66, 22, 'Mangierò', 0),
(67, 23, 'Attendere (to wait)', 0),
(68, 23, 'Attendere (to pretend)', 1),
(69, 23, 'Aspettare (to wait)', 0),
(70, 24, 'Voglio andare', 1),
(71, 24, 'Vado a casa', 0),
(72, 24, 'Andrò a scuola', 0),
(73, 25, 'Merhaba', 1),
(74, 25, 'Selam', 0),
(75, 25, 'Nasılsın', 0),
(76, 26, 'Köpek', 1),
(77, 26, 'Büyük', 0),
(78, 26, 'Yavaş', 0),
(79, 27, 'Niçin', 1),
(80, 27, 'Nasıl', 0),
(81, 27, 'Kim', 0),
(82, 28, 'Ben okula gidiyorum.', 1),
(83, 28, 'Gidiyorum ben okula.', 0),
(84, 28, 'Okula ben gidiyorum.', 0),
(85, 29, '\'Var\' means exists, \'Yok\' means does not exist', 1),
(86, 29, '\'Var\' means does not exist, \'Yok\' means exists', 0),
(87, 29, 'They both mean the same', 0),
(88, 30, '-im', 1),
(89, 30, '-lar', 0),
(90, 30, '-de', 0);

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
  `QuestionText` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `QuizQuestions`
--

INSERT INTO `QuizQuestions` (`QuestionID`, `QuizID`, `QuestionText`) VALUES
(1, 1, 'Which sentence is in the present perfect tense?'),
(2, 1, 'Identify the correct use of a semicolon.'),
(3, 1, 'Which of the following words is a synonym for \"important\"?'),
(4, 2, 'What is the purpose of using rhetorical questions in persuasive writing?'),
(5, 2, 'Which of the following contains a subordinate clause?'),
(6, 2, 'In which sentence is a metaphor used?'),
(7, 1, 'What is the correct translation for \"I have eaten\" in Spanish?'),
(8, 1, 'Which of these Spanish words is an adjective?'),
(9, 1, 'What is the Spanish equivalent of the English word \"because\"?'),
(10, 2, 'Which of the following correctly conjugates \"tener\" in the preterite tense for \"yo\"?'),
(11, 2, 'What is the difference between \"por\" and \"para\" in Spanish?'),
(12, 2, 'Which of the following Spanish phrases expresses an opinion?'),
(13, 1, 'Which of these is the correct translation of \"She is happy\"?'),
(14, 1, 'Identify the correct definite article for \"livre\" (book).'),
(15, 1, 'What is the French equivalent of \"very\"?'),
(16, 2, 'Which of these sentences uses the passé composé correctly?'),
(17, 2, 'What is the function of the subjunctive mood in French?'),
(18, 2, 'Which of these is a correct French idiomatic expression?'),
(19, 1, 'Which is the correct translation of \"Good morning\" in Italian?'),
(20, 1, 'Which of these words is a verb in Italian?'),
(21, 1, 'What is the Italian word for \"and\"?'),
(22, 2, 'How do you correctly form the past tense of \"mangiare\" (to eat)?'),
(23, 2, 'Which of these Italian words is a false cognate?'),
(24, 2, 'Which of these phrases expresses future intention?'),
(25, 1, 'What is the correct translation of \"Hello\" in Turkish?'),
(26, 1, 'Which of these words is a noun in Turkish?'),
(27, 1, 'What is the Turkish equivalent of the word \"why\"?'),
(28, 2, 'Which of these sentences uses the correct word order in Turkish?'),
(29, 2, 'What is the difference between \"var\" and \"yok\" in Turkish?'),
(30, 2, 'Which Turkish suffix is used to express possession?');

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
('U004', 'Adam Maayni', 'adam.maayni@gmail.com', 'password321', NULL, 'Enjoys quizzes and challenges.', '456-789-0123', '2025-03-12 16:45:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `LanguageDetail`
--
ALTER TABLE `LanguageDetail`
  ADD PRIMARY KEY (`DetailID`),
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
  ADD PRIMARY KEY (`AnswerID`),
  ADD KEY `QuestionID` (`QuestionID`);

--
-- Indexes for table `QuizCategories`
--
ALTER TABLE `QuizCategories`
  ADD PRIMARY KEY (`CategoryID`),
  ADD UNIQUE KEY `CategoryName` (`CategoryName`);

--
-- Indexes for table `QuizDetails`
--
ALTER TABLE `QuizDetails`
  ADD PRIMARY KEY (`QuizID`);

--
-- Indexes for table `QuizQuestions`
--
ALTER TABLE `QuizQuestions`
  ADD PRIMARY KEY (`QuestionID`),
  ADD KEY `QuizID` (`QuizID`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `LanguageList`
--
ALTER TABLE `LanguageList`
  MODIFY `LanguageID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `QuizAnswers`
--
ALTER TABLE `QuizAnswers`
  MODIFY `AnswerID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `QuizCategories`
--
ALTER TABLE `QuizCategories`
  MODIFY `CategoryID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `QuizDetails`
--
ALTER TABLE `QuizDetails`
  MODIFY `QuizID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `QuizQuestions`
--
ALTER TABLE `QuizQuestions`
  MODIFY `QuestionID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `LanguageDetail`
--
ALTER TABLE `LanguageDetail`
  ADD CONSTRAINT `languagedetail_ibfk_1` FOREIGN KEY (`LanguageID`) REFERENCES `LanguageList` (`LanguageID`) ON DELETE CASCADE;

--
-- Constraints for table `QuizAnswers`
--
ALTER TABLE `QuizAnswers`
  ADD CONSTRAINT `quizanswers_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `QuizQuestions` (`QuestionID`) ON DELETE CASCADE;

--
-- Constraints for table `QuizQuestions`
--
ALTER TABLE `QuizQuestions`
  ADD CONSTRAINT `quizquestions_ibfk_1` FOREIGN KEY (`QuizID`) REFERENCES `QuizDetails` (`QuizID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
