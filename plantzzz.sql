


DROP SCHEMA IF EXISTS plantzzz;
CREATE SCHEMA plantzzz;
USE plantzzz;


CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    UserType VARCHAR(255) NOT NULL
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    UserID INT,
    EnrollmentYear YEAR,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY,
    UserID INT,
    Title VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);



CREATE TABLE PlantNames (
    PlantID INT AUTO_INCREMENT PRIMARY KEY,
    LatinName VARCHAR(255) NOT NULL,
    CommonName VARCHAR(255) NOT NULL
);



CREATE TABLE semesters_info (
  semester_id INT AUTO_INCREMENT PRIMARY KEY,
  semester_name VARCHAR(255) NOT NULL
);


CREATE TABLE plants_semesters (
  id INT AUTO_INCREMENT PRIMARY KEY,
  plant_id INT NOT NULL,
  semester_id INT NOT NULL,
  FOREIGN KEY (plant_id) REFERENCES PlantNames(PlantID),
  FOREIGN KEY (semester_id) REFERENCES semesters_info(semester_id)
);


CREATE TABLE PlantImages (
    ImageID INT AUTO_INCREMENT PRIMARY KEY,
    PlantID INT,
    ImageURL VARCHAR(255) NOT NULL,
    FOREIGN KEY (PlantID) REFERENCES PlantNames(PlantID) ON DELETE CASCADE
);


CREATE TABLE Quizzes (
    QuizID INT AUTO_INCREMENT PRIMARY KEY,
    QuizName VARCHAR(255) NOT NULL,
    SemesterID INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (SemesterID) REFERENCES semesters_info(semester_id)
);



CREATE TABLE Questions (
    QuestionID INT AUTO_INCREMENT PRIMARY KEY,
    QuizID INT,
    PlantID INT,
    QuestionType VARCHAR(255), 
    QuestionText VARCHAR(1000),
    CorrectAnswer VARCHAR(255),
    FOREIGN KEY (QuizID) REFERENCES Quizzes(QuizID) ON DELETE CASCADE,
    FOREIGN KEY (PlantID) REFERENCES PlantNames(PlantID) ON DELETE CASCADE
);

CREATE TABLE QuestionOptions (
    OptionID INT AUTO_INCREMENT PRIMARY KEY,
    QuestionID INT,
    OptionLabel CHAR(1),
    OptionText VARCHAR(255), 
    IsCorrect BOOLEAN DEFAULT FALSE, 
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID) ON DELETE CASCADE
);


CREATE TABLE StudentQuizProgress (
    ProgressID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT NOT NULL,
    QuizID INT NOT NULL,
    StartTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    EndTimestamp TIMESTAMP,
    Score DECIMAL(5,2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (QuizID) REFERENCES Quizzes(QuizID) ON DELETE CASCADE
);

CREATE TABLE StudentQuizAnswers (
    AnswerID INT AUTO_INCREMENT PRIMARY KEY,
    ProgressID INT NOT NULL,
    QuestionID INT NOT NULL,
    SelectedOptionID INT,
    IsCorrect BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (ProgressID) REFERENCES StudentQuizProgress(ProgressID) ON DELETE CASCADE,
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID) ON DELETE CASCADE,
    FOREIGN KEY (SelectedOptionID) REFERENCES QuestionOptions(OptionID) ON DELETE SET NULL
);

-- Insert student users
INSERT INTO Users (Username, Password, Email, UserType) VALUES 
('StudentOne', 'password123', 'student1@example.com', 'student'),
('StudentTwo', 'password123', 'student2@example.com', 'student'),
('StudentThree', 'password123', 'student3@example.com', 'student');

-- Insert teacher users
INSERT INTO Users (Username, Password, Email, UserType) VALUES 
('TeacherOne', 'password123', 'teacher1@example.com', 'teacher'),
('TeacherTwo', 'password123', 'teacher2@example.com', 'teacher'),
('TeacherThree', 'password123', 'teacher3@example.com', 'teacher');

-- Assuming the UserIDs for students are 1, 2, and 3
INSERT INTO Students (StudentID, UserID, EnrollmentYear) VALUES 
(1001, 1, YEAR(CURRENT_DATE)),
(1002, 2, YEAR(CURRENT_DATE)),
(1003, 3, YEAR(CURRENT_DATE));

-- Assuming the UserIDs for teachers are 4, 5, and 6
INSERT INTO Teachers (TeacherID, UserID, Title) VALUES 
(2001, 4, 'teacher'),
(2002, 5, 'tutor'),
(2003, 6, 'tutor');





INSERT INTO `plantnames` (`PlantID`, `LatinName`, `CommonName`) VALUES
(1, 'Alectryon excelsus ', ' titoki'),
(2, 'Aucuba japonica ', ' spotted or Japanese laurel'),
(3, 'Azara microphylla ', ' vanilla tree'),
(4, 'Banksia integrifolia ', ' coastal banksia'),
(5, 'Brachyglottis greyi ', ' NZ daisy bush'),
(6, 'Carmichaelia williamsii ', ' NZ giant flowering broom'),
(7, 'Carpinus betulus ', ' European hornbeam'),
(8, 'Celmisia sp. ', ' mountain daisy'),
(9, 'Chionochloa flavicans ', ' miniature toetoe'),
(10, 'Coleonema pulchrum ''Sunset Gold'' ', ' confetti bush'),
(11, 'Coprosma repens ', ' mIrror bush or taupata'),
(12, 'Coprosma X kirkii ', ' groundcover coprosma'),
(13, 'Cornus alba ', ' Siberian dogwood'),
(14, 'Corokia X virgata ''Bronze King'' ', ' bronze corokia'),
(15, 'Cytisus proliferus ', ' tree lucerne or tagasaste'),
(16, 'Dianella sp. ''Little Rev'' ', ' dianella'),
(17, 'Dodonaea viscosa ''Purpurea'' ', ' akeake or hopbush'),
(18, 'Eucalyptus viminalis ', ' manna gum'),
(19, 'Fagus sylvatica ', ' common or English beech'),
(20, 'Festuca actae ', ' Banks Peninsula blue tussock'),
(21, 'Griselinia littoralis ', ' broadleaf or kapuka'),
(22, 'Hoheria angustifolia ', ' narrow leaved lacebark'),
(23, 'Hoheria sexstylosa ', ' lacebark or houhere'),
(24, 'Laurus nobilis ', ' bay tree'),
(25, 'Leonohebe cupressoides ', ' frangrant hebe'),
(26, 'Lomandra longifolia ', ' basket grass'),
(27, 'Magnolia liliflora ''Nigra'' ', ' deciduous magnolia'),
(28, 'Muehlenbeckia astonii ', ' shrubby tororaro'),
(29, 'Myoporum laetum ', ' ngaio'),
(30, 'Myosotidium hortensia ', ' Chatham Island forget me not'),
(31, 'Olea europaea ', ' olive tree'),
(32, 'Olearia lineata ', ' twiggy tree daisy'),
(33, 'Phebalium squameum ', ' satinwood'),
(34, 'Photinia X fraseri ''Robusta'' ', ' photinia'),
(35, 'Phormium cookianum ', ' wharariki or mountain Flax'),
(36, 'Phormium tenax ', ' harakeke or NZ flax'),
(37, 'Piper excelsum ', ' kawakawa'),
(38, 'Plagianthus divarivatus ', ' swamp ribbonwood'),
(39, 'Platanus orientalis ''Digitata'' ', ' cut leaf plane'),
(40, 'Polystichum vestitum ', ' prickly shield fern or puniu'),
(41, 'Pratia (syn. Lobelia) angulata ', ' panakenake'),
(42, 'Rosmarinus officinalis ', ' rosemary'),
(43, 'Skimmia japonica ', ' Japanese skimmia'),
(44, 'Sophora prostrata ', ' prostrate kowhai'),
(45, 'Teucridium parvifolium ', ' teucridium'),
(46, 'Tilia cordata ', ' lime tree'),
(47, 'Ulmus carpinifolia ''Variegata'' ', ' variegated elm'),
(48, 'Veronica speciosa  ', ' large leaved hebe'),
(49, 'Veronica topiaria ', ' topiary hebe'),
(50, 'Viburnum tinus ', ' laurustinus'),
(51, 'Acca sellowiana ', ' feijoa'),
(52, 'Acer palmatum ', ' Japanese maple'),
(53, 'Aesculus hippocastanum ', ' common horse chestnut'),
(54, 'Agave sp. ', ' agave'),
(55, 'Anigozanthos flavidus ', ' kangaroo paw'),
(56, 'Arbutus unedo ', ' strawberry tree'),
(57, 'Aristotelia serrata ', ' winberry or makomako'),
(58, 'Asplenium oblongifolium ', ' shining spleenwort'),
(59, 'Bergenia cordifolia ', ' heart leaf bergenia'),
(60, 'Brachychiton populneus ', ' kurrajong or bottletree'),
(61, 'Buxus sempervirens ', ' box hedge'),
(62, 'Callistemon sp. ', ' bottle brush'),
(63, 'Canna X generalis ', ' canna lily'),
(64, 'Cercis canadensis ''Texas White'' ', ' Texas white redbud'),
(65, 'Chimonanthus praecox ', ' wintersweet'),
(66, 'Choisya X dewitteana ''Aztec Pearl'' ', ' Mexican orange blossom'),
(67, 'Clivia sp. ', ' natal or bush lily'),
(68, 'Corylus avellana ', ' common hazel'),
(69, 'Cyclamen hederifolium ', ' ivy leaved cyclamen'),
(70, 'Daphne bholua ', ' Nepalese paper plant'),
(71, 'Daphne odora ', ' winter daphne'),
(72, 'Grevillea banksii X bipinnatifida ', ' grevillea'),
(73, 'Hamamelis mollis ', ' witch hazel'),
(74, 'Hydrangea quercifolia ''Pee Wee'' ', ' oak leaf hydrangea'),
(75, 'Knightia excelsa ', ' rewarewa (NZ honeysuckle)'),
(76, 'Lavandula X intermedia ', ' hybrid lavender'),
(77, 'Leucadendron salignum ', ' conebush'),
(78, 'Libertia ixioides ', ' NZ iris or mikoikoi'),
(79, 'Lomaria discolor ', ' crown fern'),
(80, 'Magnolia grandiflora ''Little Gem'' ', ' dwarf magnolia'),
(81, 'Magnolia X soulangeana ', ' saucer or Chinese magnolia'),
(82, 'Malus sp. ', ' apple tree'),
(83, 'Michelia yunnanensis ', ' evergreen michelia'),
(84, 'Nandina domestica ‘Pygmaea’ ', ' dwarf heavenly bamboo'),
(85, 'Pachysandra terminalis ', ' Japanese spurge'),
(86, 'Pieris japonica ', ' lily of the valley'),
(87, 'Polyspora axillaris ', ' fried egg plant'),
(88, 'Populus trichocarpa ', ' black cottonwood'),
(89, 'Protea neriifolia ', ' oleanderleaf protea'),
(90, 'Prunus laurocerasus ', ' cherry laurel'),
(91, 'Pyrus communis ', ' common pear'),
(92, 'Rhododendron sp. ', ' azalea'),
(93, 'Rhododendron sp. ', ' rhododendron'),
(94, 'Robinia pseudoacacia ''Lace Lady'' ', ' contoured black locust'),
(95, 'Rosa sp. ''Ivey Hall'' ', ' yellow floribunda rose'),
(96, 'Salvia officinalis ', ' common sage'),
(97, 'Santolina chamaecyparissus ', ' lavender cotton'),
(98, 'Sarcococca confusa ', ' sweet box'),
(99, 'Sequoia sempervirens ', ' redwood'),
(100, 'Zantedeschia aethiopica ', ' arum or calla Lily'),
(101, 'Acer griseum ', ' paperbark maple'),
(102, 'Anemanthele lessoniana ', ' wind grass'),
(103, 'Arthropodium cirratum ', ' rengarenga'),
(104, 'Astelia chathamica ', ' Chatham Islands astelia'),
(105, 'Austroderia richardii ', ' South Island toe toe'),
(106, 'Brachyglottis monroi ', ' Monro''s daisy'),
(107, 'Brachyglottis rotundifolia ', ' muttonbird scrub'),
(108, 'Carmichaelia appressa ', ' native prostrate broom'),
(109, 'Carmichaelia stevensonii ', ' weeping broom'),
(110, 'Coprosma acerosa ''Hawera'' ', ' Hawera sand coprosma'),
(111, 'Cordyline australis ', ' cabbage tree'),
(112, 'Cornus florida ', ' dogwood'),
(113, 'Corynocarpus laevigatus ', ' karaka or NZ laurel'),
(114, 'Dacrydium cupressinum ', ' rimu'),
(115, 'Dianella nigra ', ' turutu'),
(116, 'Dicksonia squarrosa ', ' wheki or rough tree fern'),
(117, 'Discaria toumatou ', ' matagouri'),
(118, 'Disphyma australe ', ' horokaka or native ice plant'),
(119, 'Fraxinus excelsior ', ' European or common ash'),
(120, 'Fuscospora cliffortioides ', ' mountain beech'),
(121, 'Fuscospora fusca ', ' red beech'),
(122, 'Ginkgo biloba ', ' maidenhair tree'),
(123, 'Griselinia littoralis ', ' NZ broadleaf or kapuka'),
(124, 'Haloregis erecta ''Purpurea'' ', ' toatoa'),
(125, 'Hoheria lyallii ', ' mountain lacebark'),
(126, 'Kunzea ericoides ', ' kanuka'),
(127, 'Libertia peregrinans ', ' NZ iris'),
(128, 'Liquidambar styraciflua ', ' American sweetgum'),
(129, 'Liriodendron tulipifera ', ' tulip tree'),
(130, 'Lophozonia menziesii ', ' silver beech'),
(131, 'Melicytus alpinus ', ' porcupine scrub'),
(132, 'Muehlenbeckia axillaris ', ' creeping muehlenbeckia'),
(133, 'Olearia cheesemanii ', ' NZ daisy bush'),
(134, 'Pimelea prostrata ', ' NZ daphne'),
(135, 'Pittosporum crassifolium ', ' karo'),
(136, 'Pittosporum eugenioides ', ' lemonwood or tarata'),
(137, 'Pittosporum tenuifolium ', ' kohuhu or black matipo'),
(138, 'Plagianthus regius ', ' lowland ribbonwood'),
(139, 'Platanus x acerifolia ', ' London plane'),
(140, 'Poa cita ', ' silver tussock'),
(141, 'Prunus x yedoensis ', ' Yoshino cherry'),
(142, 'Pseudopanax crassifolius ', ' lancewood'),
(143, 'Pseudopanax ferox ', ' fierce lancewood'),
(144, 'Quercus palustris ', ' pin oak'),
(145, 'Quercus robur ', ' English oak'),
(146, 'Solanum laciniatum ', ' poroporo'),
(147, 'Sophora microphylla ', ' South Island kowhai'),
(148, 'Sophora molloyi ''Dragons Gold'' ', ' Cook Strait kowhai'),
(149, 'Sophora tetraptera ', ' North Island kowhai'),
(150, 'Veronica hulkeana ', ' New Zeland lilac'),
(151, 'Agathis australis ', ' kauri'),
(152, 'Apodasmia similis ', ' oioi'),
(153, 'Camellia japonica ', ' Japanese camelia'),
(154, 'Camellia sasanqua ', ' autumn camellia'),
(155, 'Carex secta ', ' pukio'),
(156, 'Carex testacea ', ' orange sedge'),
(157, 'Carpodetus serratus ', ' marble leaf or putaputaweta'),
(158, 'Catalpa bignonioides ', ' Indian bean tree'),
(159, 'Choisya ternata ', ' Mexican orange blossom'),
(160, 'Clematis paniculata ', ' puawhananga'),
(161, 'Clianthus maximus ', ' kakabeak'),
(162, 'Coprosma propinqua ', ' mingimingi'),
(163, 'Coprosma rugosa ''Lobster'' ', ' red coprosma'),
(164, 'Cotinus coggygria ', ' smoke bush'),
(165, 'Cupressus macrocarpa ', ' macrocarpa'),
(166, 'Cupressus sempervirens ', ' Italian cypress'),
(167, 'Dracophyllum sinclairii ', ' inaka or neinei'),
(168, 'Euphorbia glauca ', ' shore spurge or waiuatua'),
(169, 'Ficus pumila ', ' creeping fig'),
(170, 'Fuchsia procumbens ', ' creeping fuchsia'),
(171, 'Fuscospora solandri ', ' black beech'),
(172, 'Helleborus orientalis ', ' lenten rose'),
(173, 'Hydrangea macrophylla ', ' mophead hydrangea'),
(174, 'Hydrangea paniculata ', ' panicled hydrangea'),
(175, 'Juncus pallidus ', ' giant club rush'),
(176, 'Lophomyrtus obcordata ', ' rohutu or NZ myrtle'),
(177, 'Lophomyrtus x ralphii ', ' hybrid lophomyrtus or NZ myrtle'),
(178, 'Melicytus ramiflorus ', ' mahoe or whiteywood'),
(179, 'Microleana avenacea ', ' bush rice grass'),
(180, 'Muehlenbeckia complexa ', ' small leaved pohuehue'),
(181, 'Nepeta mussinii ', ' cat mint'),
(182, 'Pachystegia insignis ', ' Malborough rock daisy'),
(183, 'Pachystegia rufa ', ' Marlborough rock daisy'),
(184, 'Pectinopitys ferruginea ', ' miro'),
(185, 'Phyllocladus alpinus ', ' mountain toatoa or celery pine'),
(186, 'Phyllocladus trichomanoides ', ' tenakaha'),
(187, 'Pittosporum tenuifolium ''Sumo'' ', ' dwarf pittosporum'),
(188, 'Podocarpus laetus ', ' mountain or Hall''s totara'),
(189, 'Podocarpus nivalis ', ' snow or mountain totara'),
(190, 'Podocarpus totara ', ' totara'),
(191, 'Prumnopitys taxifolia ', ' matai'),
(192, 'Pseudopanax lessonii ', ' houpara'),
(193, 'Pseudowintera colorata ', ' horopito or pepper tree'),
(194, 'Quercus rubra ', ' red oak'),
(195, 'Rubus cissoides ', ' bush lawyer'),
(196, 'Sedum spectabile ''Autumn Joy'' ', ' stonecrop'),
(197, 'Sorbus aucuparia ', ' rowan'),
(198, 'Typha orientalis ', ' raupo or bullrush'),
(199, 'Veronica odora ''Prostrata'' ', ' prostrate hebe'),
(200, 'Wisteria sinensis ', ' Chinese wisteria');


INSERT INTO semesters_info (semester_name) 
VALUES 
    ('LASC 206_S2'),
    ('LASC 206_S2'),
    ('LASC 211_S1'),
    ('LASC 211_S1');



INSERT INTO plants_semesters (plant_id, semester_id) 
VALUES (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 1), (11, 1), (12, 1), (13, 1), (14, 1), (15, 1), (16, 1), (17, 1), (18, 1), (19, 1), (20, 1), (21, 1), (22, 1), (23, 1), (24, 1), (25, 1), (26, 1), (27, 1), (28, 1), (29, 1), (30, 1), (31, 1), (32, 1), (33, 1), (34, 1), (35, 1), (36, 1), (37, 1), (38, 1), (39, 1), (40, 1), (41, 1), (42, 1), (43, 1), (44, 1), (45, 1), (46, 1), (47, 1), (48, 1), (49, 1), (50, 1), (51, 2), (52, 2), (53, 2), (54, 2), (55, 2), (56, 2), (57, 2), (58, 2), (59, 2), (60, 2), (61, 2), (62, 2), (63, 2), (64, 2), (65, 2), (66, 2), (67, 2), (68, 2), (69, 2), (70, 2), (71, 2), (72, 2), (73, 2), (74, 2), (75, 2), (76, 2), (77, 2), (78, 2), (79, 2), (80, 2), (81, 2), (82, 2), (83, 2), (84, 2), (85, 2), (86, 2), (87, 2), (88, 2), (89, 2), (90, 2), (91, 2), (92, 2), (93, 2), (94, 2), (95, 2), (96, 2), (97, 2), (98, 2), (99, 2), (100, 2), (101, 3), (102, 3), (103, 3), (104, 3), (105, 3), (106, 3), (107, 3), (108, 3), (109, 3), (110, 3), (111, 3), (112, 3), (113, 3), (114, 3), (115, 3), (116, 3), (117, 3), (118, 3), (119, 3), (120, 3), (121, 3), (122, 3), (123, 3), (124, 3), (125, 3), (126, 3), (127, 3), (128, 3), (129, 3), (130, 3), (131, 3), (132, 3), (133, 3), (134, 3), (135, 3), (136, 3), (137, 3), (138, 3), (139, 3), (140, 3), (141, 3), (142, 3), (143, 3), (144, 3), (145, 3), (146, 3), (147, 3), (148, 3), (149, 3), (150, 3), (151, 4), (152, 4), (153, 4), (154, 4), (155, 4), (156, 4), (157, 4), (158, 4), (159, 4), (160, 4), (161, 4), (162, 4), (163, 4), (164, 4), (165, 4), (166, 4), (167, 4), (168, 4), (169, 4), (170, 4), (171, 4), (172, 4), (173, 4), (174, 4), (175, 4), (176, 4), (177, 4), (178, 4), (179, 4), (180, 4), (181, 4), (182, 4), (183, 4), (184, 4), (185, 4), (186, 4), (187, 4), (188, 4), (189, 4), (190, 4), (191, 4), (192, 4), (193, 4), (194, 4), (195, 4), (196, 4), (197, 4), (198, 4), (199, 4),(200, 4);

INSERT INTO Quizzes (QuizName, SemesterID, CreatedAt) 
VALUES 
('LASC206 Plant Quiz 1', 1, NOW()),
('LASC206 Plant Quiz 2', 2, NOW()),
('LASC211 Plant Quiz 1', 3, NOW()),
('LASC211 Plant Quiz 2', 4, NOW());


-- PLANT ID 1-50 TRUE or FALSE

-- PlantID 1: Alectryon excelsus (titoki)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 1, 'true_false', 'Is the Latin name of titoki "Alectryon excelsus"?', 'True');

-- PlantID 2: Aucuba japonica (spotted or Japanese laurel)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 2, 'true_false', 'Is the spotted or Japanese laurel known scientifically as "Azara microphylla"?', 'False');

-- PlantID 3: Azara microphylla (vanilla tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 3, 'true_false', 'Is "Azara microphylla" the correct Latin name for the vanilla tree?', 'True');

-- PlantID 4: Banksia integrifolia (coastal banksia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 4, 'true_false', 'Is the coastal banksia known scientifically as "Carpinus betulus"?', 'False');

-- PlantID 5: Brachyglottis greyi (NZ daisy bush)
INSERT INTO Questions (QuizID,  PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 5, 'true_false', 'Is the NZ daisy bush correctly identified as "Brachyglottis greyi"?', 'True');

-- PlantID 6: Carmichaelia williamsii (NZ giant flowering broom)
INSERT INTO Questions (QuizID,  PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 6, 'true_false', 'Is "Carmichaelia williamsii" known as the coastal banksia?', 'False');

-- PlantID 7: Carpinus betulus (European hornbeam)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 7, 'true_false', 'Is the European hornbeam known scientifically as "Carpinus betulus"?', 'True');

-- PlantID 8: Celmisia sp. (mountain daisy)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 8, 'true_false', 'Does the mountain daisy belong to the genus "Aucuba"?', 'False');

-- PlantID 9: Chionochloa flavicans (miniature toetoe)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 9,'true_false', 'Is "Chionochloa flavicans" the correct Latin name for miniature toetoe?', 'True');

-- PlantID 10: Coleonema pulchrum 'Sunset Gold' (confetti bush)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 10, 'true_false', 'Is the confetti bush known scientifically as "Dacrydium cupressinum"?', 'False');

-- PlantID 11: Coprosma repens (mirror bush or taupata)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 11,'true_false', 'Is the mirror bush or taupata known scientifically as "Coprosma repens"?', 'True');

-- PlantID 12: Coprosma X kirkii (groundcover coprosma)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 12, 'true_false', 'Is "Coprosma X kirkii" the correct Latin name for the coastal banksia?', 'False');

-- PlantID 13: Cornus alba (Siberian dogwood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 13,'true_false', 'Is the Siberian dogwood known scientifically as "Cornus alba"?', 'True');

-- PlantID 14: Corokia X virgata 'Bronze King' (bronze corokia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 14, 'true_false', 'Is "Corokia X virgata \'Bronze King\'" the correct Latin name for the vanilla tree?', 'False');

-- PlantID 15: Cytisus proliferus (tree lucerne or tagasaste)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 15, 'true_false', 'Is the tree lucerne or tagasaste correctly identified as "Cytisus proliferus"?', 'True');

-- PlantID 16: Dianella sp. 'Little Rev' (dianella)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 16, 'true_false', 'Is "Dianella sp. \'Little Rev\'" known as the European hornbeam?', 'False');

-- PlantID 17: Dodonaea viscosa 'Purpurea' (akeake or hopbush)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 17, 'true_false', 'Is the akeake or hopbush known scientifically as "Dodonaea viscosa \'Purpurea\'"?', 'True');

-- PlantID 18: Eucalyptus viminalis (manna gum)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 18, 'true_false', 'Does the manna gum belong to the genus "Eucalyptus"?', 'True');

-- PlantID 19: Fagus sylvatica (common or English beech)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 19, 'true_false', 'Is "Fagus sylvatica" the correct Latin name for the common or English beech?', 'True');

-- PlantID 20: Festuca actae (Banks Peninsula blue tussock)
INSERT INTO Questions (QuizID,  PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 20, 'true_false', 'Is the Banks Peninsula blue tussock known scientifically as "Festuca actae"?', 'True');

-- PlantID 21: Griselinia littoralis (broadleaf or kapuka)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 21, 'true_false', 'Is the broadleaf or kapuka known scientifically as "Griselinia littoralis"?', 'True');

-- PlantID 22: Hoheria angustifolia (narrow leaved lacebark)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 22, 'true_false', 'Is "Hoheria angustifolia" the correct Latin name for the narrow leaved lacebark?', 'True');

-- PlantID 23: Hoheria sexstylosa (lacebark or houhere)
INSERT INTO Questions (QuizID,  PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 23, 'true_false', 'Is the lacebark or houhere known scientifically as "Dacrydium cupressinum"?', 'False');

-- PlantID 24: Laurus nobilis (bay tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 24, 'true_false', 'Does the bay tree belong to the species "Laurus nobilis"?', 'True');

-- PlantID 25: Leonohebe cupressoides (fragrant hebe)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 25, 'true_false', 'Is "Leonohebe cupressoides" known as the fragrant hebe?', 'True');

-- PlantID 26: Lomandra longifolia (basket grass)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 26, 'true_false', 'Is the basket grass correctly identified as "Lomandra longifolia"?', 'True');

-- PlantID 27: Magnolia liliflora 'Nigra' (deciduous magnolia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 27, 'true_false', 'Is "Magnolia liliflora \'Nigra\'" the correct Latin name for the deciduous magnolia?', 'True');

-- PlantID 28: Muehlenbeckia astonii (shrubby tororaro)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 28, 'true_false', 'Is the shrubby tororaro known scientifically as "Muehlenbeckia astonii"?', 'True');

-- PlantID 29: Myoporum laetum (ngaio)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 29, 'true_false', 'Does the ngaio belong to the genus "Myoporum"?', 'True');

-- PlantID 30: Myosotidium hortensia (Chatham Island forget-me-not)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 30, 'true_false', 'Is the Chatham Island forget-me-not known scientifically as "Myosotidium hortensia"?', 'True');

-- PlantID 31: Olea europaea (olive tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 31, 'true_false', 'Is the olive tree known scientifically as "Olea europaea"?', 'True');

-- PlantID 32: Olearia lineata (twiggy tree daisy)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 32, 'true_false', 'Is "Olearia lineata" the correct Latin name for the twiggy tree daisy?', 'True');

-- PlantID 33: Phebalium squameum (satinwood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 33, 'true_false', 'Is the satinwood known scientifically as "Phebalium squameum"?', 'True');

-- PlantID 34: Photinia X fraseri 'Robusta' (photinia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 34, 'true_false', 'Does the photinia belong to the species "Photinia X fraseri \'Robusta\'"?', 'True');

-- PlantID 35: Phormium cookianum (wharariki or mountain flax)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 35, 'true_false', 'Is "Phormium cookianum" known as the wharariki or mountain flax?', 'True');

-- PlantID 36: Phormium tenax (harakeke or NZ flax)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 36, 'true_false', 'Is the harakeke or NZ flax correctly identified as "Phormium tenax"?', 'True');

-- PlantID 37: Piper excelsum (kawakawa)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 37, 'true_false', 'Is the kawakawa known scientifically as "Piper excelsum"?', 'True');

-- PlantID 38: Plagianthus divaricatus (swamp ribbonwood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 38, 'true_false', 'Does the swamp ribbonwood belong to the species "Plagianthus divaricatus"?', 'True');

-- PlantID 39: Platanus orientalis 'Digitata' (cut leaf plane)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 39, 'true_false', 'Is "Platanus orientalis \'Digitata\'" the correct Latin name for the cut leaf plane?', 'True');

-- PlantID 40: Polystichum vestitum (prickly shield fern or puniu)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 40, 'true_false', 'Is the prickly shield fern or puniu known scientifically as "Polystichum vestitum"?', 'True');

-- PlantID 41: Pratia angulata (panakenake)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 41, 'true_false', 'Is the panakenake known scientifically as "Polystichum vestitum"?', 'False');

-- PlantID 42: Rosmarinus officinalis (rosemary)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 42, 'true_false', 'Is "Rosmarinus officinalis" the correct Latin name for the kawakawa?', 'False');

-- PlantID 43: Skimmia japonica (Japanese skimmia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 43, 'true_false', 'Is the Japanese skimmia correctly identified as "Skimmia japonica"?', 'True');

-- PlantID 44: Sophora prostrata (prostrate kowhai)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 44, 'true_false', 'Is the prostrate kowhai known scientifically as "Dacrydium cupressinum"?', 'False');

-- PlantID 45: Teucridium parvifolium (teucridium)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 45, 'true_false', 'Does the teucridium belong to the species "Teucridium parvifolium"?', 'True');

-- PlantID 46: Tilia cordata (lime tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 46, 'true_false', 'Is the lime tree correctly identified as "Tilia cordata"?', 'True');

-- PlantID 47: Ulmus carpinifolia 'Variegata' (variegated elm)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 47, 'true_false', 'Is "Ulmus carpinifolia \'Variegata\'" known as the NZ daisy bush?', 'False');

-- PlantID 48: Veronica speciosa (large leaved hebe)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 48, 'true_false', 'Does the large leaved hebe belong to the species "Veronica speciosa"?', 'True');

-- PlantID 49: Veronica topiaria (topiary hebe)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 49, 'true_false', 'Is the topiary hebe known scientifically as "Veronica topiaria"?', 'True');

-- PlantID 50: Viburnum tinus (laurustinus)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(1, 50, 'true_false', 'Is "Viburnum tinus" the correct Latin name for the manna gum?', 'False');



-- PLANT ID 1-50 multi choice

-- Question 51 for PlantID 1
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 1, 'multiple_choice', 'What is the Latin name of "titoki"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(51, 'A', 'Banksia integrifolia', FALSE),
(51, 'B', 'Carpinus betulus', FALSE),
(51, 'C', 'Coleonema pulchrum', FALSE),
(51, 'D', 'Alectryon excelsus', TRUE);

-- Question 52 for PlantID 2
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 2, 'multiple_choice', 'What is the Latin name of "spotted or Japanese laurel"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(52, 'A', 'Aucuba japonica', TRUE),
(52, 'B', 'Dodonaea viscosa', FALSE),
(52, 'C', 'Azara microphylla', FALSE),
(52, 'D', 'Brachyglottis greyi', FALSE);

-- Question 53 for PlantID 3
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 3, 'multiple_choice', 'What is the Latin name of "vanilla tree"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(53, 'A', 'Carpinus betulus', FALSE),
(53, 'B', 'Azara microphylla', TRUE),
(53, 'C', 'Chionochloa flavicans', FALSE),
(53, 'D', 'Dodonaea viscosa', FALSE);

-- Question 54 for PlantID 4
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 4, 'multiple_choice', 'What is the Latin name of "coastal banksia"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(54, 'A', 'Coleonema pulchrum', FALSE),
(54, 'B', 'Alectryon excelsus', FALSE),
(54, 'C', 'Banksia integrifolia', TRUE),
(54, 'D', 'Azara microphylla', FALSE);

-- Question 55 for PlantID 5
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 5, 'multiple_choice', 'What is the Latin name of "NZ daisy bush"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(55, 'A', 'Dodonaea viscosa', FALSE),
(55, 'B', 'Carpinus betulus', FALSE),
(55, 'C', 'Aucuba japonica', FALSE),
(55, 'D', 'Brachyglottis greyi', TRUE);

-- Question 56 for PlantID 6
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 6, 'multiple_choice', 'What is the Latin name of "NZ giant flowering broom"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(56, 'A', 'Carmichaelia williamsii', TRUE),
(56, 'B', 'Azara microphylla', FALSE),
(56, 'C', 'Banksia integrifolia', FALSE),
(56, 'D', 'Coleonema pulchrum', FALSE);

-- Question 57 for PlantID 7
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 7, 'multiple_choice', 'What is the Latin name of "European hornbeam"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(57, 'A', 'Dodonaea viscosa', FALSE),
(57, 'B', 'Carpinus betulus', TRUE),
(57, 'C', 'Brachyglottis greyi', FALSE),
(57, 'D', 'Aucuba japonica', FALSE);

-- Question 58 for PlantID 8
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 8, 'multiple_choice', 'What is the Latin name of "mountain daisy"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(58, 'A', 'Azara microphylla', FALSE),
(58, 'B', 'Banksia integrifolia', FALSE),
(58, 'C', 'Celmisia sp.', TRUE),
(58, 'D', 'Dodonaea viscosa', FALSE);

-- Question 59 for PlantID 9
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 9, 'multiple_choice', 'What is the Latin name of "miniature toetoe"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(59, 'A', 'Aucuba japonica', FALSE),
(59, 'B', 'Carpinus betulus', FALSE),
(59, 'C', 'Brachyglottis greyi', FALSE),
(59, 'D', 'Chionochloa flavicans', TRUE);

-- Question 60 for PlantID 10
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 10, 'multiple_choice', 'What is the Latin name of "confetti bush"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(60, 'A', 'Coleonema pulchrum', TRUE),
(60, 'B', 'Carmichaelia williamsii', FALSE),
(60, 'C', 'Celmisia sp.', FALSE),
(60, 'D', 'Chionochloa flavicans', FALSE);

-- Question 61 for PlantID 11
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 11, 'multiple_choice', 'What is the Latin name of "mirror bush or taupata"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(61, 'A', 'Dodonaea viscosa', FALSE),
(61, 'B', 'Banksia integrifolia', FALSE),
(61, 'C', 'Coprosma repens', TRUE),
(61, 'D', 'Carpinus betulus', FALSE);

-- Question 62 for PlantID 12
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 12, 'multiple_choice', 'What is the Latin name of "groundcover coprosma"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(62, 'A', 'Celmisia sp.', FALSE),
(62, 'B', 'Chionochloa flavicans', FALSE),
(62, 'C', 'Coleonema pulchrum', FALSE),
(62, 'D', 'Coprosma X kirkii', TRUE);


-- Question 63 for PlantID 13
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 13, 'multiple_choice', 'What is the Latin name of "Siberian dogwood"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(63, 'A', 'Cornus alba', TRUE),
(63, 'B', 'Dodonaea viscosa', FALSE),
(63, 'C', 'Carpinus betulus', FALSE),
(63, 'D', 'Coprosma repens', FALSE);

-- Question 64 for PlantID 14
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 14, 'multiple_choice', 'What is the Latin name of "bronze corokia"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(64, 'A', 'Coprosma X kirkii', FALSE),
(64, 'B', 'Corokia X virgata ''Bronze King''', TRUE),
(64, 'C', 'Celmisia sp.', FALSE),
(64, 'D', 'Chionochloa flavicans', FALSE);

-- Question 65 for PlantID 15
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 15, 'multiple_choice', 'What is the Latin name of "tree lucerne or tagasaste"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(65, 'A', 'Dodonaea viscosa', FALSE),
(65, 'B', 'Coprosma repens', FALSE),
(65, 'C', 'Cytisus proliferus', TRUE),
(65, 'D', 'Cornus alba', FALSE);

-- Question 66 for PlantID 16
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 16, 'multiple_choice', 'What is the Latin name of "dianella"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(66, 'A', 'Corokia X virgata ''Bronze King''', FALSE),
(66, 'B', 'Celmisia sp.', FALSE),
(66, 'C', 'Chionochloa flavicans', FALSE),
(66, 'D', 'Dianella sp. ''Little Rev''', TRUE);

-- Question 67 for PlantID 17
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 17, 'multiple_choice', 'What is the Latin name of "akeake or hopbush"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(67, 'A', 'Dodonaea viscosa ''Purpurea''', TRUE),
(67, 'B', 'Cytisus proliferus', FALSE),
(67, 'C', 'Cornus alba', FALSE),
(67, 'D', 'Coprosma X kirkii', FALSE);

-- Question 68 for PlantID 18
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 18, 'multiple_choice', 'What is the Latin name of "manna gum"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(68, 'A', 'Corokia X virgata ''Bronze King''', FALSE),
(68, 'B', 'Eucalyptus viminalis', TRUE),
(68, 'C', 'Dianella sp. ''Little Rev''', FALSE),
(68, 'D', 'Dodonaea viscosa ''Purpurea''', FALSE);

-- Question 69 for PlantID 19
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 19, 'multiple_choice', 'What is the Latin name of "common or English beech"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(69, 'A', 'Dianella sp. ''Little Rev''', FALSE),
(69, 'B', 'Eucalyptus viminalis', FALSE),
(69, 'C', 'Fagus sylvatica', TRUE),
(69, 'D', 'Dodonaea viscosa ''Purpurea''', FALSE);

-- Question 70 for PlantID 20
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 20, 'multiple_choice', 'What is the Latin name of "Banks Peninsula blue tussock"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(70, 'A', 'Eucalyptus viminalis', FALSE),
(70, 'B', 'Fagus sylvatica', FALSE),
(70, 'C', 'Dodonaea viscosa ''Purpurea''', FALSE),
(70, 'D', 'Festuca actae', TRUE);

-- Question 71 for PlantID 21
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 21, 'multiple_choice', 'What is the Latin name of "broadleaf or kapuka"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(71, 'A', 'Griselinia littoralis', TRUE),
(71, 'B', 'Fagus sylvatica', FALSE),
(71, 'C', 'Dodonaea viscosa ''Purpurea''', FALSE),
(71, 'D', 'Eucalyptus viminalis', FALSE);

-- Question 72 for PlantID 22
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 22, 'multiple_choice', 'What is the Latin name of "narrow leaved lacebark"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(72, 'A', 'Hoheria angustifolia', TRUE),
(72, 'B', 'Festuca actae', FALSE),
(72, 'C', 'Eucalyptus viminalis', FALSE),
(72, 'D', 'Fagus sylvatica', FALSE);

-- Question 73 for PlantID 23
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 23, 'multiple_choice', 'What is the Latin name of "lacebark or houhere"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(73, 'A', 'Festuca actae', FALSE),
(73, 'B', 'Hoheria sexstylosa', TRUE),
(73, 'C', 'Griselinia littoralis', FALSE),
(73, 'D', 'Hoheria angustifolia', FALSE);



-- Question 74 for PlantID 24
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 24, 'multiple_choice', 'What is the Latin name of "bay tree"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(74, 'A', 'Hoheria sexstylosa', FALSE),
(74, 'B', 'Festuca actae', FALSE),
(74, 'C', 'Laurus nobilis', TRUE),
(74, 'D', 'Hoheria angustifolia', FALSE);

-- Question 75 for PlantID 25
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 25, 'multiple_choice', 'What is the Latin name of "frangrant hebe"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(75, 'A', 'Hoheria angustifolia', FALSE),
(75, 'B', 'Griselinia littoralis', FALSE),
(75, 'C', 'Festuca actae', FALSE),
(75, 'D', 'Leonohebe cupressoides', TRUE);

-- Question 76 for PlantID 26
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 26, 'multiple_choice', 'What is the Latin name of "basket grass"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(76, 'A', 'Lomandra longifolia', TRUE),
(76, 'B', 'Leonohebe cupressoides', FALSE),
(76, 'C', 'Laurus nobilis', FALSE),
(76, 'D', 'Hoheria sexstylosa', FALSE);

-- Question 77 for PlantID 27
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 27, 'multiple_choice', 'What is the Latin name of "deciduous magnolia"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(77, 'A', 'Leonohebe cupressoides', FALSE),
(77, 'B', 'Magnolia liliflora ''Nigra''', TRUE),
(77, 'C', 'Lomandra longifolia', FALSE),
(77, 'D', 'Laurus nobilis', FALSE);

-- Question 78 for PlantID 28
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 28, 'multiple_choice', 'What is the Latin name of "shrubby tororaro"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(78, 'A', 'Lomandra longifolia', FALSE),
(78, 'B', 'Leonohebe cupressoides', FALSE),
(78, 'C', 'Muehlenbeckia astonii', TRUE),
(78, 'D', 'Magnolia liliflora ''Nigra''', FALSE);

-- Question 79 for PlantID 29
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 29, 'multiple_choice', 'What is the Latin name of "ngaio"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(79, 'A', 'Magnolia liliflora ''Nigra''', FALSE),
(79, 'B', 'Lomandra longifolia', FALSE),
(79, 'C', 'Leonohebe cupressoides', FALSE),
(79, 'D', 'Myoporum laetum', TRUE);

-- Question 80 for PlantID 30
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 30, 'multiple_choice', 'What is the Latin name of "Chatham Island forget me not"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(80, 'A', 'Myosotidium hortensia', TRUE),
(80, 'B', 'Muehlenbeckia astonii', FALSE),
(80, 'C', 'Magnolia liliflora ''Nigra''', FALSE),
(80, 'D', 'Lomandra longifolia', FALSE);

-- Question 81 for PlantID 31
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 31, 'multiple_choice', 'What is the Latin name of "olive tree"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(81, 'A', 'Myosotidium hortensia', FALSE),
(81, 'B', 'Olea europaea', TRUE),
(81, 'C', 'Myoporum laetum', FALSE),
(81, 'D', 'Muehlenbeckia astonii', FALSE);

-- Question 82 for PlantID 32
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 32, 'multiple_choice', 'What is the Latin name of "twiggy tree daisy"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(82, 'A', 'Myosotidium hortensia', FALSE),
(82, 'B', 'Olea europaea', FALSE),
(82, 'C', 'Olearia lineata', TRUE),
(82, 'D', 'Myoporum laetum', FALSE);

-- Question 83 for PlantID 33
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 33, 'multiple_choice', 'What is the Latin name of "satinwood"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(83, 'A', 'Phebalium squameum', TRUE),
(83, 'B', 'Olearia lineata', FALSE),
(83, 'C', 'Olea europaea', FALSE),
(83, 'D', 'Myosotidium hortensia', FALSE);

-- Question 84 for PlantID 34
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 34, 'multiple_choice', 'What is the Latin name of "photinia"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(84, 'A', 'Olearia lineata', FALSE),
(84, 'B', 'Phebalium squameum', FALSE),
(84, 'C', 'Olea europaea', FALSE),
(84, 'D', 'Photinia X fraseri ''Robusta''', TRUE);


-- Question 85 for PlantID 35
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 35, 'multiple_choice', 'What is the Latin name of "wharariki or mountain Flax"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(85, 'A', 'Photinia X fraseri ''Robusta''', FALSE),
(85, 'B', 'Phormium cookianum', TRUE),
(85, 'C', 'Phebalium squameum', FALSE),
(85, 'D', 'Olearia lineata', FALSE);

-- Question 86 for PlantID 36
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 36, 'multiple_choice', 'What is the Latin name of "harakeke or NZ flax"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(86, 'A', 'Olea europaea', FALSE),
(86, 'B', 'Photinia X fraseri ''Robusta''', FALSE),
(86, 'C', 'Phormium tenax', TRUE),
(86, 'D', 'Phormium cookianum', FALSE);

-- Question 87 for PlantID 37
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 37, 'multiple_choice', 'What is the Latin name of "kawakawa"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(87, 'A', 'Piper excelsum', TRUE),
(87, 'B', 'Phormium tenax', FALSE),
(87, 'C', 'Photinia X fraseri ''Robusta''', FALSE),
(87, 'D', 'Phormium cookianum', FALSE);

-- Question 88 for PlantID 38
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 38, 'multiple_choice', 'What is the Latin name of "swamp ribbonwood"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(88, 'A', 'Photinia X fraseri ''Robusta''', FALSE),
(88, 'B', 'Phormium tenax', FALSE),
(88, 'C', 'Piper excelsum', FALSE),
(88, 'D', 'Plagianthus divaricatus', TRUE);

-- Question 89 for PlantID 39
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 39, 'multiple_choice', 'What is the Latin name of "cut leaf plane"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(89, 'A', 'Phormium cookianum', FALSE),
(89, 'B', 'Platanus orientalis ''Digitata''', TRUE),
(89, 'C', 'Piper excelsum', FALSE),
(89, 'D', 'Plagianthus divaricatus', FALSE);

-- Question 90 for PlantID 40
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 40, 'multiple_choice', 'What is the Latin name of "prickly shield fern or puniu"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(90, 'A', 'Plagianthus divaricatus', FALSE),
(90, 'B', 'Platanus orientalis ''Digitata''', FALSE),
(90, 'C', 'Polystichum vestitum', TRUE),
(90, 'D', 'Piper excelsum', FALSE);


-- Question 91 for PlantID 41
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 41, 'multiple_choice', 'What is the Latin name of "panakenake"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(91, 'A', 'Pratia angulata', TRUE),
(91, 'B', 'Polystichum vestitum', FALSE),
(91, 'C', 'Piper excelsum', FALSE),
(91, 'D', 'Plagianthus divaricatus', FALSE);

-- Question 92 for PlantID 42
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 42, 'multiple_choice', 'What is the Latin name of "rosemary"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(92, 'A', 'Platanus orientalis ''Digitata''', FALSE),
(92, 'B', 'Rosmarinus officinalis', TRUE),
(92, 'C', 'Pratia angulata', FALSE),
(92, 'D', 'Polystichum vestitum', FALSE);

-- Question 93 for PlantID 43
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 43, 'multiple_choice', 'What is the Latin name of "Japanese skimmia"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(93, 'A', 'Pratia angulata', FALSE),
(93, 'B', 'Rosmarinus officinalis', FALSE),
(93, 'C', 'Skimmia japonica', TRUE),
(93, 'D', 'Rosmarinus officinalis', FALSE);

-- Question 94 for PlantID 44
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 44, 'multiple_choice', 'What is the Latin name of "prostrate kowhai"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(94, 'A', 'Pratia angulata', FALSE),
(94, 'B', 'Piper excelsum', FALSE),
(94, 'C', 'Plagianthus divaricatus', FALSE),
(94, 'D', 'Sophora prostrata', TRUE);

-- Question 95 for PlantID 45
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 45, 'multiple_choice', 'What is the Latin name of "teucridium"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(95, 'A', 'Teucridium parvifolium', TRUE),
(95, 'B', 'Skimmia japonica', FALSE),
(95, 'C', 'Sophora prostrata', FALSE),
(95, 'D', 'Rosmarinus officinalis', FALSE);

-- Question 96 for PlantID 46
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 46, 'multiple_choice', 'What is the Latin name of "lime tree"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(96, 'A', 'Teucridium parvifolium', FALSE),
(96, 'B', 'Tilia cordata', TRUE),
(96, 'C', 'Teucridium parvifolium', FALSE),
(96, 'D', 'Skimmia japonica', FALSE);

-- Question 97 for PlantID 47
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 47, 'multiple_choice', 'What is the Latin name of "variegated elm"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(97, 'A', 'Sophora prostrata', FALSE),
(97, 'B', 'Skimmia japonica', FALSE),
(97, 'C', 'Ulmus carpinifolia ''Variegata''', TRUE),
(97, 'D', 'Tilia cordata', FALSE);

-- Question 98 for PlantID 48
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 48, 'multiple_choice', 'What is the Latin name of "large leaved hebe"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(98, 'A', 'Tilia cordata', FALSE),
(98, 'B', 'Teucridium parvifolium', FALSE),
(98, 'C', 'Sophora prostrata', FALSE),
(98, 'D', 'Veronica speciosa', TRUE);

-- Question 99 for PlantID 49
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(1, 49, 'multiple_choice', 'What is the Latin name of "topiary hebe"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(99, 'A', 'Veronica topiaria', TRUE),
(99, 'B', 'Ulmus carpinifolia ''Variegata''', FALSE),
(99, 'C', 'Tilia cordata', FALSE),
(99, 'D', 'Veronica speciosa', FALSE);

-- Question 100 for PlantID 50
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES (1, 50, 'multiple_choice', 'What is the Latin name of "laurustinus"?', 'B');

INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(100, 'A', 'Veronica topiaria', FALSE),
(100, 'B', 'Viburnum tinus', TRUE),
(100, 'C', 'Ulmus carpinifolia ''Variegata''', FALSE),
(100, 'D', 'Teucridium parvifolium', FALSE);

-- plant ID 51 to 100 true or false
-- PlantID 51: Acca sellowiana (feijoa)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(2, 51, 'true_false', 'Is "Acca sellowiana" the correct Latin name for the coastal banksia?', 'False');

-- PlantID 52: Acer palmatum (Japanese maple)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(2, 52, 'true_false', 'Is "Acer palmatum" known as the spotted or Japanese laurel?', 'False');

-- PlantID 53: Aesculus hippocastanum (common horse chestnut)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(2, 53, 'true_false', 'Does the common horse chestnut belong to the species "Acer palmatum"?', 'False');

-- PlantID 54: Agave sp. (agave)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(2, 54, 'true_false', 'Is "Agave sp." the correct Latin name for the kangaroo paw?', 'False');

-- PlantID 55: Anigozanthos flavidus (kangaroo paw)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(2, 55, 'true_false', 'Is "Anigozanthos flavidus" the correct Latin name for the strawberry tree?', 'False');

-- PlantID 56: Arbutus unedo (strawberry tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(2, 56, 'true_false', 'Is the strawberry tree known scientifically as "Aristotelia serrata"?', 'False');

-- PlantID 57: Aristotelia serrata (winberry or makomako)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(2, 57, 'true_false', 'Is "Aristotelia serrata" the correct Latin name for the winberry or makomako?', 'True');

-- PlantID 58: Asplenium oblongifolium (shining spleenwort)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(2, 58, 'true_false', 'Does the shining spleenwort belong to the genus "Agave"?', 'False');

-- PlantID 59: Bergenia cordifolia (heart leaf bergenia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(2, 59, 'true_false', 'Is "Bergenia cordifolia" the correct Latin name for the heart leaf bergenia?', 'True');

-- PlantID 60: Brachychiton populneus (kurrajong or bottletree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(2, 60, 'true_false', 'Is "Brachychiton populneus" known as the agave?', 'False');

-- PlantID 61: Buxus sempervirens (box hedge)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES 
(2, 61, 'true_false', 'Is the box hedge correctly identified as "Buxus sempervirens"?', 'True');

-- Question 112 for PlantID 62
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 62, 'true_false', "Is the Latin name of 'bottle brush' 'Callistemon sp.'?", 'False');

-- Question 113 for PlantID 63
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 63, 'true_false', "Is 'Canna X generalis' known as the coastal banksia?", 'False');

-- Question 114 for PlantID 64
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 64, 'true_false', "Is the Texas white redbud correctly identified as 'Cercis canadensis 'Texas White'?'", 'True');

-- Question 115 for PlantID 65
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 65, 'true_false', "Does 'Chimonanthus praecox' belong to the 'wintersweet' species?", 'True');

-- Question 116 for PlantID 66
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 66, 'true_false', "Is 'Choisya X dewitteana 'Aztec Pearl'' the correct Latin name for the Mexican orange blossom?", 'True');

-- Question 117 for PlantID 67
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 67, 'true_false', "Is the 'Mexican orange blossom' known scientifically as 'Canna X generalis'?", 'True');

-- Question 118 for PlantID 68
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 68, 'true_false', "Is 'Clivia sp.' a correct Latin name for the natal or bush lily?", 'False');

-- Question 119 for PlantID 69
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 69, 'true_false', "Is 'Corylus avellana' the correct Latin name for the common hazel?", 'False');

-- Question 120 for PlantID 70
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 70, 'true_false', "Is 'Cyclamen hederifolium' known as the European hornbeam?", 'False');

-- Question 121 for PlantID 71
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 71, 'true_false', "Is the Nepalese paper plant correctly identified as 'Daphne bholua'?", 'True');

-- Question 122 for PlantID 72
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 72, 'true_false', "Is 'Daphne odora' the correct Latin name for the winter daphne?", 'True');

-- PlantID 73: Hamamelis mollis (witch hazel)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 73, 'true_false', 'Is "Hamamelis mollis" the correct Latin name for the witch hazel?', 'True');

-- PlantID 74: Hydrangea quercifolia "Pee Wee" (oak leaf hydrangea)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 74, 'true_false', 'Is "Hydrangea quercifolia ''Pee Wee''" the correct Latin name for the oak leaf hydrangea?', 'True');

-- PlantID 75: Knightia excelsa (rewarewa or NZ honeysuckle)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 75, 'true_false', 'Is "Knightia excelsa" known as crown fern?', 'False'); 

-- PlantID 76: Lavandula X intermedia (hybrid lavender)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 76, 'true_false', 'Is "Lavandula X intermedia" the correct Latin name for hybrid lavender?', 'True');

-- PlantID 77: Leucadendron salignum (conebush)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 77, 'true_false', 'Is "Leucadendron salignum" the correct Latin name for the witch hazel?', 'False');  

-- PlantID 78: Libertia ixioides (NZ iris or mikoikoi)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 78, 'true_false', 'Does "Libertia ixioides" refer to the NZ iris or mikoikoi?', 'True');

-- PlantID 79: Lomaria discolor (crown fern)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 79, 'true_false', 'Is "Lomaria discolor" the correct Latin name for the oak leaf hydrangea?', 'False');  

-- PlantID 80: Magnolia grandiflora "Little Gem" (dwarf magnolia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 80, 'true_false', 'Is "Magnolia grandiflora ''Little Gem''" the correct Latin name for the dwarf magnolia?', 'True');

-- PlantID 81: Magnolia X soulangeana (saucer or Chinese magnolia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 81, 'true_false', 'Is "Magnolia X soulangeana" known as saucer or Chinese magnolia?', 'True');

-- PlantID 82: Malus sp. (apple tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 82, 'true_false', 'Is "Malus sp." the correct Latin name for the apple tree?', 'True');

-- PlantID 83: Michelia yunnanensis (evergreen michelia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 83, 'true_false', 'Is "Michelia yunnanensis" the correct Latin name for the evergreen michelia?', 'True');

-- PlantID 84: Nandina domestica ‘Pygmaea’ (dwarf heavenly bamboo)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 84, 'true_false', 'Is "Nandina domestica ‘Pygmaea’" the correct Latin name for the dwarf heavenly bamboo?', 'True');

-- PlantID 85: Pachysandra terminalis (Japanese spurge) - Answer changed to False, so question changed
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 85, 'true_false', 'Is "Pachysandra terminalis" the correct Latin name for the cherry laurel?', 'False');

-- PlantID 86: Pieris japonica (lily of the valley)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 86, 'true_false', 'Is "Pieris japonica" the correct Latin name for the lily of the valley?', 'True');

-- PlantID 87: Polyspora axillaris (fried egg plant)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 87, 'true_false', 'Is "Polyspora axillaris" the correct Latin name for the fried egg plant?', 'True');

-- PlantID 88: Populus trichocarpa (black cottonwood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 88, 'true_false', 'Is "Populus trichocarpa" the correct Latin name for the black cottonwood?', 'True');

-- PlantID 89: Protea neriifolia (oleanderleaf protea) - Answer changed to False, so question changed
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 89, 'true_false', 'Is "Protea neriifolia" the correct Latin name for the kangaroo paw?', 'False');

-- PlantID 90: Prunus laurocerasus (cherry laurel)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 90, 'true_false', 'Is "Prunus laurocerasus" the correct Latin name for the cherry laurel?', 'True');

-- PlantID 91: Pyrus communis (common pear)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 91, 'true_false', 'Is "Pyrus communis" the correct Latin name for the common pear?', 'True');

-- PlantID 92: Rhododendron sp. (azalea) - Answer changed to False, so question changed
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 92, 'true_false', 'Is "Rhododendron sp." the correct Latin name for the maple tree?', 'False');

-- PlantID 93: Rhododendron sp. (rhododendron) - Answer changed to False, so question changed
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 93, 'true_false', 'Is "Rhododendron sp." the correct Latin name for the sunflower?', 'False');

-- PlantID 94: Robinia pseudoacacia 'Lace Lady' (contorted black locust)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 94, 'true_false', 'Is "Robinia pseudoacacia ''Lace Lady''" the correct Latin name for the contorted black locust?', 'True');

-- PlantID 95: Rosa sp. 'Ivey Hall' (yellow floribunda rose)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 95, 'true_false', 'Is "Rosa sp. ''Ivey Hall''" known as the yellow floribunda rose?', 'True');

-- PlantID 96: Salvia officinalis (common sage) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 96, 'true_false', 'Is "Salvia officinalis" the correct Latin name for the cherry laurel?', 'False');

-- PlantID 97: Santolina chamaecyparissus (lavender cotton)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 97, 'true_false', 'Is "Santolina chamaecyparissus" the correct Latin name for lavender cotton?', 'True');

-- PlantID 98: Sarcococca confusa (sweet box) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 98, 'true_false', 'Is "Sarcococca confusa" the correct Latin name for the Japanese maple?', 'False');

-- PlantID 99: Sequoia sempervirens (redwood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 99, 'true_false', 'Is "Sequoia sempervirens" the correct Latin name for the redwood?', 'True');

-- PlantID 100: Zantedeschia aethiopica (arum or calla Lily) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (2, 100, 'true_false', 'Is "Zantedeschia aethiopica" the correct Latin name for the sunflower?', 'False');


-- multi choice

-- plant ID 101 to 150 true or false
-- PlantID 101: Acer griseum (paperbark maple)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 101, 'true_false', 'Is "Acer griseum" known as the paperbark maple?', 'True');

-- PlantID 102: Anemanthele lessoniana (wind grass) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 102, 'true_false', 'Is "Anemanthele lessoniana" the correct Latin name for the kangaroo paw?', 'False');

-- PlantID 103: Arthropodium cirratum (rengarenga)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 103, 'true_false', 'Is "Arthropodium cirratum" the correct Latin name for rengarenga?', 'True');

-- PlantID 104: Astelia chathamica (Chatham Islands astelia) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 104, 'true_false', 'Is "Astelia chathamica" the correct Latin name for the European beech?', 'False');

-- PlantID 105: Austroderia richardii (South Island toe toe)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 105, 'true_false', 'Is "Austroderia richardii" the correct Latin name for the South Island toe toe?', 'True');

-- PlantID 106: Brachyglottis monroi (Monro's daisy) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 106, 'true_false', 'Is "Brachyglottis monroi" known as the cherry laurel?', 'False');

-- PlantID 107: Brachyglottis rotundifolia (muttonbird scrub)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 107, 'true_false', 'Is "Brachyglottis rotundifolia" the correct Latin name for muttonbird scrub?', 'True');

-- PlantID 108: Carmichaelia appressa (native prostrate broom) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 108, 'true_false', 'Is "Carmichaelia appressa" the correct Latin name for the Japanese maple?', 'False');

-- PlantID 109: Carmichaelia stevensonii (weeping broom)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 109, 'true_false', 'Is "Carmichaelia stevensonii" the correct Latin name for the weeping broom?', 'True');

-- PlantID 110: Coprosma acerosa 'Hawera' (Hawera sand coprosma) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 110, 'true_false', 'Is "Coprosma acerosa ‘Hawera’" known as the kangaroo paw?', 'False');

-- PlantID 111: Cordyline australis (cabbage tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 111, 'true_false', 'Is "Cordyline australis" the correct Latin name for the cabbage tree?', 'True');

-- PlantID 112: Cornus florida (dogwood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 112, 'true_false', 'Is "Cornus florida" the correct Latin name for the dogwood?', 'True');

-- PlantID 113: Corynocarpus laevigatus (karaka or NZ laurel) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 113, 'true_false', 'Is "Corynocarpus laevigatus" known as the silver beech?', 'False');

-- PlantID 114: Dacrydium cupressinum (rimu)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 114, 'true_false', 'Is "Dacrydium cupressinum" the correct Latin name for rimu?', 'True');

-- PlantID 115: Dianella nigra (turutu) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 115, 'true_false', 'Is "Dianella nigra" the correct Latin name for the kangaroo paw?', 'False');

-- PlantID 116: Dicksonia squarrosa (wheki or rough tree fern)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 116, 'true_false', 'Is "Dicksonia squarrosa" the correct Latin name for wheki or rough tree fern?', 'True');

-- PlantID 117: Discaria toumatou (matagouri) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 117, 'true_false', 'Is "Discaria toumatou" known as the cherry laurel?', 'False');

-- PlantID 118: Disphyma australe (horokaka or native ice plant)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 118, 'true_false', 'Is "Disphyma australe" the correct Latin name for horokaka or native ice plant?', 'True');

-- PlantID 119: Fraxinus excelsior (European or common ash) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 119, 'true_false', 'Is "Fraxinus excelsior" the correct Latin name for the South Island toe toe?', 'False');

-- PlantID 120: Fuscospora cliffortioides (mountain beech)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 120, 'true_false', 'Is "Fuscospora cliffortioides" the correct Latin name for mountain beech?', 'True');

-- PlantID 121: Fuscospora fusca (red beech) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 121, 'true_false', 'Is "Fuscospora fusca" known as the manna gum?', 'False');

-- PlantID 122: Ginkgo biloba (maidenhair tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 122, 'true_false', 'Is "Ginkgo biloba" the correct Latin name for the maidenhair tree?', 'True');

-- PlantID 123: Griselinia littoralis (NZ broadleaf or kapuka)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 123, 'true_false', 'Is "Griselinia littoralis" the correct Latin name for the NZ broadleaf or kapuka?', 'True');

-- PlantID 124: Haloragis erecta 'Purpurea' (toatoa) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 124, 'true_false', 'Is "Haloragis erecta ‘Purpurea’" known as the silver fern?', 'False');

-- PlantID 125: Hoheria lyallii (mountain lacebark)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 125, 'true_false', 'Is "Hoheria lyallii" the correct Latin name for mountain lacebark?', 'True');

-- PlantID 126: Kunzea ericoides (kanuka) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 126, 'true_false', 'Is "Kunzea ericoides" the correct Latin name for the NZ daisy bush?', 'False');

-- PlantID 127: Libertia peregrinans (NZ iris)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 127, 'true_false', 'Is "Libertia peregrinans" the correct Latin name for the NZ iris?', 'True');

-- PlantID 128: Liquidambar styraciflua (American sweetgum) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 128, 'true_false', 'Is "Liquidambar styraciflua" known as the NZ flax?', 'False');

-- PlantID 129: Liriodendron tulipifera (tulip tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 129, 'true_false', 'Is "Liriodendron tulipifera" the correct Latin name for the tulip tree?', 'True');

-- PlantID 130: Lophozonia menziesii (silver beech) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 130, 'true_false', 'Is "Lophozonia menziesii" the correct Latin name for the kowhai?', 'False');

-- PlantID 131: Melicytus alpinus (porcupine scrub)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 131, 'true_false', 'Is "Melicytus alpinus" the correct Latin name for porcupine scrub?', 'True');

-- PlantID 132: Muehlenbeckia axillaris (creeping muehlenbeckia) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 132, 'true_false', 'Is "Muehlenbeckia axillaris" known as the giant club rush?', 'False');

-- PlantID 133: Olearia cheesemanii (NZ daisy bush)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 133, 'true_false', 'Is "Olearia cheesemanii" the correct Latin name for the NZ daisy bush?', 'True');

-- PlantID 134: Pimelea prostrata (NZ daphne)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 134, 'true_false', 'Is "Pimelea prostrata" the correct Latin name for NZ daphne?', 'True');

-- PlantID 135: Pittosporum crassifolium (karo) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 135, 'true_false', 'Is "Pittosporum crassifolium" known as the mountain daisy?', 'False');

-- PlantID 136: Pittosporum eugenioides (lemonwood or tarata)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 136, 'true_false', 'Is "Pittosporum eugenioides" the correct Latin name for lemonwood or tarata?', 'True');

-- PlantID 137: Pittosporum tenuifolium (kohuhu or black matipo) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 137, 'true_false', 'Is "Pittosporum tenuifolium" the correct Latin name for the NZ iris?', 'False');

-- PlantID 138: Plagianthus regius (lowland ribbonwood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 138, 'true_false', 'Is "Plagianthus regius" the correct Latin name for lowland ribbonwood?', 'True');

-- PlantID 139: Platanus x acerifolia (London plane) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 139, 'true_false', 'Is "Platanus x acerifolia" known as the silver beech?', 'False');

-- PlantID 140: Poa cita (silver tussock)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 140, 'true_false', 'Is "Poa cita" the correct Latin name for silver tussock?', 'True');

-- PlantID 141: Prunus x yedoensis (Yoshino cherry) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 141, 'true_false', 'Is "Prunus x yedoensis" the correct Latin name for the black cottonwood?', 'False');

-- PlantID 142: Pseudopanax crassifolius (lancewood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 142, 'true_false', 'Is "Pseudopanax crassifolius" the correct Latin name for lancewood?', 'True');

-- PlantID 143: Pseudopanax ferox (fierce lancewood) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 143, 'true_false', 'Is "Pseudopanax ferox" known as the NZ daisy bush?', 'False');

-- PlantID 144: Quercus palustris (pin oak)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 144, 'true_false', 'Is "Quercus palustris" the correct Latin name for pin oak?', 'True');

-- PlantID 145: Quercus robur (English oak)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 145, 'true_false', 'Is "Quercus robur" the correct Latin name for English oak?', 'True');

-- PlantID 146: Solanum laciniatum (poroporo) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 146, 'true_false', 'Is "Solanum laciniatum" known as the Japanese maple?', 'False');

-- PlantID 147: Sophora microphylla (South Island kowhai)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 147, 'true_false', 'Is "Sophora microphylla" the correct Latin name for South Island kowhai?', 'True');

-- PlantID 148: Sophora molloyi 'Dragons Gold' (Cook Strait kowhai) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 148, 'true_false', 'Is "Sophora molloyi \'Dragons Gold\'" the correct Latin name for the coastal banksia?', 'False');

-- PlantID 149: Sophora tetraptera (North Island kowhai)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 149, 'true_false', 'Is "Sophora tetraptera" the correct Latin name for North Island kowhai?', 'True');

-- PlantID 150: Veronica hulkeana (New Zealand lilac)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (3, 150, 'true_false', 'Is "Veronica hulkeana" the correct Latin name for New Zealand lilac?', 'True');

-- PlantID 151: Agathis australis (kauri)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 151, 'true_false', 'Is "Agathis australis" the correct Latin name for kauri?', 'True');

-- PlantID 152: Apodasmia similis (oioi) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 152, 'true_false', 'Is "Apodasmia similis" known as the Japanese maple?', 'False');

-- PlantID 153: Camellia japonica (Japanese camellia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 153, 'true_false', 'Is "Camellia japonica" the correct Latin name for Japanese camellia?', 'True');

-- PlantID 154: Camellia sasanqua (autumn camellia) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 154, 'true_false', 'Is "Camellia sasanqua" the correct Latin name for the coastal banksia?', 'False');

-- PlantID 155: Carex secta (pukio)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 155, 'true_false', 'Is "Carex secta" the correct Latin name for pukio?', 'True');

-- PlantID 156: Carex testacea (orange sedge) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 156, 'true_false', 'Is "Carex testacea" known as the Japanese maple?', 'False');

-- PlantID 157: Carpodetus serratus (marble leaf or putaputaweta)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 157, 'true_false', 'Is "Carpodetus serratus" the correct Latin name for marble leaf or putaputaweta?', 'True');

-- PlantID 158: Catalpa bignonioides (Indian bean tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 158, 'true_false', 'Is "Catalpa bignonioides" the correct Latin name for Indian bean tree?', 'True');

-- PlantID 159: Choisya ternata (Mexican orange blossom) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 159, 'true_false', 'Is "Choisya ternata" the correct Latin name for the coastal banksia?', 'False');

-- PlantID 160: Clematis paniculata (puawhananga)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 160, 'true_false', 'Is "Clematis paniculata" the correct Latin name for puawhananga?', 'True');

-- PlantID 161: Clianthus maximus (kakabeak)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 161, 'true_false', 'Is "Clianthus maximus" the correct Latin name for kakabeak?', 'True');

-- PlantID 162: Coprosma propinqua (mingimingi)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 162, 'true_false', 'Is "Coprosma propinqua" the correct Latin name for mingimingi?', 'True');

-- PlantID 163: Coprosma rugosa 'Lobster' (red coprosma) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 163, 'true_false', 'Is "Coprosma rugosa \'Lobster\'" known as the Japanese maple?', 'False');

-- PlantID 164: Cotinus coggygria (smoke bush)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 164, 'true_false', 'Is "Cotinus coggygria" the correct Latin name for smoke bush?', 'True');

-- PlantID 165: Cupressus macrocarpa (macrocarpa) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 165, 'true_false', 'Is "Cupressus macrocarpa" the correct Latin name for the coastal banksia?', 'False');

-- PlantID 166: Cupressus sempervirens (Italian cypress)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 166, 'true_false', 'Is "Cupressus sempervirens" the correct Latin name for Italian cypress?', 'True');

-- PlantID 167: Dracophyllum sinclairii (inaka or neinei) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 167, 'true_false', 'Is "Dracophyllum sinclairii" known as the Japanese maple?', 'False');

-- PlantID 168: Euphorbia glauca (shore spurge or waiuatua)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 168, 'true_false', 'Is "Euphorbia glauca" the correct Latin name for shore spurge or waiuatua?', 'True');

-- PlantID 169: Ficus pumila (creeping fig)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 169, 'true_false', 'Is "Ficus pumila" the correct Latin name for creeping fig?', 'True');

-- PlantID 170: Fuchsia procumbens (creeping fuchsia) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 170, 'true_false', 'Is "Fuchsia procumbens" the correct Latin name for the coastal banksia?', 'False');

-- PlantID 171: Fuscospora solandri (black beech)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 171, 'true_false', 'Is "Fuscospora solandri" the correct Latin name for black beech?', 'True');

-- PlantID 172: Helleborus orientalis (lenten rose)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 172, 'true_false', 'Is "Helleborus orientalis" the correct Latin name for lenten rose?', 'True');

-- PlantID 173: Hydrangea macrophylla (mophead hydrangea)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 173, 'true_false', 'Is "Hydrangea macrophylla" the correct Latin name for mophead hydrangea?', 'True');

-- PlantID 174: Hydrangea paniculata (panicled hydrangea) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 174, 'true_false', 'Is "Hydrangea paniculata" known as the coastal banksia?', 'False');

-- PlantID 175: Juncus pallidus (giant club rush)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 175, 'true_false', 'Is "Juncus pallidus" the correct Latin name for giant club rush?', 'True');

-- PlantID 176: Lophomyrtus obcordata (rohutu or NZ myrtle) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 176, 'true_false', 'Is "Lophomyrtus obcordata" known as the Japanese maple?', 'False');

-- PlantID 177: Lophomyrtus x ralphii (hybrid lophomyrtus or NZ myrtle)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 177, 'true_false', 'Is "Lophomyrtus x ralphii" the correct Latin name for hybrid lophomyrtus or NZ myrtle?', 'True');

-- PlantID 178: Melicytus ramiflorus (mahoe or whiteywood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 178, 'true_false', 'Is "Melicytus ramiflorus" the correct Latin name for mahoe or whiteywood?', 'True');

-- PlantID 179: Microleana avenacea (bush rice grass) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 179, 'true_false', 'Is "Microleana avenacea" the correct Latin name for the coastal banksia?', 'False');

-- PlantID 180: Muehlenbeckia complexa (small leaved pohuehue)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 180, 'true_false', 'Is "Muehlenbeckia complexa" the correct Latin name for small leaved pohuehue?', 'True');

-- PlantID 181: Nepeta mussinii (cat mint)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 181, 'true_false', 'Is "Nepeta mussinii" the correct Latin name for cat mint?', 'True');

-- PlantID 182: Pachystegia insignis (Marlborough rock daisy) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 182, 'true_false', 'Is "Pachystegia insignis" known as the Japanese maple?', 'False');

-- PlantID 183: Pachystegia rufa (Marlborough rock daisy)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 183, 'true_false', 'Is "Pachystegia rufa" the correct Latin name for Marlborough rock daisy?', 'True');

-- PlantID 184: Pectinopitys ferruginea (miro)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 184, 'true_false', 'Is "Pectinopitys ferruginea" the correct Latin name for miro?', 'True');

-- PlantID 185: Phyllocladus alpinus (mountain toatoa or celery pine) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 185, 'true_false', 'Is "Phyllocladus alpinus" known as the coastal banksia?', 'False');

-- PlantID 186: Phyllocladus trichomanoides (tanekaha)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 186, 'true_false', 'Is "Phyllocladus trichomanoides" the correct Latin name for tanekaha?', 'True');

-- PlantID 187: Pittosporum tenuifolium 'Sumo' (dwarf pittosporum)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 187, 'true_false', 'Is "Pittosporum tenuifolium \'Sumo\'" the correct Latin name for dwarf pittosporum?', 'True');

-- PlantID 188: Podocarpus laetus (mountain or Hall's totara) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 188, 'true_false', 'Is "Podocarpus laetus" known as the Japanese maple?', 'False');

-- PlantID 189: Podocarpus nivalis (snow or mountain totara)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 189, 'true_false', 'Is "Podocarpus nivalis" the correct Latin name for snow or mountain totara?', 'True');

-- PlantID 190: Podocarpus totara (totara)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 190, 'true_false', 'Is "Podocarpus totara" the correct Latin name for totara?', 'True');

-- PlantID 191: Prumnopitys taxifolia (matai) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 191, 'true_false', 'Is "Prumnopitys taxifolia" known as the coastal banksia?', 'False');

-- PlantID 192: Pseudopanax lessonii (houpara)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 192, 'true_false', 'Is "Pseudopanax lessonii" the correct Latin name for houpara?', 'True');

-- PlantID 193: Pseudowintera colorata (horopito or pepper tree) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 193, 'true_false', 'Is "Pseudowintera colorata" known as the Japanese maple?', 'False');

-- PlantID 194: Quercus rubra (red oak)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 194, 'true_false', 'Is "Quercus rubra" the correct Latin name for red oak?', 'True');

-- PlantID 195: Rubus cissoides (bush lawyer)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 195, 'true_false', 'Is "Rubus cissoides" the correct Latin name for bush lawyer?', 'True');

-- PlantID 196: Sedum spectabile 'Autumn Joy' (stonecrop) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 196, 'true_false', 'Is "Sedum spectabile \'Autumn Joy\'" known as the coastal banksia?', 'False');

-- PlantID 197: Sorbus aucuparia (rowan)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 197, 'true_false', 'Is "Sorbus aucuparia" the correct Latin name for rowan?', 'True');

-- PlantID 198: Typha orientalis (raupo or bullrush) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 198, 'true_false', 'Is "Typha orientalis" known as the Japanese maple?', 'False');

-- PlantID 199: Veronica odora 'Prostrata' (prostrate hebe)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 199, 'true_false', 'Is "Veronica odora \'Prostrata\'" the correct Latin name for prostrate hebe?', 'True');

-- PlantID 200: Wisteria sinensis (Chinese wisteria) - False statement
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) 
VALUES (4, 200, 'true_false', 'Is "Wisteria sinensis" known as the coastal banksia?', 'False');

-- Question for PlantID 51 (Feijoa)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 51, 'multiple_choice', 'What is the Latin name of "feijoa"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(251, 'A', 'Acer palmatum', FALSE),
(251, 'B', 'Acca sellowiana', TRUE),
(251, 'C', 'Anigozanthos flavidus', FALSE),
(251, 'D', 'Arbutus unedo', FALSE);

-- Question for PlantID 52 (Japanese Maple)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 52, 'multiple_choice', 'What is the Latin name of "Japanese maple"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(252, 'A', 'Acer palmatum', TRUE),
(252, 'B', 'Aesculus hippocastanum', FALSE),
(252, 'C', 'Agave sp.', FALSE),
(252, 'D', 'Anigozanthos flavidus', FALSE);

-- Question for PlantID 53 (Common Horse Chestnut)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 53, 'multiple_choice', 'What is the Latin name of "common horse chestnut"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(253, 'A', 'Agave sp.', FALSE),
(253, 'B', 'Anigozanthos flavidus', FALSE),
(253, 'C', 'Arbutus unedo', FALSE),
(253, 'D', 'Aesculus hippocastanum', TRUE);

-- Question for PlantID 54 (Agave)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 54, 'multiple_choice', 'What is the Latin name of "agave"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(254, 'A', 'Anigozanthos flavidus', FALSE),
(254, 'B', 'Arbutus unedo', FALSE),
(254, 'C', 'Agave sp.', TRUE),
(254, 'D', 'Aristotelia serrata', FALSE);

-- Question for PlantID 55 (Kangaroo Paw)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 55, 'multiple_choice', 'What is the Latin name of "kangaroo paw"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(255, 'A', 'Anigozanthos flavidus', TRUE),
(255, 'B', 'Arbutus unedo', FALSE),
(255, 'C', 'Carpinus betulus', FALSE),
(255, 'D', 'Corylus avellana', FALSE);

-- Question for PlantID 56 (Strawberry Tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 56, 'multiple_choice', 'What is the Latin name of "strawberry tree"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(256, 'A', 'Carpinus betulus', FALSE),
(256, 'B', 'Corylus avellana', FALSE),
(256, 'C', 'Dianella sp. ''Little Rev''', FALSE),
(256, 'D', 'Arbutus unedo', TRUE);

-- Question for PlantID 57 (Winberry or Makomako)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 57, 'multiple_choice', 'What is the Latin name of "winberry or makomako"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(257, 'A', 'Corylus avellana', FALSE),
(257, 'B', 'Aristotelia serrata', TRUE),
(257, 'C', 'Dodonaea viscosa ''Purpurea''', FALSE),
(257, 'D', 'Eucalyptus viminalis', FALSE);

-- Question for PlantID 58 (Shining Spleenwort)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 58, 'multiple_choice', 'What is the Latin name of "shining spleenwort"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(258, 'A', 'Dodonaea viscosa ''Purpurea''', FALSE),
(258, 'B', 'Eucalyptus viminalis', FALSE),
(258, 'C', 'Asplenium oblongifolium', TRUE),
(258, 'D', 'Fagus sylvatica', FALSE);

-- Question for PlantID 59 (Heart Leaf Bergenia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 59, 'multiple_choice', 'What is the Latin name of "heart leaf bergenia"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(259, 'A', 'Bergenia cordifolia', TRUE),
(259, 'B', 'Fagus sylvatica', FALSE),
(259, 'C', 'Griselinia littoralis', FALSE),
(259, 'D', 'Hedera helix', FALSE);

-- Question for PlantID 60 (Kurrajong or Bottletree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 60, 'multiple_choice', 'What is the Latin name of "kurrajong or bottletree"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(260, 'A', 'Griselinia littoralis', FALSE),
(260, 'B', 'Brachychiton populneus', TRUE),
(260, 'C', 'Hedera helix', FALSE),
(260, 'D', 'Ilex aquifolium', FALSE);

-- Question for PlantID 61 (Box Hedge)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 61, 'multiple_choice', 'What is the Latin name of "box hedge"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(261, 'A', 'Hedera helix', FALSE),
(261, 'B', 'Ilex aquifolium', FALSE),
(261, 'C', 'Jasminum officinale', FALSE),
(261, 'D', 'Buxus sempervirens', TRUE);

-- Question for PlantID 62 (Bottle Brush)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 62, 'multiple_choice', 'What is the Latin name of "bottle brush"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(262, 'A', 'Laurus nobilis', FALSE),
(262, 'B', 'Callistemon sp.', TRUE),
(262, 'C', 'Magnolia grandiflora', FALSE),
(262, 'D', 'Nandina domestica', FALSE);

-- Question for PlantID 63 (Canna Lily)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 63, 'multiple_choice', 'What is the Latin name of "canna lily"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(263, 'A', 'Canna X generalis', TRUE),
(263, 'B', 'Olea europaea', FALSE),
(263, 'C', 'Piper excelsum', FALSE),
(263, 'D', 'Quercus robur', FALSE);

-- Question for PlantID 64 (Texas White Redbud)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 64, 'multiple_choice', 'What is the Latin name of "Texas white redbud"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(264, 'A', 'Piper excelsum', FALSE),
(264, 'B', 'Quercus robur', FALSE),
(264, 'C', 'Rosa canina', FALSE),
(264, 'D', 'Cercis canadensis ''Texas White''', TRUE);

-- Question for PlantID 65 (Wintersweet)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 65, 'multiple_choice', 'What is the Latin name of "wintersweet"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(265, 'A', 'Quercus robur', FALSE),
(265, 'B', 'Chimonanthus praecox', TRUE),
(265, 'C', 'Salvia officinalis', FALSE),
(265, 'D', 'Tilia cordata', FALSE);

-- Question for PlantID 66 (Mexican Orange Blossom)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 66, 'multiple_choice', 'What is the Latin name of "Mexican orange blossom"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(266, 'A', 'Salvia officinalis', FALSE),
(266, 'B', 'Tilia cordata', FALSE),
(266, 'C', 'Choisya X dewitteana ''Aztec Pearl''', TRUE),
(266, 'D', 'Ulmus minor', FALSE);

-- Question for PlantID 67 (Natal or Bush Lily)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 67, 'multiple_choice', 'What is the Latin name of "natal or bush lily"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(267, 'A', 'Clivia sp.', TRUE),
(267, 'B', 'Ulmus minor', FALSE),
(267, 'C', 'Viburnum opulus', FALSE),
(267, 'D', 'Wisteria sinensis', FALSE);

-- Question for PlantID 68 (Common Hazel)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 68, 'multiple_choice', 'What is the Latin name of "common hazel"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(268, 'A', 'Viburnum opulus', FALSE),
(268, 'B', 'Wisteria sinensis', FALSE),
(268, 'C', 'Xanthoceras sorbifolium', FALSE),
(268, 'D', 'Corylus avellana', TRUE);

-- Question for PlantID 69 (Ivy Leaved Cyclamen)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 69, 'multiple_choice', 'What is the Latin name of "ivy leaved cyclamen"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(269, 'A', 'Wisteria sinensis', FALSE),
(269, 'B', 'Cyclamen hederifolium', TRUE),
(269, 'C', 'Xanthoceras sorbifolium', FALSE),
(269, 'D', 'Zantedeschia aethiopica', FALSE);

-- Question for PlantID 70 (Nepalese Paper Plant)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 70, 'multiple_choice', 'What is the Latin name of "Nepalese paper plant"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(270, 'A', 'Xanthoceras sorbifolium', FALSE),
(270, 'B', 'Zantedeschia aethiopica', FALSE),
(270, 'C', 'Daphne bholua', TRUE),
(270, 'D', 'Corylus avellana', FALSE);

-- Question for PlantID 71 (Winter Daphne)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 71, 'multiple_choice', 'What is the Latin name of "winter daphne"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(271, 'A', 'Daphne odora', TRUE),
(271, 'B', 'Acer palmatum', FALSE),
(271, 'C', 'Buxus sempervirens', FALSE),
(271, 'D', 'Clematis paniculata', FALSE);

-- Question for PlantID 72 (Grevillea)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 72, 'multiple_choice', 'What is the Latin name of "grevillea"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(272, 'A', 'Buxus sempervirens', FALSE),
(272, 'B', 'Clematis paniculata', FALSE),
(272, 'C', 'Dianella nigra', FALSE),
(272, 'D', 'Grevillea banksii X bipinnatifida', TRUE);

-- Question for PlantID 73 (Witch Hazel)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 73, 'multiple_choice', 'What is the Latin name of "witch hazel"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(273, 'A', 'Clematis paniculata', FALSE),
(273, 'B', 'Hamamelis mollis', TRUE),
(273, 'C', 'Eucalyptus viminalis', FALSE),
(273, 'D', 'Fagus sylvatica', FALSE);

-- Question for PlantID 74 (Oak Leaf Hydrangea)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 74, 'multiple_choice', 'What is the Latin name of "oak leaf hydrangea"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(274, 'A', 'Hydrangea quercifolia ''Pee Wee''', TRUE),
(274, 'B', 'Fagus sylvatica', FALSE),
(274, 'C', 'Ginkgo biloba', FALSE),
(274, 'D', 'Helleborus orientalis', FALSE);

-- Question for PlantID 75 (Rewarewa NZ Honeysuckle)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 75, 'multiple_choice', 'What is the Latin name of "rewarewa NZ honeysuckle"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(275, 'A', 'Ginkgo biloba', FALSE),
(275, 'B', 'Helleborus orientalis', FALSE),
(275, 'C', 'Knightia excelsa', TRUE),
(275, 'D', 'Ilex aquifolium', FALSE);

-- Question for PlantID 76 (Hybrid Lavender)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 76, 'multiple_choice', 'What is the Latin name of "hybrid lavender"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(276, 'A', 'Helleborus orientalis', FALSE),
(276, 'B', 'Ilex aquifolium', FALSE),
(276, 'C', 'Juncus effusus', FALSE),
(276, 'D', 'Lavandula X intermedia', TRUE);

-- Question for PlantID 77 (Conebush)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 77, 'multiple_choice', 'What is the Latin name of "conebush"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(277, 'A', 'Leucadendron salignum', TRUE),
(277, 'B', 'Ilex aquifolium', FALSE),
(277, 'C', 'Juncus effusus', FALSE),
(277, 'D', 'Kalmia latifolia', FALSE);

-- Question for PlantID 78 (NZ Iris or Mikoikoi)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 78, 'multiple_choice', 'What is the Latin name of "NZ iris or mikoikoi"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(278, 'A', 'Kalmia latifolia', FALSE),
(278, 'B', 'Libertia ixioides', TRUE),
(278, 'C', 'Lonicera periclymenum', FALSE),
(278, 'D', 'Magnolia grandiflora', FALSE);

-- Question for PlantID 79 (Crown Fern)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 79, 'multiple_choice', 'What is the Latin name of "crown fern"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(279, 'A', 'Lonicera periclymenum', FALSE),
(279, 'B', 'Magnolia grandiflora', FALSE),
(279, 'C', 'Lomaria discolor', TRUE),
(279, 'D', 'Nandina domestica', FALSE);

-- Question for PlantID 80 (Dwarf Magnolia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 80, 'multiple_choice', 'What is the Latin name of "dwarf magnolia"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(280, 'A', 'Nandina domestica', FALSE),
(280, 'B', 'Olearia phlogopappa', FALSE),
(280, 'C', 'Pachysandra terminalis', FALSE),
(280, 'D', 'Magnolia grandiflora ''Little Gem''', TRUE);

-- Question for PlantID 81 (Saucer or Chinese Magnolia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 81, 'multiple_choice', 'What is the Latin name of "saucer or Chinese magnolia"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(281, 'A', 'Magnolia X soulangeana', TRUE),
(281, 'B', 'Nandina domestica', FALSE),
(281, 'C', 'Olearia phlogopappa', FALSE),
(281, 'D', 'Pachysandra terminalis', FALSE);

-- Question for PlantID 82 (Apple Tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 82, 'multiple_choice', 'What is the Latin name of "apple tree"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(282, 'A', 'Pyrus communis', FALSE),
(282, 'B', 'Malus sp.', TRUE),
(282, 'C', 'Prunus laurocerasus', FALSE),
(282, 'D', 'Rosa sp. ''Ivey Hall''', FALSE);

-- Question for PlantID 83 (Evergreen Michelia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 83, 'multiple_choice', 'What is the Latin name of "evergreen michelia"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(283, 'A', 'Pyrus communis', FALSE),
(283, 'B', 'Rosa sp. ''Ivey Hall''', FALSE),
(283, 'C', 'Michelia yunnanensis', TRUE),
(283, 'D', 'Salvia officinalis', FALSE);

-- Question for PlantID 84 (Dwarf Heavenly Bamboo)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 84, 'multiple_choice', 'What is the Latin name of "dwarf heavenly bamboo"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(284, 'A', 'Nandina domestica ‘Pygmaea’', TRUE),
(284, 'B', 'Santolina chamaecyparissus', FALSE),
(284, 'C', 'Sarcococca confusa', FALSE),
(284, 'D', 'Sequoia sempervirens', FALSE);

-- Question for PlantID 85 (Japanese Spurge)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 85, 'multiple_choice', 'What is the Latin name of "Japanese spurge"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(285, 'A', 'Santolina chamaecyparissus', FALSE),
(285, 'B', 'Sarcococca confusa', FALSE),
(285, 'C', 'Sequoia sempervirens', FALSE),
(285, 'D', 'Pachysandra terminalis', TRUE);

-- Question for PlantID 86 (Lily of the Valley)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 86, 'multiple_choice', 'What is the Latin name of "lily of the valley"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(286, 'A', 'Sarcococca confusa', FALSE),
(286, 'B', 'Pieris japonica', TRUE),
(286, 'C', 'Sequoia sempervirens', FALSE),
(286, 'D', 'Santolina chamaecyparissus', FALSE);

-- Question for PlantID 87 (Fried Egg Plant)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 87, 'multiple_choice', 'What is the Latin name of "fried egg plant"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(287, 'A', 'Sequoia sempervirens', FALSE),
(287, 'B', 'Santolina chamaecyparissus', FALSE),
(287, 'C', 'Polyspora axillaris', TRUE),
(287, 'D', 'Pachysandra terminalis', FALSE);

-- Question for PlantID 88 (Black Cottonwood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 88, 'multiple_choice', 'What is the Latin name of "black cottonwood"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(288, 'A', 'Populus trichocarpa', TRUE),
(288, 'B', 'Pieris japonica', FALSE),
(288, 'C', 'Polyspora axillaris', FALSE),
(288, 'D', 'Pachysandra terminalis', FALSE);

-- Question for PlantID 89 (Oleanderleaf Protea)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 89, 'multiple_choice', 'What is the Latin name of "oleanderleaf protea"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(289, 'A', 'Pieris japonica', FALSE),
(289, 'B', 'Polyspora axillaris', FALSE),
(289, 'C', 'Populus trichocarpa', FALSE),
(289, 'D', 'Protea neriifolia', TRUE);

-- Question for PlantID 90 (Cherry Laurel)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 90, 'multiple_choice', 'What is the Latin name of "cherry laurel"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(290, 'A', 'Polyspora axillaris', FALSE),
(290, 'B', 'Prunus laurocerasus', TRUE),
(290, 'C', 'Protea neriifolia', FALSE),
(290, 'D', 'Populus trichocarpa', FALSE);

-- Question for PlantID 91 (Common Pear)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 91, 'multiple_choice', 'What is the Latin name of "common pear"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(291, 'A', 'Pyrus communis', TRUE),
(291, 'B', 'Protea neriifolia', FALSE),
(291, 'C', 'Prunus laurocerasus', FALSE),
(291, 'D', 'Polyspora axillaris', FALSE);

-- Question for PlantID 92 (Azalea)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 92, 'multiple_choice', 'What is the Latin name of "azalea"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(292, 'A', 'Prunus laurocerasus', FALSE),
(292, 'B', 'Pyrus communis', FALSE),
(292, 'C', 'Rhododendron sp.', TRUE),
(292, 'D', 'Protea neriifolia', FALSE);

-- Question for PlantID 93 (Rhododendron)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 93, 'multiple_choice', 'What is the Latin name of "rhododendron"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(293, 'A', 'Pyrus communis', FALSE),
(293, 'B', 'Rhododendron sp.', TRUE),
(293, 'C', 'Protea neriifolia', FALSE),
(293, 'D', 'Pachysandra terminalis', FALSE);

-- Question for PlantID 94 (Contorted Black Locust)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 94, 'multiple_choice', 'What is the Latin name of "contorted black locust"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(294, 'A', 'Protea neriifolia', FALSE),
(294, 'B', 'Pachysandra terminalis', FALSE),
(294, 'C', 'Pyrus communis', FALSE),
(294, 'D', 'Robinia pseudoacacia ''Lace Lady''', TRUE);

-- Question for PlantID 95 (Yellow Floribunda Rose)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 95, 'multiple_choice', 'What is the Latin name of "yellow floribunda rose"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(295, 'A', 'Rosa sp. ''Ivey Hall''', TRUE),
(295, 'B', 'Robinia pseudoacacia ''Lace Lady''', FALSE),
(295, 'C', 'Rhododendron sp.', FALSE),
(295, 'D', 'Protea neriifolia', FALSE);

-- Question for PlantID 96 (Common Sage)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 96, 'multiple_choice', 'What is the Latin name of "common sage"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(296, 'A', 'Robinia pseudoacacia ''Lace Lady''', FALSE),
(296, 'B', 'Salvia officinalis', TRUE),
(296, 'C', 'Rosa sp. ''Ivey Hall''', FALSE),
(296, 'D', 'Rhododendron sp.', FALSE);

-- Question for PlantID 97 (Lavender Cotton)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 97, 'multiple_choice', 'What is the Latin name of "lavender cotton"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(297, 'A', 'Rosa sp. ''Ivey Hall''', FALSE),
(297, 'B', 'Salvia officinalis', FALSE),
(297, 'C', 'Santolina chamaecyparissus', TRUE),
(297, 'D', 'Robinia pseudoacacia ''Lace Lady''', FALSE);

-- Question for PlantID 98 (Sweet Box)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 98, 'multiple_choice', 'What is the Latin name of "sweet box"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(298, 'A', 'Salvia officinalis', FALSE),
(298, 'B', 'Santolina chamaecyparissus', FALSE),
(298, 'C', 'Rosa sp. ''Ivey Hall''', FALSE),
(298, 'D', 'Sarcococca confusa', TRUE);

-- Question for PlantID 99 (Redwood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 99, 'multiple_choice', 'What is the Latin name of "redwood"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(299, 'A', 'Sequoia sempervirens', TRUE),
(299, 'B', 'Santolina chamaecyparissus', FALSE),
(299, 'C', 'Salvia officinalis', FALSE),
(299, 'D', 'Sarcococca confusa', FALSE);

-- Question for PlantID 100 (Arum or Calla Lily)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(2, 100, 'multiple_choice', 'What is the Latin name of "arum or calla lily"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(300, 'A', 'Salvia officinalis', FALSE),
(300, 'B', 'Zantedeschia aethiopica', TRUE),
(300, 'C', 'Sequoia sempervirens', FALSE),
(300, 'D', 'Santolina chamaecyparissus', FALSE);

-- Question for PlantID 101 (Paperbark Maple)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 101, 'multiple_choice', 'What is the Latin name of "paperbark maple"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(301, 'A', 'Acer griseum', TRUE),
(301, 'B', 'Corylus avellana', FALSE),
(301, 'C', 'Aesculus hippocastanum', FALSE),
(301, 'D', 'Ginkgo biloba', FALSE);

-- Question for PlantID 102 (Wind Grass)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 102, 'multiple_choice', 'What is the Latin name of "wind grass"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(302, 'A', 'Corylus avellana', FALSE),
(302, 'B', 'Anemanthele lessoniana', TRUE),
(302, 'C', 'Ginkgo biloba', FALSE),
(302, 'D', 'Acer griseum', FALSE);

-- Question for PlantID 103 (Rengarenga)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 103, 'multiple_choice', 'What is the Latin name of "rengarenga"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(303, 'A', 'Ginkgo biloba', FALSE),
(303, 'B', 'Corylus avellana', FALSE),
(303, 'C', 'Arthropodium cirratum', TRUE),
(303, 'D', 'Anemanthele lessoniana', FALSE);

-- Question for PlantID 104 (Chatham Islands Astelia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 104, 'multiple_choice', 'What is the Latin name of "Chatham Islands astelia"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(304, 'A', 'Aesculus hippocastanum', FALSE),
(304, 'B', 'Corylus avellana', FALSE),
(304, 'C', 'Ginkgo biloba', FALSE),
(304, 'D', 'Astelia chathamica', TRUE);

-- Question for PlantID 105 (South Island Toe Toe)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 105, 'multiple_choice', 'What is the Latin name of "South Island toe toe"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(305, 'A', 'Austroderia richardii', TRUE),
(305, 'B', 'Astelia chathamica', FALSE),
(305, 'C', 'Arthropodium cirratum', FALSE),
(305, 'D', 'Anemanthele lessoniana', FALSE);

-- Question for PlantID 106 (Monro's Daisy)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 106, 'multiple_choice', 'What is the Latin name of "Monro''s daisy"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(306, 'A', 'Austroderia richardii', FALSE),
(306, 'B', 'Brachyglottis monroi', TRUE),
(306, 'C', 'Ginkgo biloba', FALSE),
(306, 'D', 'Arthropodium cirratum', FALSE);

-- Question for PlantID 107 (Muttonbird Scrub)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 107, 'multiple_choice', 'What is the Latin name of "muttonbird scrub"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(307, 'A', 'Astelia chathamica', FALSE),
(307, 'B', 'Austroderia richardii', FALSE),
(307, 'C', 'Brachyglottis rotundifolia', TRUE),
(307, 'D', 'Brachyglottis monroi', FALSE);

-- Question for PlantID 108 (Native Prostrate Broom)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 108, 'multiple_choice', 'What is the Latin name of "native prostrate broom"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(308, 'A', 'Ginkgo biloba', FALSE),
(308, 'B', 'Brachyglottis monroi', FALSE),
(308, 'C', 'Astelia chathamica', FALSE),
(308, 'D', 'Carmichaelia appressa', TRUE);

-- Question for PlantID 109 (Weeping Broom)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 109, 'multiple_choice', 'What is the Latin name of "weeping broom"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(309, 'A', 'Carmichaelia stevensonii', TRUE),
(309, 'B', 'Austroderia richardii', FALSE),
(309, 'C', 'Brachyglottis rotundifolia', FALSE),
(309, 'D', 'Ginkgo biloba', FALSE);

-- Question for PlantID 110 (Hawera Sand Coprosma)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 110, 'multiple_choice', 'What is the Latin name of "Hawera sand coprosma"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(310, 'A', 'Astelia chathamica', FALSE),
(310, 'B', 'Coprosma acerosa ''Hawera''', TRUE),
(310, 'C', 'Carmichaelia appressa', FALSE),
(310, 'D', 'Brachyglottis monroi', FALSE);

-- Question for PlantID 111 (Cabbage Tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 111, 'multiple_choice', 'What is the Latin name of "cabbage tree"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(311, 'A', 'Austroderia richardii', FALSE),
(311, 'B', 'Brachyglottis rotundifolia', FALSE),
(311, 'C', 'Cordyline australis', TRUE),
(311, 'D', 'Coprosma acerosa ''Hawera''', FALSE);

-- Question for PlantID 112 (Dogwood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 112, 'multiple_choice', 'What is the Latin name of "dogwood"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(312, 'A', 'Carmichaelia stevensonii', FALSE),
(312, 'B', 'Coprosma acerosa ''Hawera''', FALSE),
(312, 'C', 'Austroderia richardii', FALSE),
(312, 'D', 'Cornus florida', TRUE);

-- Question for PlantID 113 (Karaka or NZ Laurel)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 113, 'multiple_choice', 'What is the Latin name of "karaka or NZ laurel"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(313, 'A', 'Corynocarpus laevigatus', TRUE),
(313, 'B', 'Carmichaelia stevensonii', FALSE),
(313, 'C', 'Cornus florida', FALSE),
(313, 'D', 'Coprosma acerosa ''Hawera''', FALSE);

-- Question for PlantID 114 (Rimu)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 114, 'multiple_choice', 'What is the Latin name of "rimu"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(314, 'A', 'Coprosma acerosa ''Hawera''', FALSE),
(314, 'B', 'Dacrydium cupressinum', TRUE),
(314, 'C', 'Corynocarpus laevigatus', FALSE),
(314, 'D', 'Cornus florida', FALSE);

-- Question for PlantID 115 (Turutu)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 115, 'multiple_choice', 'What is the Latin name of "turutu"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(315, 'A', 'Corynocarpus laevigatus', FALSE),
(315, 'B', 'Dacrydium cupressinum', FALSE),
(315, 'C', 'Dianella nigra', TRUE),
(315, 'D', 'Coprosma acerosa ''Hawera''', FALSE);

-- Question for PlantID 116 (Wheki or Rough Tree Fern)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 116, 'multiple_choice', 'What is the Latin name of "wheki or rough tree fern"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(316, 'A', 'Corynocarpus laevigatus', FALSE),
(316, 'B', 'Dacrydium cupressinum', FALSE),
(316, 'C', 'Dianella nigra', FALSE),
(316, 'D', 'Dicksonia squarrosa', TRUE);

-- Question for PlantID 117 (Matagouri)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 117, 'multiple_choice', 'What is the Latin name of "matagouri"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(317, 'A', 'Discaria toumatou', TRUE),
(317, 'B', 'Dianella nigra', FALSE),
(317, 'C', 'Dicksonia squarrosa', FALSE),
(317, 'D', 'Corynocarpus laevigatus', FALSE);

-- Question for PlantID 118 (Horokaka or Native Ice Plant)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 118, 'multiple_choice', 'What is the Latin name of "horokaka or native ice plant"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(318, 'A', 'Dicksonia squarrosa', FALSE),
(318, 'B', 'Disphyma australe', TRUE),
(318, 'C', 'Discaria toumatou', FALSE),
(318, 'D', 'Dianella nigra', FALSE);

-- Question for PlantID 119 (European or Common Ash)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 119, 'multiple_choice', 'What is the Latin name of "European or common ash"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(319, 'A', 'Discaria toumatou', FALSE),
(319, 'B', 'Disphyma australe', FALSE),
(319, 'C', 'Fraxinus excelsior', TRUE),
(319, 'D', 'Dianella nigra', FALSE);

-- Question for PlantID 120 (Mountain Beech)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 120, 'multiple_choice', 'What is the Latin name of "mountain beech"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(320, 'A', 'Fraxinus excelsior', FALSE),
(320, 'B', 'Disphyma australe', FALSE),
(320, 'C', 'Dicksonia squarrosa', FALSE),
(320, 'D', 'Fuscospora cliffortioides', TRUE);


-- Question for PlantID 121 (Red Beech)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 121, 'multiple_choice', 'What is the Latin name of "red beech"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(321, 'A', 'Fuscospora fusca', TRUE),
(321, 'B', 'Fraxinus excelsior', FALSE),
(321, 'C', 'Fuscospora cliffortioides', FALSE),
(321, 'D', 'Dianella nigra', FALSE);

-- Question for PlantID 122 (Maidenhair Tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 122, 'multiple_choice', 'What is the Latin name of "maidenhair tree"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(322, 'A', 'Fuscospora fusca', FALSE),
(322, 'B', 'Ginkgo biloba', TRUE),
(322, 'C', 'Fuscospora cliffortioides', FALSE),
(322, 'D', 'Fraxinus excelsior', FALSE);

-- Question for PlantID 123 (NZ Broadleaf or Kapuka)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 123, 'multiple_choice', 'What is the Latin name of "NZ broadleaf or kapuka"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(323, 'A', 'Ginkgo biloba', FALSE),
(323, 'B', 'Fuscospora fusca', FALSE),
(323, 'C', 'Griselinia littoralis', TRUE),
(323, 'D', 'Fuscospora cliffortioides', FALSE);

-- Question for PlantID 124 (Toatoa)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 124, 'multiple_choice', 'What is the Latin name of "toatoa"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(324, 'A', 'Griselinia littoralis', FALSE),
(324, 'B', 'Ginkgo biloba', FALSE),
(324, 'C', 'Fuscospora fusca', FALSE),
(324, 'D', 'Haloregis erecta ''Purpurea''', TRUE);

-- Question for PlantID 125 (Mountain Lacebark)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 125, 'multiple_choice', 'What is the Latin name of "mountain lacebark"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(325, 'A', 'Hoheria lyallii', TRUE),
(325, 'B', 'Haloregis erecta ''Purpurea''', FALSE),
(325, 'C', 'Ginkgo biloba', FALSE),
(325, 'D', 'Griselinia littoralis', FALSE);

-- Question for PlantID 126 (Kanuka)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 126, 'multiple_choice', 'What is the Latin name of "kanuka"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(326, 'A', 'Hoheria lyallii', FALSE),
(326, 'B', 'Kunzea ericoides', TRUE),
(326, 'C', 'Haloregis erecta ''Purpurea''', FALSE),
(326, 'D', 'Griselinia littoralis', FALSE);

-- Question for PlantID 127 (NZ Iris)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 127, 'multiple_choice', 'What is the Latin name of "NZ iris"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(327, 'A', 'Hoheria lyallii', FALSE),
(327, 'B', 'Kunzea ericoides', FALSE),
(327

, 'C', 'Libertia peregrinans', TRUE),
(327, 'D', 'Haloregis erecta ''Purpurea''', FALSE);

-- Question for PlantID 128 (American Sweetgum)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 128, 'multiple_choice', 'What is the Latin name of "American sweetgum"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(328, 'A', 'Kunzea ericoides', FALSE),
(328, 'B', 'Libertia peregrinans', FALSE),
(328, 'C', 'Hoheria lyallii', FALSE),
(328, 'D', 'Liquidambar styraciflua', TRUE);

-- Question for PlantID 129 (Tulip Tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 129, 'multiple_choice', 'What is the Latin name of "tulip tree"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(329, 'A', 'Liriodendron tulipifera', TRUE),
(329, 'B', 'Liquidambar styraciflua', FALSE),
(329, 'C', 'Libertia peregrinans', FALSE),
(329, 'D', 'Kunzea ericoides', FALSE);

-- Question for PlantID 130 (Silver Beech)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 130, 'multiple_choice', 'What is the Latin name of "silver beech"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(330, 'A', 'Libertia peregrinans', FALSE),
(330, 'B', 'Lophozonia menziesii', TRUE),
(330, 'C', 'Liriodendron tulipifera', FALSE),
(330, 'D', 'Liquidambar styraciflua', FALSE);

-- Question for PlantID 131 (Porcupine Scrub)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 131, 'multiple_choice', 'What is the Latin name of "porcupine scrub"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(331, 'A', 'Melicytus alpinus', TRUE),
(331, 'B', 'Libertia peregrinans', FALSE),
(331, 'C', 'Lophozonia menziesii', FALSE),
(331, 'D', 'Liquidambar styraciflua', FALSE);

-- Question for PlantID 132 (Creeping Muehlenbeckia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 132, 'multiple_choice', 'What is the Latin name of "creeping muehlenbeckia"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(332, 'A', 'Melicytus alpinus', FALSE),
(332, 'B', 'Muehlenbeckia axillaris', TRUE),
(332, 'C', 'Lophozonia menziesii', FALSE),
(332, 'D', 'Libertia peregrinans', FALSE);

-- Question for PlantID 133 (NZ Daisy Bush)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 133, 'multiple_choice', 'What is the Latin name of "NZ daisy bush"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(333, 'A', 'Melicytus alpinus', FALSE),
(333, 'B', 'Muehlenbeckia axillaris', FALSE),
(333, 'C', 'Olearia cheesemanii', TRUE),
(333, 'D', 'Lophozonia menziesii', FALSE);

-- Question for PlantID 134 (NZ Daphne)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 134, 'multiple_choice', 'What is the Latin name of "NZ daphne"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(334, 'A', 'Muehlenbeckia axillaris', FALSE),
(334, 'B', 'Melicytus alpinus', FALSE),
(334, 'C', 'Olearia cheesemanii', FALSE),
(334, 'D', 'Pimelea prostrata', TRUE);

-- Question for PlantID 135 (Karo)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 135, 'multiple_choice', 'What is the Latin name of "karo"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(335, 'A', 'Pittosporum crassifolium', TRUE),
(335, 'B', 'Pimelea prostrata', FALSE),
(335, 'C', 'Muehlenbeckia axillaris', FALSE),
(335, 'D', 'Melicytus alpinus', FALSE);

-- Question for PlantID 136 (Lemonwood or Tarata)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 136, 'multiple_choice', 'What is the Latin name of "lemonwood or tarata"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(336, 'A', 'Pittosporum crassifolium', FALSE),
(336, 'B', 'Pittosporum eugenioides', TRUE),
(336, 'C', 'Pimelea prostrata', FALSE),
(336, 'D', 'Olearia cheesemanii', FALSE);

-- Question for PlantID 137 (Kohuhu or Black Matipo)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 137, 'multiple_choice', 'What is the Latin name of "kohuhu or black matipo"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(337, 'A', 'Pimelea prostrata', FALSE),
(337, 'B', 'Pittosporum crassifolium', FALSE),
(337, 'C', 'Pittosporum tenuifolium', TRUE),
(337, 'D', 'Pittosporum eugenioides', FALSE);

-- Question for PlantID 138 (Lowland Ribbonwood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 138, 'multiple_choice', 'What is the Latin name of "lowland ribbonwood"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(338, 'A', 'Pittosporum eugenioides', FALSE),
(338, 'B', 'Pittosporum tenuifolium', FALSE),
(338, 'C', 'Pimelea prostrata', FALSE),
(338, 'D', 'Plagianthus regius', TRUE);

-- Question for PlantID 139 (London Plane)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 139, 'multiple_choice', 'What is the Latin name of "London plane"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(339, 'A', 'Platanus x acerifolia', TRUE),
(339, 'B', 'Pittosporum eugenioides', FALSE),
(339, 'C', 'Pimelea prostrata', FALSE),
(339, 'D', 'Plagianthus regius', FALSE);

-- Question for PlantID 140 (Silver Tussock)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 140, 'multiple_choice', 'What is the Latin name of "silver tussock"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(340, 'A', 'Pittosporum tenuifolium', FALSE),
(340, 'B', 'Poa cita', TRUE),
(340, 'C', 'Platanus x acerifolia', FALSE),
(340, 'D', 'Pimelea prostrata', FALSE);

-- Question for PlantID 141 (Yoshino Cherry)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 141, 'multiple_choice', 'What is the Latin name of "Yoshino cherry"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(341, 'A', 'Pimelea prostrata', FALSE),
(341, 'B', 'Pittosporum tenuifolium', FALSE),
(341, 'C', 'Prunus x yedoensis', TRUE),
(341, 'D', 'Poa cita', FALSE);

-- Question for PlantID 142 (Lancewood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 142, 'multiple_choice', 'What is the Latin name of "lancewood"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(342, 'A', 'Platanus x acerifolia', FALSE),
(342, 'B', 'Prunus x yedoensis', FALSE),
(342, 'C', 'Poa cita', FALSE),
(342, 'D', 'Pseudopanax crassifolius', TRUE);

-- Question for PlantID 143 (Fierce Lancewood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 143, 'multiple_choice', 'What is the Latin name of "fierce lancewood"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(343, 'A', 'Pseudopanax ferox', TRUE),
(343, 'B', 'Pseudopanax crassifolius', FALSE),
(343, 'C', 'Prunus x yedoensis', FALSE),
(343, 'D', 'Platanus x acerifolia', FALSE);

-- Question for PlantID 144 (Pin Oak)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 144, 'multiple_choice', 'What is the Latin name of "pin oak"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(344, 'A', 'Prunus x yedoensis', FALSE),
(344, 'B', 'Quercus palustris', TRUE),
(344, 'C', 'Pseudopanax ferox', FALSE),
(344, 'D', 'Pseudopanax crassifolius', FALSE);

-- Question for PlantID 145 (English Oak)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 145, 'multiple_choice', 'What is the Latin name of "English oak"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(345, 'A', 'Quercus palustris', FALSE),
(345, 'B', 'Pseudopanax crassifolius', FALSE),
(345, 'C', 'Quercus robur', TRUE),
(345, 'D', 'Prunus x yedoensis', FALSE);

-- Question for PlantID 146 (Poroporo)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 146, 'multiple_choice', 'What is the Latin name of "poroporo"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(346, 'A', 'Pseudopanax crassifolius', FALSE),
(346, 'B', 'Quercus robur', FALSE),
(346, 'C', 'Quercus palustris', FALSE),
(346, 'D', 'Solanum laciniatum', TRUE);

-- Question for PlantID 147 (South Island Kowhai)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 147, 'multiple_choice', 'What is the Latin name of "South Island kowhai"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(347, 'A', 'Sophora microphylla', TRUE),
(347, 'B', 'Solanum laciniatum', FALSE),
(347, 'C', 'Quercus robur', FALSE),
(347, 'D', 'Quercus palustris', FALSE);

-- Question for PlantID 148 (Cook Strait Kowhai)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 148, 'multiple_choice', 'What is the Latin name of "Cook Strait kowhai"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(348, 'A', 'Quercus robur', FALSE),
(348, 'B', 'Sophora molloyi \'Dragons Gold\'', TRUE),
(348, 'C', 'Sophora microphylla', FALSE),
(348, 'D', 'Solanum laciniatum', FALSE);

-- Question for PlantID 149 (North Island Kowhai)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 149, 'multiple_choice', 'What is the Latin name of "North Island kowhai"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(349, 'A', 'Sophora molloyi \'Dragons Gold\'', FALSE),
(349, 'B', 'Solanum laciniatum', FALSE),
(349, 'C', 'Sophora tetraptera', TRUE),
(349, 'D', 'Quercus robur', FALSE);

-- Question for PlantID 150 (New Zealand Lilac)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(3, 150, 'multiple_choice', 'What is the Latin name of "New Zealand lilac"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(350, 'A', 'Quercus robur', FALSE),
(350, 'B', 'Sophora molloyi \'Dragons Gold\'', FALSE),
(350, 'C', 'Sophora tetraptera', FALSE),
(350, 'D', 'Veronica hulkeana', TRUE);

-- Question for PlantID 151 (Kauri)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 151, 'multiple_choice', 'What is the Latin name of "kauri"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(351, 'A', 'Agathis australis', TRUE),
(351, 'B', 'Sophora tetraptera', FALSE),
(351, 'C', 'Quercus robur', FALSE),
(351, 'D', 'Solanum laciniatum', FALSE);

-- Question for PlantID 152 (Oioi)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 152, 'multiple_choice', 'What is the Latin name of "oioi"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(352, 'A', 'Sophora tetraptera', FALSE),
(352, 'B', 'Apodasmia similis', TRUE),
(352, 'C', 'Agathis australis', FALSE),
(352, 'D', 'Quercus robur', FALSE);

-- Question for PlantID 153 (Japanese Camellia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 153, 'multiple_choice', 'What is the Latin name of "Japanese camellia"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(353, 'A', 'Quercus robur', FALSE),
(353, 'B', 'Apodasmia similis', FALSE),
(353, 'C', 'Camellia japonica', TRUE),
(353, 'D', 'Agathis australis', FALSE);

-- Question for PlantID 154 (Autumn Camellia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 154, 'multiple_choice', 'What is the Latin name of "autumn camellia"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(354, 'A', 'Apodasmia similis', FALSE),
(354, 'B', 'Camellia japonica', FALSE),
(354, 'C', 'Quercus robur', FALSE),
(354, 'D', 'Camellia sasanqua', TRUE);

-- Question for PlantID 155 (Pukio)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 155, 'multiple_choice', 'What is the Latin name of "pukio"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(355, 'A', 'Carex secta', TRUE),
(355, 'B', 'Camellia sasanqua', FALSE),
(355, 'C', 'Camellia japonica', FALSE),
(355, 'D', 'Apodasmia similis', FALSE);

-- Question for PlantID 156 (Orange Sedge)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 156, 'multiple_choice', 'What is the Latin name of "orange sedge"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(356, 'A', 'Camellia japonica', FALSE),
(356, 'B', 'Carex testacea', TRUE),
(356, 'C', 'Carex secta', FALSE),
(356, 'D', 'Camellia sasanqua', FALSE);

-- Question for PlantID 157 (Marble Leaf or Putaputaweta)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 157, 'multiple_choice', 'What is the Latin name of "marble leaf or putaputaweta"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(357, 'A', 'Carex testacea', FALSE),
(357, 'B', 'Camellia sasanqua', FALSE),
(357, 'C', 'Carpodetus serratus', TRUE),
(357, 'D', 'Camellia japonica', FALSE);

-- Question for PlantID 158 (Indian Bean Tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 158, 'multiple_choice', 'What is the Latin name of "Indian bean tree"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(358, 'A', 'Camellia japonica', FALSE),
(358, 'B', 'Carex testacea', FALSE),
(358, 'C', 'Carex secta', FALSE),
(358, 'D', 'Catalpa bignonioides', TRUE);

-- Question for PlantID 159 (Mexican Orange Blossom)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 159, 'multiple_choice', 'What is the Latin name of "Mexican orange blossom"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(359, 'A', 'Choisya ternata', TRUE),
(359, 'B', 'Carex secta', FALSE),
(359, 'C', 'Carpodetus serratus', FALSE),
(359, 'D', 'Catalpa bignonioides', FALSE);

-- Question for PlantID 160 (Puawhananga)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 160, 'multiple_choice', 'What is the Latin name of "puawhananga"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(360, 'A', 'Carpodetus serratus', FALSE),
(360, 'B', 'Clematis paniculata', TRUE),
(360, 'C', 'Choisya ternata', FALSE),
(360, 'D', 'Carex secta', FALSE);

-- Question for PlantID 161 (Kakabeak)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 161, 'multiple_choice', 'What is the Latin name of "kakabeak"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(361, 'A', 'Catalpa bignonioides', FALSE),
(361, 'B', 'Clematis paniculata', FALSE),
(361, 'C', 'Clianthus maximus', TRUE),
(361, 'D', 'Choisya ternata', FALSE);

-- Question for PlantID 162 (Mingimingi)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 162, 'multiple_choice', 'What is the Latin name of "mingimingi"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(362, 'A', 'Clematis paniculata', FALSE),
(362, 'B', 'Clianthus maximus', FALSE),
(362, 'C', 'Choisya ternata', FALSE),
(362, 'D', 'Coprosma propinqua', TRUE);

-- Question for PlantID 163 (Red Coprosma)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 163, 'multiple_choice', 'What is the Latin name of "red coprosma"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(363, 'A', 'Coprosma rugosa ''Lobster''', TRUE),
(363, 'B', 'Coprosma propinqua', FALSE),
(363, 'C', 'Clematis paniculata', FALSE),
(363, 'D', 'Clianthus maximus', FALSE);

-- Question for PlantID 164 (Smoke Bush)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 164, 'multiple_choice', 'What is the Latin name of "smoke bush"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(364, 'A', 'Coprosma propinqua', FALSE),
(364, 'B', 'Cotinus coggygria', TRUE),
(364, 'C', 'Coprosma rugosa ''Lobster''', FALSE),
(364, 'D', 'Clematis paniculata', FALSE);

-- Question for PlantID 165 (Macrocarpa)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 165, 'multiple_choice', 'What is the Latin name of "macrocarpa"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(365, 'A', 'Clematis paniculata', FALSE),
(365, 'B', 'Cotinus coggygria', FALSE),
(365, 'C', 'Cupressus macrocarpa', TRUE),
(365, 'D', 'Coprosma rugosa ''Lobster''', FALSE);

-- Question for PlantID 166 (Italian Cypress)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 166, 'multiple_choice', 'What is the Latin name of "Italian cypress"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(366, 'A', 'Cotinus coggygria', FALSE),
(366, 'B', 'Clematis paniculata', FALSE),
(366, 'C', 'Cupressus macrocarpa', FALSE),
(366, 'D', 'Cupressus sempervirens', TRUE);


-- Question for PlantID 167 (Inaka or Neinei)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 167, 'multiple_choice', 'What is the Latin name of "inaka or neinei"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(367, 'A', 'Eucalyptus viminalis', FALSE),
(367, 'B', 'Corylus avellana', FALSE),
(367, 'C', 'Dracophyllum sinclairii', TRUE),
(367, 'D', 'Coprosma propinqua', FALSE);

-- Question for PlantID 168 (Shore Spurge or Waiuatua)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 168, 'multiple_choice', 'What is the Latin name of "shore spurge or waiuatua"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(368, 'A', 'Fuchsia procumbens', FALSE),
(368, 'B', 'Euphorbia glauca', TRUE),
(368, 'C', 'Griselinia littoralis', FALSE),
(368, 'D', 'Alectryon excelsus', FALSE);

-- Question for PlantID 169 (Creeping Fig)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 169, 'multiple_choice', 'What is the Latin name of "creeping fig"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(369, 'A', 'Cordyline australis', FALSE),
(369, 'B', 'Anemanthele lessoniana', FALSE),
(369, 'C', 'Dodonaea viscosa', FALSE),
(369, 'D', 'Ficus pumila', TRUE);

-- Question for PlantID 170 (Creeping Fuchsia)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 170, 'multiple_choice', 'What is the Latin name of "creeping fuchsia"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(370, 'A', 'Fuchsia procumbens', TRUE),
(370, 'B', 'Sophora tetraptera', FALSE),
(370, 'C', 'Pseudopanax crassifolius', FALSE),
(370, 'D', 'Leptospermum scoparium', FALSE);

-- Question for PlantID 171 (Black Beech)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 171, 'multiple_choice', 'What is the Latin name of "black beech"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(371, 'A', 'Pittosporum tenuifolium', FALSE),
(371, 'B', 'Fuscospora solandri', TRUE),
(371, 'C', 'Melicytus ramiflorus', FALSE),
(371, 'D', 'Metrosideros excelsa', FALSE);

-- Question for PlantID 172 (Lenten Rose)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 172, 'multiple_choice', 'What is the Latin name of "lenten rose"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(372, 'A', 'Dacrydium cupressinum', FALSE),
(372, 'B', 'Hebe stricta', FALSE),
(372, 'C', 'Helleborus orientalis', TRUE),
(372, 'D', 'Ficus carica', FALSE);

-- Question for PlantID 173 (Mophead Hydrangea)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 173, 'multiple_choice', 'What is the Latin name of "mophead hydrangea"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(373, 'A', 'Hydrangea macrophylla', TRUE),
(373, 'B', 'Lophomyrtus bullata', FALSE),
(373, 'C', 'Phormium tenax', FALSE),
(373, 'D', 'Corynocarpus laevigatus', FALSE);

-- Question for PlantID 174 (Panicled Hydrangea)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 174, 'multiple_choice', 'What is the Latin name of "panicled hydrangea"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(374, 'A', 'Nothofagus solandri', FALSE),
(374, 'B', 'Rhododendron arboreum', FALSE),
(374, 'C', 'Kunzea ericoides', FALSE),
(374, 'D', 'Hydrangea paniculata', TRUE);

-- Question for PlantID 175 (Giant Club Rush)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 175, 'multiple_choice', 'What is the Latin name of "giant club rush"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(375, 'A', 'Acaena inermis', FALSE),
(375, 'B', 'Juncus pallidus', TRUE),
(375, 'C', 'Gratiola sexdentata', FALSE),
(375, 'D', 'Euphorbia lathyris', FALSE);

-- Question for PlantID 176 (Rohutu or NZ Myrtle)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 176, 'multiple_choice', 'What is the Latin name of "rohutu or NZ myrtle"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(376, 'A', 'Griselinia lucida', FALSE),
(376, 'B', 'Coprosma repens', FALSE),
(376, 'C', 'Lophomyrtus obcordata', TRUE),
(376, 'D', 'Melicope ternata', FALSE);

-- Question for PlantID 177 (Hybrid Lophomyrtus or NZ Myrtle)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 177, 'multiple_choice', 'What is the Latin name of "hybrid lophomyrtus or NZ myrtle"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(377, 'A', 'Lophomyrtus x ralphii', TRUE),
(377, 'B', 'Cordyline australis', FALSE),
(377, 'C', 'Pseudopanax lessonii', FALSE),
(377, 'D', 'Rhopalostylis sapida', FALSE);

-- Question for PlantID 178 (Mahoe or Whiteywood)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 178, 'multiple_choice', 'What is the Latin name of "mahoe or whiteywood"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(378, 'A', 'Sophora microphylla', FALSE),
(378, 'B', 'Metrosideros excelsa', FALSE),
(378, 'C', 'Hoheria populnea', FALSE),
(378, 'D', 'Melicytus ramiflorus', TRUE);

-- Question for PlantID 179 (Bush Rice Grass)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 179, 'multiple_choice', 'What is the Latin name of "bush rice grass"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(379, 'A', 'Poa cita', FALSE),
(379, 'B', 'Microleana avenacea', TRUE),
(379, 'C', 'Carex virgata', FALSE),
(379, 'D', 'Chionochloa rubra', FALSE);

-- Question for PlantID 180 (Small Leaved Pohuehue)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 180, 'multiple_choice', 'What is the Latin name of "small leaved pohuehue"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(380, 'A', 'Muehlenbeckia complexa', TRUE),
(380, 'B', 'Hebe salicifolia', FALSE),
(380, 'C', 'Pittosporum eugenioides', FALSE),
(380, 'D', 'Carmichaelia australis', FALSE);

-- Question for PlantID 181 (Cat Mint)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 181, 'multiple_choice', 'What is the Latin name of "cat mint"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(381, 'A', 'Metrosideros excelsa', FALSE),
(381, 'B', 'Dacrycarpus dacrydioides', FALSE),
(381, 'C', 'Eucalyptus globulus', FALSE),
(381, 'D', 'Nepeta mussinii', TRUE);

-- Question for PlantID 182 (Marlborough Rock Daisy)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 182, 'multiple_choice', 'What is the Latin name of "Marlborough rock daisy"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(382, 'A', 'Phormium tenax', FALSE),
(382, 'B', 'Rhopalostylis sapida', FALSE),
(382, 'C', 'Pachystegia insignis', TRUE),
(382, 'D', 'Carpodetus serratus', FALSE);

-- Question for PlantID 183 (Marlborough Rock Daisy)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 183, 'multiple_choice', 'What is the Latin name of "Marlborough rock daisy"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(383, 'A', 'Lophomyrtus bullata', FALSE),
(383, 'B', 'Pachystegia rufa', TRUE),
(383, 'C', 'Myrsine australis', FALSE),
(383, 'D', 'Kunzea ericoides', FALSE);

-- Question for PlantID 184 (Miro)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 184, 'multiple_choice', 'What is the Latin name of "miro"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(384, 'A', 'Prumnopitys ferruginea', TRUE),
(384, 'B', 'Alectryon excelsus', FALSE),
(384, 'C', 'Nothofagus menziesii', FALSE),
(384, 'D', 'Cordyline australis', FALSE);

-- Question for PlantID 185 (Mountain Toatoa or Celery Pine)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 185, 'multiple_choice', 'What is the Latin name of "mountain toatoa or celery pine"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(385, 'A', 'Sophora microphylla', FALSE),
(385, 'B', 'Grateloupia doryphora', FALSE),
(385, 'C', 'Metrosideros robusta', FALSE),
(385, 'D', 'Phyllocladus alpinus', TRUE);

-- Question for PlantID 186 (Tenakaha)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 186, 'multiple_choice', 'What is the Latin name of "tenakaha"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(386, 'A', 'Pittosporum crassifolium', FALSE),
(386, 'B', 'Phyllocladus trichomanoides', TRUE),
(386, 'C', 'Rhabdothamnus solandri', FALSE),
(386, 'D', 'Olearia solandri', FALSE);

-- Question for PlantID 187 (Dwarf Pittosporum)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 187, 'multiple_choice', 'What is the Latin name of "dwarf pittosporum"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(387, 'A', 'Kunzea amathicola', FALSE),
(387, 'B', 'Hebe topiaria', FALSE),
(387, 'C', 'Pittosporum tenuifolium "Sumo"', TRUE),
(387, 'D', 'Fuchsia excorticata', FALSE);

-- Question for PlantID 188 (Mountain or Hall's Totara)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 188, 'multiple_choice', 'What is the Latin name of "mountain or Halls totara"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(388, 'A', 'Podocarpus laetus', TRUE),
(388, 'B', 'Dacrydium cupressinum', FALSE),
(388, 'C', 'Pseudopanax crassifolius', FALSE),
(388, 'D', 'Leptospermum scoparium', FALSE);

-- Question for PlantID 189 (Snow or Mountain Totara)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 189, 'multiple_choice', 'What is the Latin name of "snow or mountain totara"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(389, 'A', 'Metrosideros excelsa', FALSE),
(389, 'B', 'Agathis australis', FALSE),
(389, 'C', 'Podocarpus nivalis', TRUE),
(389, 'D', 'Alectryon excelsus', FALSE);

-- Question for PlantID 190 (Totara)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 190, 'multiple_choice', 'What is the Latin name of "totara"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(390, 'A', 'Rhopalostylis sapida', FALSE),
(390, 'B', 'Podocarpus totara', TRUE),
(390, 'C', 'Beilschmiedia tawa', FALSE),
(390, 'D', 'Pittosporum eugenioides', FALSE);

-- Question for PlantID 191 (Matai)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 191, 'multiple_choice', 'What is the Latin name of "matai"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(391, 'A', 'Metrosideros robusta', FALSE),
(391, 'B', 'Corynocarpus laevigatus', FALSE),
(391, 'C', 'Alectryon excelsus', FALSE),
(391, 'D', 'Prumnopitys taxifolia', TRUE);

-- Question for PlantID 192 (Houpara)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 192, 'multiple_choice', 'What is the Latin name of "houpara"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(392, 'A', 'Phormium tenax', FALSE),
(392, 'B', 'Pseudopanax lessonii', TRUE),
(392, 'C', 'Leptospermum scoparium', FALSE),
(392, 'D', 'Dacrydium cupressinum', FALSE);

-- Question for PlantID 193 (Horopito or Pepper Tree)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 193, 'multiple_choice', 'What is the Latin name of "horopito or pepper tree"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(393, 'A', 'Pseudowintera colorata', TRUE),
(393, 'B', 'Kunzea ericoides', FALSE),
(393, 'C', 'Pittosporum eugenioides', FALSE),
(393, 'D', 'Metrosideros excelsa', FALSE);

-- Question for PlantID 194 (Red Oak)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 194, 'multiple_choice', 'What is the Latin name of "red oak"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(394, 'A', 'Alectryon excelsus', FALSE),
(394, 'B', 'Agathis australis', FALSE),
(394, 'C', 'Quercus rubra', TRUE),
(394, 'D', 'Rhopalostylis sapida', FALSE);

-- Question for PlantID 195 (Bush Lawyer)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 195, 'multiple_choice', 'What is the Latin name of "bush lawyer"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(395, 'A', 'Corynocarpus laevigatus', FALSE),
(395, 'B', 'Rubus cissoides', TRUE),
(395, 'C', 'Leptospermum scoparium', FALSE),
(395, 'D', 'Pittosporum eugenioides', FALSE);

-- Question for PlantID 196 (Stonecrop)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 196, 'multiple_choice', 'What is the Latin name of "stonecrop"?', 'D');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(396, 'A', 'Metrosideros excelsa', FALSE),
(396, 'B', 'Alectryon excelsus', FALSE),
(396, 'C', 'Phormium tenax', FALSE),
(396, 'D', 'Sedum spectabile "Autumn Joy"', TRUE);

-- Question for PlantID 197 (Rowan)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 197, 'multiple_choice', 'What is the Latin name of "rowan"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(397, 'A', 'Sorbus aucuparia', TRUE),
(397, 'B', 'Corynocarpus laevigatus', FALSE),
(397, 'C', 'Rhopalostylis sapida', FALSE),
(397, 'D', 'Dacrycarpus dacrydioides', FALSE);

-- Question for PlantID 198 (Raupo or Bullrush)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 198, 'multiple_choice', 'What is the Latin name of "raupo or bullrush"?', 'C');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(398, 'A', 'Kunzea ericoides', FALSE),
(398, 'B', 'Leptospermum scoparium', FALSE),
(398, 'C', 'Typha orientalis', TRUE),
(398, 'D', 'Pseudopanax crassifolius', FALSE);

-- Question for PlantID 199 (Prostrate Hebe)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 199, 'multiple_choice', 'What is the Latin name of "prostrate hebe"?', 'B');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(399, 'A', 'Pittosporum tenuifolium', FALSE),
(399, 'B', 'Veronica odora "Prostrata"', TRUE),
(399, 'C', 'Rhopalostylis sapida', FALSE),
(399, 'D', 'Corynocarpus laevigatus', FALSE);

-- Question for PlantID 200 (Chinese Wisteria)
INSERT INTO Questions (QuizID, PlantID, QuestionType, QuestionText, CorrectAnswer) VALUES 
(4, 200, 'multiple_choice', 'What is the Latin name of "Chinese wisteria"?', 'A');
INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText, IsCorrect) VALUES
(400, 'A', 'Wisteria sinensis', TRUE),
(400, 'B', 'Metrosideros excelsa', FALSE),
(400, 'C', 'Alectryon excelsus', FALSE),
(400, 'D', 'Phormium tenax', FALSE);

