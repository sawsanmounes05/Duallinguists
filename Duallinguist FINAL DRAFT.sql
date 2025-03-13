-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Mar 12, 2025 at 10:25 PM
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
  `IsCorrect` tinyint(1) NOT NULL DEFAULT '0',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `QuizAnswers`
--

INSERT INTO `QuizAnswers` (`AnswerID`, `QuestionID`, `AnswerText`, `IsCorrect`, `CreatedAt`) VALUES
(1, 1, 'She has gone to the store.', 0, '2025-03-12 22:19:38'),
(2, 1, 'She had gone to the store.', 1, '2025-03-12 22:19:38'),
(3, 1, 'She goes to the store.', 0, '2025-03-12 22:19:38'),
(4, 2, 'Identify the semicolon usage;', 0, '2025-03-12 22:19:38'),
(5, 2, 'Identify: the semicolon usage.', 1, '2025-03-12 22:19:38'),
(6, 2, 'Identify; the semicolon usage.', 0, '2025-03-12 22:19:38'),
(7, 3, 'Essential', 0, '2025-03-12 22:19:38'),
(8, 3, 'Necessary', 1, '2025-03-12 22:19:38'),
(9, 3, 'Unimportant', 0, '2025-03-12 22:19:38'),
(10, 4, 'To provide statistical evidence', 0, '2025-03-12 22:19:38'),
(11, 4, 'To persuade the reader', 1, '2025-03-12 22:19:38'),
(12, 4, 'To describe a setting', 0, '2025-03-12 22:19:38'),
(13, 5, 'The boy ran home.', 0, '2025-03-12 22:19:38'),
(14, 5, 'Because the boy ran home, he was late.', 1, '2025-03-12 22:19:38'),
(15, 5, 'The boy ran home because he was late.', 0, '2025-03-12 22:19:38'),
(16, 6, 'The wind howled through the night.', 0, '2025-03-12 22:19:38'),
(17, 6, 'The trees waved their hands.', 1, '2025-03-12 22:19:38'),
(18, 6, 'The sun smiled at us.', 0, '2025-03-12 22:19:38'),
(19, 7, 'He comido', 1, '2025-03-12 22:19:38'),
(20, 7, 'Yo comé', 0, '2025-03-12 22:19:38'),
(21, 7, 'Comí', 0, '2025-03-12 22:19:38'),
(22, 8, 'Azul', 0, '2025-03-12 22:19:38'),
(23, 8, 'Caminar', 0, '2025-03-12 22:19:38'),
(24, 8, 'Feliz', 1, '2025-03-12 22:19:38'),
(25, 9, 'Porque', 1, '2025-03-12 22:19:38'),
(26, 9, 'Pero', 0, '2025-03-12 22:19:38'),
(27, 9, 'Aunque', 0, '2025-03-12 22:19:38'),
(28, 10, 'Tuve', 1, '2025-03-12 22:19:38'),
(29, 10, 'Tuvé', 0, '2025-03-12 22:19:38'),
(30, 10, 'Tienes', 0, '2025-03-12 22:19:38'),
(31, 11, '\'Por\' expresses duration, \'Para\' expresses purpose', 1, '2025-03-12 22:19:38'),
(32, 11, '\'Para\' expresses duration, \'Por\' expresses purpose', 0, '2025-03-12 22:19:38'),
(33, 11, 'They are interchangeable', 0, '2025-03-12 22:19:38'),
(34, 12, 'En mi opinión', 1, '2025-03-12 22:19:38'),
(35, 12, 'Yo quiero', 0, '2025-03-12 22:19:38'),
(36, 12, 'Me llamo', 0, '2025-03-12 22:19:38'),
(37, 13, 'Elle est heureuse', 1, '2025-03-12 22:19:38'),
(38, 13, 'Elle a heureuse', 0, '2025-03-12 22:19:38'),
(39, 13, 'Elle heureux', 0, '2025-03-12 22:19:38'),
(40, 14, 'Le', 1, '2025-03-12 22:19:38'),
(41, 14, 'La', 0, '2025-03-12 22:19:38'),
(42, 14, 'Les', 0, '2025-03-12 22:19:38'),
(43, 15, 'Très', 1, '2025-03-12 22:19:38'),
(44, 15, 'Peu', 0, '2025-03-12 22:19:38'),
(45, 15, 'Beaucoup', 0, '2025-03-12 22:19:38'),
(46, 16, 'J\'ai mangé une pomme.', 1, '2025-03-12 22:19:38'),
(47, 16, 'Je mange une pomme.', 0, '2025-03-12 22:19:38'),
(48, 16, 'Manger une pomme.', 0, '2025-03-12 22:19:38'),
(49, 17, 'To express necessity', 0, '2025-03-12 22:19:38'),
(50, 17, 'To express doubt or uncertainty', 1, '2025-03-12 22:19:38'),
(51, 17, 'To indicate past actions', 0, '2025-03-12 22:19:38'),
(52, 18, 'Avoir le cafard', 1, '2025-03-12 22:19:38'),
(53, 18, 'Boire un coup', 0, '2025-03-12 22:19:38'),
(54, 18, 'Coup de foudre', 0, '2025-03-12 22:19:38'),
(55, 19, 'Buongiorno', 1, '2025-03-12 22:19:38'),
(56, 19, 'Buonasera', 0, '2025-03-12 22:19:38'),
(57, 19, 'Ciao', 0, '2025-03-12 22:19:38'),
(58, 20, 'Mangiare', 1, '2025-03-12 22:19:38'),
(59, 20, 'Bella', 0, '2025-03-12 22:19:38'),
(60, 20, 'Gatto', 0, '2025-03-12 22:19:38'),
(61, 21, 'E', 1, '2025-03-12 22:19:38'),
(62, 21, 'Ma', 0, '2025-03-12 22:19:38'),
(63, 21, 'O', 0, '2025-03-12 22:19:38'),
(64, 22, 'Ho mangiato', 1, '2025-03-12 22:19:38'),
(65, 22, 'Mangiai', 0, '2025-03-12 22:19:38'),
(66, 22, 'Mangierò', 0, '2025-03-12 22:19:38'),
(67, 23, 'Attendere (to wait)', 0, '2025-03-12 22:19:38'),
(68, 23, 'Attendere (to pretend)', 1, '2025-03-12 22:19:38'),
(69, 23, 'Aspettare (to wait)', 0, '2025-03-12 22:19:38'),
(70, 24, 'Voglio andare', 1, '2025-03-12 22:19:38'),
(71, 24, 'Vado a casa', 0, '2025-03-12 22:19:38'),
(72, 24, 'Andrò a scuola', 0, '2025-03-12 22:19:38'),
(73, 25, 'Merhaba', 1, '2025-03-12 22:19:38'),
(74, 25, 'Selam', 0, '2025-03-12 22:19:38'),
(75, 25, 'Nasılsın', 0, '2025-03-12 22:19:38'),
(76, 26, 'Köpek', 1, '2025-03-12 22:19:38'),
(77, 26, 'Büyük', 0, '2025-03-12 22:19:38'),
(78, 26, 'Yavaş', 0, '2025-03-12 22:19:38'),
(79, 27, 'Niçin', 1, '2025-03-12 22:19:38'),
(80, 27, 'Nasıl', 0, '2025-03-12 22:19:38'),
(81, 27, 'Kim', 0, '2025-03-12 22:19:38'),
(82, 28, 'Ben okula gidiyorum.', 1, '2025-03-12 22:19:38'),
(83, 28, 'Gidiyorum ben okula.', 0, '2025-03-12 22:19:38'),
(84, 28, 'Okula ben gidiyorum.', 0, '2025-03-12 22:19:38'),
(85, 29, '\'Var\' means exists, \'Yok\' means does not exist', 1, '2025-03-12 22:19:38'),
(86, 29, '\'Var\' means does not exist, \'Yok\' means exists', 0, '2025-03-12 22:19:38'),
(87, 29, 'They both mean the same', 0, '2025-03-12 22:19:38'),
(88, 30, '-im', 1, '2025-03-12 22:19:38'),
(89, 30, '-lar', 0, '2025-03-12 22:19:38'),
(90, 30, '-de', 0, '2025-03-12 22:19:38');

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
  `QuizTitle` varchar(255) NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `QuizDetails`
--

INSERT INTO `QuizDetails` (`QuizID`, `CategoryID`, `QuizTitle`, `CreatedAt`) VALUES
(1, 1, 'Basic Grammar Quiz', '2025-03-12 17:09:39'),
(2, 1, 'Vocabulary Quiz', '2025-03-12 17:09:39'),
(3, 2, 'GCSE Vocabulary Pratice', '2025-03-12 17:09:39'),
(4, 2, 'Comprehension Quiz', '2025-03-12 17:09:39');

-- --------------------------------------------------------

--
-- Table structure for table `QuizQuestions`
--

CREATE TABLE `QuizQuestions` (
  `QuestionID` int NOT NULL,
  `QuizID` int NOT NULL,
  `QuestionText` text NOT NULL,
  `QuestionType` enum('Multiple Choice') NOT NULL DEFAULT 'Multiple Choice',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `QuizQuestions`
--

INSERT INTO `QuizQuestions` (`QuestionID`, `QuizID`, `QuestionText`, `QuestionType`, `CreatedAt`) VALUES
(1, 1, 'Which sentence is in the present perfect tense?', 'Multiple Choice', '2025-03-12 22:11:03'),
(2, 1, 'Identify the correct use of a semicolon.', 'Multiple Choice', '2025-03-12 22:11:03'),
(3, 1, 'Which of the following words is a synonym for \"important\"?', 'Multiple Choice', '2025-03-12 22:11:03'),
(4, 3, 'What is the purpose of using rhetorical questions in persuasive writing?', 'Multiple Choice', '2025-03-12 22:11:03'),
(5, 3, 'Which of the following contains a subordinate clause?', 'Multiple Choice', '2025-03-12 22:11:03'),
(6, 3, 'In which sentence is a metaphor used?', 'Multiple Choice', '2025-03-12 22:11:03'),
(7, 1, 'What is the correct translation for \"I have eaten\" in Spanish?', 'Multiple Choice', '2025-03-12 22:11:03'),
(8, 1, 'Which of these Spanish words is an adjective?', 'Multiple Choice', '2025-03-12 22:11:03'),
(9, 1, 'What is the Spanish equivalent of the English word \"because\"?', 'Multiple Choice', '2025-03-12 22:11:03'),
(10, 3, 'Which of the following correctly conjugates \"tener\" in the preterite tense for \"yo\"?', 'Multiple Choice', '2025-03-12 22:11:03'),
(11, 3, 'What is the difference between \"por\" and \"para\" in Spanish?', 'Multiple Choice', '2025-03-12 22:11:03'),
(12, 3, 'Which of the following Spanish phrases expresses an opinion?', 'Multiple Choice', '2025-03-12 22:11:03'),
(13, 2, 'Which of these is the correct translation of \"She is happy\"?', 'Multiple Choice', '2025-03-12 22:11:03'),
(14, 2, 'Identify the correct definite article for \"livre\" (book).', 'Multiple Choice', '2025-03-12 22:11:03'),
(15, 2, 'What is the French equivalent of \"very\"?', 'Multiple Choice', '2025-03-12 22:11:03'),
(16, 4, 'Which of these sentences uses the passé composé correctly?', 'Multiple Choice', '2025-03-12 22:11:03'),
(17, 4, 'What is the function of the subjunctive mood in French?', 'Multiple Choice', '2025-03-12 22:11:03'),
(18, 4, 'Which of these is a correct French idiomatic expression?', 'Multiple Choice', '2025-03-12 22:11:03'),
(19, 2, 'Which is the correct translation of \"Good morning\" in Italian?', 'Multiple Choice', '2025-03-12 22:11:03'),
(20, 2, 'Which of these words is a verb in Italian?', 'Multiple Choice', '2025-03-12 22:11:03'),
(21, 2, 'What is the Italian word for \"and\"?', 'Multiple Choice', '2025-03-12 22:11:03'),
(22, 4, 'How do you correctly form the past tense of \"mangiare\" (to eat)?', 'Multiple Choice', '2025-03-12 22:11:03'),
(23, 4, 'Which of these Italian words is a false cognate?', 'Multiple Choice', '2025-03-12 22:11:03'),
(24, 4, 'Which of these phrases expresses future intention?', 'Multiple Choice', '2025-03-12 22:11:03'),
(25, 1, 'What is the correct translation of \"Hello\" in Turkish?', 'Multiple Choice', '2025-03-12 22:11:03'),
(26, 1, 'Which of these words is a noun in Turkish?', 'Multiple Choice', '2025-03-12 22:11:03'),
(27, 1, 'What is the Turkish equivalent of the word \"why\"?', 'Multiple Choice', '2025-03-12 22:11:03'),
(28, 3, 'Which of these sentences uses the correct word order in Turkish?', 'Multiple Choice', '2025-03-12 22:11:03'),
(29, 3, 'What is the difference between \"var\" and \"yok\" in Turkish?', 'Multiple Choice', '2025-03-12 22:11:03'),
(30, 3, 'Which Turkish suffix is used to express possession?', 'Multiple Choice', '2025-03-12 22:11:03');

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
  ADD PRIMARY KEY (`QuizID`),
  ADD KEY `CategoryID` (`CategoryID`);

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
  MODIFY `QuizID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
-- Constraints for table `QuizDetails`
--
ALTER TABLE `QuizDetails`
  ADD CONSTRAINT `quizdetails_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `QuizCategories` (`CategoryID`) ON DELETE CASCADE;

--
-- Constraints for table `QuizQuestions`
--
ALTER TABLE `QuizQuestions`
  ADD CONSTRAINT `quizquestions_ibfk_1` FOREIGN KEY (`QuizID`) REFERENCES `QuizDetails` (`QuizID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
