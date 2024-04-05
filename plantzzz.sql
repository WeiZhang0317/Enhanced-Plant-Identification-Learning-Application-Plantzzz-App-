


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
('LASC206 Plant Quiz 2', 2, NOW());


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
