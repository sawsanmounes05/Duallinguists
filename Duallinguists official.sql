-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Mar 18, 2025 at 04:09 PM
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
-- Database: `Duallinguists`
--

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
('U2210', 'bob', 'a@gmail.com', 's', NULL, 'ffg', '55', '2025-03-14 15:19:58');

--
-- Indexes for dumped tables
--

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
