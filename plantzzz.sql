


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

CREATE TABLE Quizzes (
    QuizID INT AUTO_INCREMENT PRIMARY KEY,
    Semester VARCHAR(255) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Questions (
    QuestionID INT AUTO_INCREMENT PRIMARY KEY,
    QuizID INT,
    QuestionType VARCHAR(255),
    QuestionText VARCHAR(1000),
    PlantName VARCHAR(255),
    CorrectAnswer VARCHAR(255),
    FOREIGN KEY (QuizID) REFERENCES Quizzes(QuizID) ON DELETE CASCADE
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
    ('LASC 206_S2_Test 2'),
    ('LASC 206_S2_Test 1'),
    ('LASC 211_S1_Test 1'),
    ('LASC 211_S1_Test 2');



INSERT INTO plants_semesters (plant_id, semester_id) 
VALUES (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 1), (11, 1), (12, 1), (13, 1), (14, 1), (15, 1), (16, 1), (17, 1), (18, 1), (19, 1), (20, 1), (21, 1), (22, 1), (23, 1), (24, 1), (25, 1), (26, 1), (27, 1), (28, 1), (29, 1), (30, 1), (31, 1), (32, 1), (33, 1), (34, 1), (35, 1), (36, 1), (37, 1), (38, 1), (39, 1), (40, 1), (41, 1), (42, 1), (43, 1), (44, 1), (45, 1), (46, 1), (47, 1), (48, 1), (49, 1), (50, 1), (51, 2), (52, 2), (53, 2), (54, 2), (55, 2), (56, 2), (57, 2), (58, 2), (59, 2), (60, 2), (61, 2), (62, 2), (63, 2), (64, 2), (65, 2), (66, 2), (67, 2), (68, 2), (69, 2), (70, 2), (71, 2), (72, 2), (73, 2), (74, 2), (75, 2), (76, 2), (77, 2), (78, 2), (79, 2), (80, 2), (81, 2), (82, 2), (83, 2), (84, 2), (85, 2), (86, 2), (87, 2), (88, 2), (89, 2), (90, 2), (91, 2), (92, 2), (93, 2), (94, 2), (95, 2), (96, 2), (97, 2), (98, 2), (99, 2), (100, 2), (101, 3), (102, 3), (103, 3), (104, 3), (105, 3), (106, 3), (107, 3), (108, 3), (109, 3), (110, 3), (111, 3), (112, 3), (113, 3), (114, 3), (115, 3), (116, 3), (117, 3), (118, 3), (119, 3), (120, 3), (121, 3), (122, 3), (123, 3), (124, 3), (125, 3), (126, 3), (127, 3), (128, 3), (129, 3), (130, 3), (131, 3), (132, 3), (133, 3), (134, 3), (135, 3), (136, 3), (137, 3), (138, 3), (139, 3), (140, 3), (141, 3), (142, 3), (143, 3), (144, 3), (145, 3), (146, 3), (147, 3), (148, 3), (149, 3), (150, 3), (151, 4), (152, 4), (153, 4), (154, 4), (155, 4), (156, 4), (157, 4), (158, 4), (159, 4), (160, 4), (161, 4), (162, 4), (163, 4), (164, 4), (165, 4), (166, 4), (167, 4), (168, 4), (169, 4), (170, 4), (171, 4), (172, 4), (173, 4), (174, 4), (175, 4), (176, 4), (177, 4), (178, 4), (179, 4), (180, 4), (181, 4), (182, 4), (183, 4), (184, 4), (185, 4), (186, 4), (187, 4), (188, 4), (189, 4), (190, 4), (191, 4), (192, 4), (193, 4), (194, 4), (195, 4), (196, 4), (197, 4), (198, 4), (199, 4),(200, 4);