-- Tournament
CREATE TABLE Tournament (
    tournament_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Year INT
);

-- Series
CREATE TABLE Bilateral_series (
    Series_id INT PRIMARY KEY,
    Name VARCHAR(100)
);

-- Match
CREATE TABLE `Match` (
    Match_id INT PRIMARY KEY,
    Umpire VARCHAR(100),
    Result VARCHAR(100),
    Score1 INT,
  	Score2 INT,
    Format VARCHAR(20),
    Date DATE
);

-- Series-Match relationship
CREATE TABLE includes (
    Series_id INT,
    Match_id INT,
    FOREIGN KEY (Series_id) REFERENCES Bilateral_series(Series_id),
    FOREIGN KEY (Match_id) REFERENCES `Match`(Match_id)
);

-- Tournament-Match relationship
CREATE TABLE consists_of (
    tournament_id INT,
    Match_id INT,
    FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id),
    FOREIGN KEY (Match_id) REFERENCES `Match`(Match_id)
);

-- Venue
CREATE TABLE Venue (
    Venue_id INT PRIMARY KEY,
    Stadium VARCHAR(100),
    Country VARCHAR(50),
    T20_batting_averages FLOAT,
    ODI_batting_averages FLOAT,
    Test_batting_averages FLOAT
);

-- Match-Venue relationship
CREATE TABLE played_at (
    Match_id INT,
    Venue_id INT,
    FOREIGN KEY (Match_id) REFERENCES `Match`(Match_id),
    FOREIGN KEY (Venue_id) REFERENCES Venue(Venue_id)
);

-- Team
CREATE TABLE Team (
    Team_Name VARCHAR(50) PRIMARY KEY,
    Captain VARCHAR(50),
    VC VARCHAR(50)
);

-- Player
CREATE TABLE Player (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    DOB DATE,
    Bowling_style VARCHAR(50),
    Batting_style VARCHAR(50),
    Nationality VARCHAR(50),
    Jersey_no INT
);

-- Team-Tournament relationship
CREATE TABLE competes_in (
    Team_Name VARCHAR(50),
    tournament_id INT,
    FOREIGN KEY (Team_Name) REFERENCES Team(Team_Name),
    FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id)
);

-- Player-Team relationship
CREATE TABLE plays_for (
    ID INT,
    Team_Name VARCHAR(50),
    FOREIGN KEY (ID) REFERENCES Player(ID),
    FOREIGN KEY (Team_Name) REFERENCES Team(Team_Name)
);

-- Match-Player relationship
CREATE TABLE plays_in_match (
    ID INT,
    Match_id INT,
    FOREIGN KEY (ID) REFERENCES Player(ID),
    FOREIGN KEY (Match_id) REFERENCES `Match`(Match_id)
);

-- Match stats
CREATE TABLE Player_match_stats (
    player_id INT,
    Match_id INT,
    Balls_faced INT,
    Runs INT,
    Overs_bowled FLOAT,
    Runs_given INT,
    Wickets INT,
    Catches INT,
    Stumpouts INT,
    Runouts INT,
    PRIMARY KEY (player_id, Match_id),
    FOREIGN KEY (player_id) REFERENCES Player(ID),
    FOREIGN KEY (Match_id) REFERENCES `Match`(Match_id)
);

-- Player-Tournament relationship
CREATE TABLE plays_in_tournament (
    ID INT,
    player_id INT,
    tournament_id INT,
    FOREIGN KEY (player_id) REFERENCES Player(ID),
    FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id)
);

-- Player_Tournament_Stats
CREATE TABLE Player_tournament_stats (
    player_id INT,
    tournament_id INT,
    PRIMARY KEY (player_id, tournament_id),
    FOREIGN KEY (player_id) REFERENCES Player(ID),
    FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id)
);

-- Batting Stats
CREATE TABLE Batting_stats (
    Batting_id INT PRIMARY KEY,
    Format VARCHAR(20),
    Runs INT,
    Average FLOAT,
    Strike_rate FLOAT,
    Matches INT,
    Fifties INT,
    Hundreds INT,
    Highest_score INT
);

-- has_batting_stats
CREATE TABLE has_batting_stats (
    ID INT,
    Batting_id INT,
    FOREIGN KEY (ID) REFERENCES Player(ID),
    FOREIGN KEY (Batting_id) REFERENCES Batting_stats(Batting_id)
);

-- Bowling Stats
CREATE TABLE Bowling_stats (
    Bowling_id INT PRIMARY KEY,
    Format VARCHAR(20),
    Matches INT,
    Wickets INT,
    Economy_rate FLOAT,
    Best_figures VARCHAR(20)
);

-- has_bowling_stats
CREATE TABLE has_bowling_stats (
    ID INT,
    Bowling_id INT,
    FOREIGN KEY (ID) REFERENCES Player(ID),
    FOREIGN KEY (Bowling_id) REFERENCES Bowling_stats(Bowling_id)
);

-- Fielding Stats
CREATE TABLE Fielding_stats (
    Fielding_id INT PRIMARY KEY,
    Format VARCHAR(20),
    Matches INT,
    Catches INT,
    Stumpings INT,
    Runouts INT
);

-- has_fielding_stats
CREATE TABLE has_fielding_stats (
    ID INT,
    Fielding_id INT,
    FOREIGN KEY (ID) REFERENCES Player(ID),
    FOREIGN KEY (Fielding_id) REFERENCES Fielding_stats(Fielding_id)
);

-- Tournament-specific stats (batting)
CREATE TABLE has_batting_stats_tournament (
    player_id INT,
    tournament_id INT,
    Batting_id INT,
    FOREIGN KEY (player_id) REFERENCES Player(ID),
    FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id),
    FOREIGN KEY (Batting_id) REFERENCES Batting_stats(Batting_id)
);

-- Tournament-specific stats (bowling)
CREATE TABLE has_bowling_stats_tournament (
    player_id INT,
    tournament_id INT,
    Bowling_id INT,
    FOREIGN KEY (player_id) REFERENCES Player(ID),
    FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id),
    FOREIGN KEY (Bowling_id) REFERENCES Bowling_stats(Bowling_id)
);

-- Tournament-specific stats (fielding)
CREATE TABLE has_fielding_stats_tournament (
    player_id INT,
    tournament_id INT,
    Fielding_id INT,
    FOREIGN KEY (player_id) REFERENCES Player(ID),
    FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id),
    FOREIGN KEY (Fielding_id) REFERENCES Fielding_stats(Fielding_id)
);

-- Insert data into Tournament table
INSERT INTO Tournament (tournament_id, Name, Year) VALUES
(1, 'ICC Cricket World Cup', 2023),
(2, 'ICC T20 World Cup', 2022),
(3, 'Asia Cup', 2023),
(4, 'Ashes Series', 2023),
(5, 'Border-Gavaskar Trophy', 2023);

-- Insert data into Bilateral_series table
INSERT INTO Bilateral_series (Series_id, Name) VALUES
(1, 'India vs Australia ODI Series'),
(2, 'England vs New Zealand Test Series'),
(3, 'Pakistan vs South Africa T20 Series'),
(4, 'Sri Lanka vs Bangladesh ODI Series'),
(5, 'West Indies vs Ireland T20 Series');

-- Insert data into Venue table
INSERT INTO Venue (Venue_id, Stadium, Country, T20_batting_averages, ODI_batting_averages, Test_batting_averages) VALUES
(1, 'Wankhede Stadium', 'India', 28.5, 32.1, 35.7),
(2, 'Melbourne Cricket Ground', 'Australia', 26.8, 30.5, 33.2),
(3, 'Lords', 'England', 25.9, 29.8, 34.1),
(4, 'Newlands', 'South Africa', 27.3, 31.2, 36.4),
(5, 'Eden Gardens', 'India', 29.1, 33.5, 37.2),
(6, 'Gaddafi Stadium', 'Pakistan', 28.7, 32.8, 35.9),
(7, 'Dubai International Stadium', 'UAE', 26.5, 30.2, NULL);

-- Insert data into Team table
INSERT INTO Team (Team_Name, Captain, VC) VALUES
('India', 'Rohit Sharma', 'Hardik Pandya'),
('Australia', 'Pat Cummins', 'Steve Smith'),
('England', 'Jos Buttler', 'Ben Stokes'),
('New Zealand', 'Kane Williamson', 'Trent Boult'),
('South Africa', 'Temba Bavuma', 'Aiden Markram'),
('Pakistan', 'Babar Azam', 'Shadab Khan'),
('Sri Lanka', 'Dasun Shanaka', 'Dhananjaya de Silva'),
('Bangladesh', 'Shakib Al Hasan', 'Litton Das'),
('West Indies', 'Nicholas Pooran', 'Jason Holder'),
('Ireland', 'Andrew Balbirnie', 'Paul Stirling');

-- Insert data into Player table
INSERT INTO Player (ID, Name, Age, DOB, Bowling_style, Batting_style, Nationality, Jersey_no) VALUES
-- Indian players
(1, 'Rohit Sharma', 36, '1987-04-30', 'Right-arm offbreak', 'Right-handed', 'India', 45),
(2, 'Virat Kohli', 34, '1988-11-05', 'Right-arm medium', 'Right-handed', 'India', 18),
(3, 'Jasprit Bumrah', 29, '1993-12-06', 'Right-arm fast', 'Right-handed', 'India', 93),
(4, 'Hardik Pandya', 29, '1993-10-11', 'Right-arm fast-medium', 'Right-handed', 'India', 33),
(5, 'Ravindra Jadeja', 34, '1988-12-06', 'Left-arm orthodox', 'Left-handed', 'India', 8),
-- Australian players
(6, 'Pat Cummins', 30, '1993-05-08', 'Right-arm fast', 'Right-handed', 'Australia', 30),
(7, 'Steve Smith', 34, '1989-06-02', 'Right-arm legbreak', 'Right-handed', 'Australia', 49),
(8, 'David Warner', 36, '1986-10-27', 'Right-arm legbreak', 'Left-handed', 'Australia', 31),
(9, 'Glenn Maxwell', 34, '1988-10-14', 'Right-arm offbreak', 'Right-handed', 'Australia', 32),
(10, 'Mitchell Starc', 33, '1990-01-30', 'Left-arm fast', 'Left-handed', 'Australia', 56),
-- Other teams' players
(11, 'Jos Buttler', 32, '1990-09-08', NULL, 'Right-handed', 'England', 63),
(12, 'Ben Stokes', 31, '1991-06-04', 'Right-arm fast-medium', 'Left-handed', 'England', 55),
(13, 'Kane Williamson', 32, '1990-08-08', 'Right-arm offbreak', 'Right-handed', 'New Zealand', 22),
(14, 'Trent Boult', 33, '1989-07-22', 'Left-arm fast-medium', 'Right-handed', 'New Zealand', 18),
(15, 'Babar Azam', 28, '1994-10-15', 'Right-arm offbreak', 'Right-handed', 'Pakistan', 56),
(16, 'Shadab Khan', 24, '1998-10-04', 'Right-arm legbreak', 'Right-handed', 'Pakistan', 7),
(17, 'Temba Bavuma', 32, '1990-05-17', 'Right-arm medium', 'Right-handed', 'South Africa', 12),
(18, 'Quinton de Kock', 30, '1992-12-17', NULL, 'Left-handed', 'South Africa', 12),
(19, 'Dasun Shanaka', 31, '1991-09-09', 'Right-arm medium', 'Right-handed', 'Sri Lanka', 9),
(20, 'Shakib Al Hasan', 36, '1987-03-24', 'Left-arm orthodox', 'Left-handed', 'Bangladesh', 75);

-- Insert data into plays_for table
INSERT INTO plays_for (ID, Team_Name) VALUES
-- Indian players
(1, 'India'), (2, 'India'), (3, 'India'), (4, 'India'), (5, 'India'),
-- Australian players
(6, 'Australia'), (7, 'Australia'), (8, 'Australia'), (9, 'Australia'), (10, 'Australia'),
-- Other teams' players
(11, 'England'), (12, 'England'),
(13, 'New Zealand'), (14, 'New Zealand'),
(15, 'Pakistan'), (16, 'Pakistan'),
(17, 'South Africa'), (18, 'South Africa'),
(19, 'Sri Lanka'),
(20, 'Bangladesh');

-- Insert data into Match table
INSERT INTO `Match` (Match_id, Umpire, Result, Score1, Score2, Format, Date) VALUES
-- World Cup matches
(1, 'Richard Kettleborough', 'India won by 6 wickets', 240, 242, 'ODI', '2023-10-15'),
(2, 'Marais Erasmus', 'Australia won by 5 runs', 290, 285, 'ODI', '2023-10-20'),
(3, 'Kumar Dharmasena', 'England won by 8 wickets', 150, 151, 'T20', '2022-10-25'),
(4, 'Nitin Menon', 'New Zealand won by 4 wickets', 280, 281, 'ODI', '2023-10-28'),
(5, 'Chris Gaffaney', 'Pakistan won by 3 wickets', 160, 161, 'T20', '2022-11-02'),
-- Bilateral series matches
(6, 'Paul Reiffel', 'India won by 7 wickets', 310, 312, 'ODI', '2023-09-10'),
(7, 'Rod Tucker', 'Australia won by 2 wickets', 250, 251, 'ODI', '2023-09-12'),
(8, 'Michael Gough', 'Match drawn', 450, 320, 'Test', '2023-06-15'),
(9, 'Richard Illingworth', 'England won by 5 wickets', 180, 181, 'T20', '2023-07-22'),
(10, 'Ahsan Raza', 'South Africa won by 12 runs', 190, 178, 'T20', '2023-08-05');

-- Insert data into consists_of table (Tournament-Match relationship)
INSERT INTO consists_of (tournament_id, Match_id) VALUES
(1, 1), (1, 2), (1, 4),  -- World Cup matches
(2, 3), (2, 5),          -- T20 World Cup matches
(3, 6), (3, 7);          -- Asia Cup matches

-- Insert data into includes table (Series-Match relationship)
INSERT INTO includes (Series_id, Match_id) VALUES
(1, 6), (1, 7),  -- India vs Australia series
(2, 8),          -- England vs NZ test
(3, 9), (3, 10); -- Pakistan vs SA T20 series

-- Insert data into played_at table (Match-Venue relationship)
INSERT INTO played_at (Match_id, Venue_id) VALUES
(1, 5), (2, 2), (3, 3), (4, 1), (5, 6),
(6, 1), (7, 2), (8, 3), (9, 4), (10, 6);

-- Insert data into plays_in_match table
INSERT INTO plays_in_match (ID, Match_id) VALUES
-- Match 1 (India vs Australia)
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
(6, 1), (7, 1), (8, 1), (9, 1), (10, 1),
-- Match 2 (Australia vs England)
(6, 2), (7, 2), (8, 2), (9, 2), (10, 2),
(11, 2), (12, 2),
-- Match 3 (England vs New Zealand)
(11, 3), (12, 3), (13, 3), (14, 3),
-- Match 4 (India vs New Zealand)
(1, 4), (2, 4), (3, 4), (4, 4), (5, 4),
(13, 4), (14, 4),
-- Match 5 (Pakistan vs South Africa)
(15, 5), (16, 5), (17, 5), (18, 5),
-- Match 6 (India vs Australia)
(1, 6), (2, 6), (3, 6), (4, 6), (5, 6),
(6, 6), (7, 6), (8, 6), (9, 6), (10, 6),
-- Match 7 (Australia vs India)
(6, 7), (7, 7), (8, 7), (9, 7), (10, 7),
(1, 7), (2, 7), (3, 7), (4, 7), (5, 7),
-- Match 8 (England vs New Zealand)
(11, 8), (12, 8), (13, 8), (14, 8),
-- Match 9 (Pakistan vs South Africa)
(15, 9), (16, 9), (17, 9), (18, 9),
-- Match 10 (South Africa vs Pakistan)
(17, 10), (18, 10), (15, 10), (16, 10);

-- Insert data into Player_match_stats table
INSERT INTO Player_match_stats (player_id, Match_id, Balls_faced, Runs, Overs_bowled, Runs_given, Wickets, Catches, Stumpouts, Runouts) VALUES
-- Match 1 stats
(1, 1, 120, 85, NULL, NULL, NULL, 1, 0, 0),
(2, 1, 90, 65, NULL, NULL, NULL, 0, 0, 0),
(3, 1, 12, 15, 10, 45, 3, 0, 0, 0),
(6, 1, 10, 8, 10, 50, 1, 1, 0, 0),
(7, 1, 80, 72, NULL, NULL, NULL, 0, 0, 0),
-- Match 2 stats
(6, 2, 15, 20, 10, 55, 2, 0, 0, 0),
(7, 2, 110, 95, NULL, NULL, NULL, 1, 0, 0),
(8, 2, 90, 78, NULL, NULL, NULL, 0, 0, 0),
(11, 2, 100, 89, NULL, NULL, NULL, 0, 0, 0),
(12, 2, 8, 10, 9, 48, 2, 1, 0, 0),
-- Match 3 stats
(11, 3, 60, 75, NULL, NULL, NULL, 0, 0, 0),
(12, 3, 45, 52, 4, 25, 1, 0, 0, 0),
(13, 3, 50, 42, NULL, NULL, NULL, 1, 0, 0),
(14, 3, 5, 8, 4, 30, 2, 0, 0, 0),
-- Match 4 stats
(1, 4, 100, 78, NULL, NULL, NULL, 0, 0, 0),
(2, 4, 120, 112, NULL, NULL, NULL, 1, 0, 0),
(3, 4, 5, 10, 10, 48, 4, 0, 0, 0),
(13, 4, 110, 98, NULL, NULL, NULL, 0, 0, 0),
(14, 4, 8, 12, 10, 52, 1, 1, 0, 0),
-- Match 5 stats
(15, 5, 45, 68, NULL, NULL, NULL, 0, 0, 0),
(16, 5, 5, 12, 4, 28, 3, 1, 0, 0),
(17, 5, 40, 45, NULL, NULL, NULL, 0, 0, 0),
(18, 5, 35, 52, NULL, NULL, NULL, 1, 1, 0),
-- Match 6 stats
(1, 6, 110, 92, NULL, NULL, NULL, 0, 0, 0),
(2, 6, 120, 120, NULL, NULL, NULL, 1, 0, 0),
(3, 6, 8, 15, 10, 55, 2, 0, 0, 0),
(6, 6, 12, 18, 10, 60, 1, 1, 0, 0),
(7, 6, 100, 88, NULL, NULL, NULL, 0, 0, 0),
-- Match 7 stats
(6, 7, 15, 25, 10, 52, 3, 0, 0, 0),
(7, 7, 115, 105, NULL, NULL, NULL, 1, 0, 0),
(1, 7, 105, 85, NULL, NULL, NULL, 0, 0, 0),
(2, 7, 95, 78, NULL, NULL, NULL, 0, 0, 0),
(3, 7, 10, 15, 10, 48, 2, 1, 0, 0),
-- Match 8 stats
(11, 8, 180, 125, NULL, NULL, NULL, 0, 0, 0),
(12, 8, 160, 110, 15, 75, 2, 1, 0, 0),
(13, 8, 200, 145, NULL, NULL, NULL, 0, 0, 0),
(14, 8, 20, 25, 20, 95, 4, 0, 0, 0),
-- Match 9 stats
(15, 9, 40, 62, NULL, NULL, NULL, 0, 0, 0),
(16, 9, 6, 15, 4, 30, 2, 1, 0, 0),
(17, 9, 35, 48, NULL, NULL, NULL, 0, 0, 0),
(18, 9, 30, 45, NULL, NULL, NULL, 1, 1, 0),
-- Match 10 stats
(17, 10, 42, 65, NULL, NULL, NULL, 0, 0, 0),
(18, 10, 38, 58, NULL, NULL, NULL, 1, 1, 0),
(15, 10, 40, 45, NULL, NULL, NULL, 0, 0, 0),
(16, 10, 5, 10, 4, 32, 1, 0, 0, 0);

-- Virat Kohli's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(101, 'ODI', 12898, 57.32, 93.62, 275, 65, 46, 183),
(102, 'T20', 4008, 52.73, 137.96, 115, 37, 1, 122),
(103, 'Test', 8676, 49.29, 55.44, 111, 29, 29, 254);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(101, 'ODI', 275, 4, 5.45, '1/11'),
(102, 'T20', 115, 4, 6.12, '1/13');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(101, 'ODI', 275, 143, 0, 12),
(102, 'T20', 115, 50, 0, 8),
(103, 'Test', 111, 110, 0, 5);

-- Rohit Sharma's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(201, 'ODI', 10155, 48.91, 90.26, 248, 55, 31, 264),
(202, 'T20', 3853, 31.32, 139.24, 148, 29, 4, 118),
(203, 'Test', 3677, 45.39, 55.92, 52, 16, 10, 212);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(201, 'ODI', 248, 8, 5.60, '2/27'),
(202, 'T20', 148, 15, 7.25, '4/6');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(201, 'ODI', 248, 90, 0, 15),
(202, 'T20', 148, 58, 0, 10),
(203, 'Test', 52, 45, 0, 3);

-- Jasprit Bumrah's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(301, 'ODI', 72, 12.00, 85.71, 72, 0, 0, 28),
(302, 'T20', 60, 8.57, 95.24, 60, 0, 0, 16),
(303, 'Test', 128, 11.64, 50.00, 30, 0, 0, 34);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(301, 'ODI', 72, 121, 4.63, '6/19'),
(302, 'T20', 60, 74, 6.55, '3/11'),
(303, 'Test', 30, 128, 2.69, '6/27');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(301, 'ODI', 72, 18, 0, 2),
(302, 'T20', 60, 12, 0, 1),
(303, 'Test', 30, 10, 0, 1);

-- Hardik Pandya's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(401, 'ODI', 1750, 33.65, 115.00, 78, 9, 0, 92),
(402, 'T20', 1348, 25.43, 142.00, 92, 3, 0, 71),
(403, 'Test', 532, 31.29, 73.00, 11, 4, 0, 108);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(401, 'ODI', 78, 72, 5.60, '3/31'),
(402, 'T20', 92, 54, 8.10, '3/17'),
(403, 'Test', 11, 17, 3.45, '5/28');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(401, 'ODI', 78, 32, 0, 5),
(402, 'T20', 92, 28, 0, 4),
(403, 'Test', 11, 8, 0, 1);

-- Ravindra Jadeja's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(501, 'ODI', 2567, 32.49, 85.00, 171, 13, 0, 87),
(502, 'T20', 457, 21.76, 122.00, 64, 0, 0, 46),
(503, 'Test', 2804, 36.42, 59.00, 65, 18, 3, 175);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(501, 'ODI', 171, 191, 4.90, '5/36'),
(502, 'T20', 64, 51, 7.10, '3/15'),
(503, 'Test', 65, 267, 2.40, '7/42');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(501, 'ODI', 171, 72, 0, 12),
(502, 'T20', 64, 28, 0, 5),
(503, 'Test', 65, 56, 0, 8);

-- Pat Cummins' stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(601, 'ODI', 420, 15.56, 85.00, 88, 0, 0, 36),
(602, 'T20', 98, 9.80, 110.00, 50, 0, 0, 22),
(603, 'Test', 1250, 16.45, 52.00, 55, 3, 0, 63);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(601, 'ODI', 88, 141, 5.10, '5/70'),
(602, 'T20', 50, 55, 7.25, '3/15'),
(603, 'Test', 55, 217, 3.25, '6/23');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(601, 'ODI', 88, 25, 0, 3),
(602, 'T20', 50, 12, 0, 2),
(603, 'Test', 55, 18, 0, 2);

-- Steve Smith's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(701, 'ODI', 6500, 45.45, 88.12, 150, 35, 12, 164),
(702, 'T20', 1005, 25.12, 125.00, 63, 4, 0, 90),
(703, 'Test', 8124, 58.62, 53.00, 94, 33, 28, 239);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(701, 'ODI', 150, 28, 5.20, '3/16'),
(702, 'T20', 63, 17, 7.50, '2/18');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(701, 'ODI', 150, 85, 0, 10),
(702, 'T20', 63, 32, 0, 4),
(703, 'Test', 94, 95, 0, 8);

-- David Warner's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(801, 'ODI', 6030, 45.00, 96.00, 142, 27, 18, 179),
(802, 'T20', 2895, 32.16, 142.53, 100, 22, 0, 100),
(803, 'Test', 8158, 45.60, 70.00, 103, 34, 25, 335);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(801, 'ODI', 142, 0, 7.50, '0/11'),
(802, 'T20', 100, 4, 8.20, '1/12');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(801, 'ODI', 142, 65, 0, 8),
(802, 'T20', 100, 42, 0, 5),
(803, 'Test', 103, 85, 0, 6);

-- Glenn Maxwell's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(901, 'ODI', 3500, 34.31, 125.00, 128, 22, 2, 108),
(902, 'T20', 2150, 28.67, 155.00, 98, 10, 0, 145),
(903, 'Test', 1845, 26.35, 60.00, 7, 8, 1, 104);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(901, 'ODI', 128, 55, 5.75, '4/40'),
(902, 'T20', 98, 36, 7.80, '3/10');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(901, 'ODI', 128, 72, 0, 9),
(902, 'T20', 98, 48, 0, 6),
(903, 'Test', 7, 5, 0, 1);

-- Mitchell Starc's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(1001, 'ODI', 520, 12.38, 80.00, 110, 0, 0, 52),
(1002, 'T20', 95, 7.92, 105.00, 58, 0, 0, 24),
(1003, 'Test', 1250, 15.43, 55.00, 77, 3, 0, 99);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(1001, 'ODI', 110, 185, 5.30, '6/28'),
(1002, 'T20', 58, 73, 7.80, '4/20'),
(1003, 'Test', 77, 306, 3.20, '6/50');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(1001, 'ODI', 110, 32, 0, 4),
(1002, 'T20', 58, 15, 0, 2),
(1003, 'Test', 77, 22, 0, 3);

-- Jos Buttler's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(1101, 'ODI', 4823, 41.58, 118.00, 165, 25, 11, 162),
(1102, 'T20', 2895, 34.46, 144.00, 112, 19, 1, 101),
(1103, 'Test', 2900, 31.88, 55.00, 57, 18, 2, 152);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(1101, 'ODI', 165, 0, 8.00, '0/12');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(1101, 'ODI', 165, 185, 15, 12),
(1102, 'T20', 112, 78, 20, 8),
(1103, 'Test', 57, 123, 25, 5);

-- Ben Stokes' stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(1201, 'ODI', 2924, 39.51, 95.00, 108, 21, 3, 102),
(1202, 'T20', 585, 19.50, 135.00, 43, 2, 0, 47),
(1203, 'Test', 5230, 35.95, 57.00, 93, 28, 12, 258);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(1201, 'ODI', 108, 74, 6.00, '5/61'),
(1202, 'T20', 43, 19, 8.50, '3/15'),
(1203, 'Test', 93, 197, 3.40, '6/22');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(1201, 'ODI', 108, 62, 0, 7),
(1202, 'T20', 43, 25, 0, 3),
(1203, 'Test', 93, 95, 0, 9);

-- Kane Williamson's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(1301, 'ODI', 6554, 47.83, 81.00, 161, 42, 13, 148),
(1302, 'T20', 2465, 33.76, 123.00, 87, 17, 0, 95),
(1303, 'Test', 8124, 54.52, 52.78, 94, 33, 28, 251);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(1301, 'ODI', 161, 36, 5.20, '4/22');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(1301, 'ODI', 161, 75, 0, 8),
(1302, 'T20', 87, 42, 0, 5),
(1303, 'Test', 94, 95, 0, 8);

-- Trent Boult's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(1401, 'ODI', 320, 10.67, 85.00, 95, 0, 0, 21),
(1402, 'T20', 85, 6.54, 110.00, 55, 0, 0, 14),
(1403, 'Test', 425, 12.14, 50.00, 78, 0, 0, 52);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(1401, 'ODI', 95, 187, 5.10, '7/34'),
(1402, 'T20', 55, 62, 7.80, '4/13'),
(1403, 'Test', 78, 317, 2.90, '6/30');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(1401, 'ODI', 95, 28, 0, 3),
(1402, 'T20', 55, 15, 0, 2),
(1403, 'Test', 78, 22, 0, 3);

-- Babar Azam's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(1501, 'ODI', 4200, 56.76, 89.00, 92, 19, 14, 158),
(1502, 'T20', 3485, 41.48, 128.00, 104, 30, 3, 122),
(1503, 'Test', 3695, 47.37, 55.00, 47, 16, 9, 196);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(1501, 'ODI', 92, 0, 6.50, '0/12');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(1501, 'ODI', 92, 42, 0, 5),
(1502, 'T20', 104, 38, 0, 4),
(1503, 'Test', 47, 35, 0, 3);

-- Shadab Khan's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(1601, 'ODI', 812, 24.60, 95.00, 72, 2, 0, 86),
(1602, 'T20', 485, 18.65, 135.00, 80, 0, 0, 52),
(1603, 'Test', 325, 18.06, 60.00, 6, 1, 0, 56);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(1601, 'ODI', 72, 92, 5.20, '4/28'),
(1602, 'T20', 80, 95, 7.15, '4/13'),
(1603, 'Test', 6, 14, 3.80, '3/42');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(1601, 'ODI', 72, 32, 0, 4),
(1602, 'T20', 80, 28, 0, 5),
(1603, 'Test', 6, 5, 0, 1);

-- Temba Bavuma's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(1701, 'ODI', 1528, 34.73, 85.00, 55, 8, 1, 113),
(1702, 'T20', 785, 28.04, 120.00, 35, 4, 0, 72),
(1703, 'Test', 2175, 34.52, 50.00, 54, 12, 3, 172);

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(1701, 'ODI', 55, 28, 0, 3),
(1702, 'T20', 35, 15, 0, 2),
(1703, 'Test', 54, 42, 0, 4);

-- Quinton de Kock's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(1801, 'ODI', 5965, 44.86, 95.00, 140, 29, 17, 178),
(1802, 'T20', 2275, 32.50, 135.00, 80, 14, 0, 79),
(1803, 'Test', 3300, 38.37, 70.00, 54, 22, 6, 141);

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(1801, 'ODI', 140, 183, 12, 15),
(1802, 'T20', 80, 58, 5, 8),
(1803, 'Test', 54, 205, 8, 12);

-- Dasun Shanaka's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(1901, 'ODI', 1256, 24.63, 95.00, 78, 5, 0, 87),
(1902, 'T20', 845, 22.84, 125.00, 55, 3, 0, 74),
(1903, 'Test', 325, 18.06, 55.00, 12, 1, 0, 65);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(1901, 'ODI', 78, 42, 5.80, '3/28'),
(1902, 'T20', 55, 25, 8.20, '2/15');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(1901, 'ODI', 78, 32, 0, 4),
(1902, 'T20', 55, 18, 0, 3),
(1903, 'Test', 12, 8, 0, 1);

-- Shakib Al Hasan's stats
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
(2001, 'ODI', 7211, 37.67, 82.00, 235, 53, 9, 134),
(2002, 'T20', 2145, 23.57, 122.00, 117, 12, 0, 84),
(2003, 'Test', 4454, 39.42, 60.00, 66, 31, 5, 217);

INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
(2001, 'ODI', 235, 305, 4.45, '5/29'),
(2002, 'T20', 117, 128, 6.80, '5/20'),
(2003, 'Test', 66, 237, 2.90, '7/36');

INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
(2001, 'ODI', 235, 95, 0, 12),
(2002, 'T20', 117, 48, 0, 7),
(2003, 'Test', 66, 52, 0, 5);

-- Now link all stats to players through the relationship tables
-- Virat Kohli
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (2, 101), (2, 102), (2, 103);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (2, 101), (2, 102);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (2, 101), (2, 102), (2, 103);

-- Rohit Sharma
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (1, 201), (1, 202), (1, 203);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (1, 201), (1, 202);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (1, 201), (1, 202), (1, 203);

-- Jasprit Bumrah
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (3, 301), (3, 302), (3, 303);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (3, 301), (3, 302), (3, 303);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (3, 301), (3, 302), (3, 303);

-- Hardik Pandya
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (4, 401), (4, 402), (4, 403);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (4, 401), (4, 402), (4, 403);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (4, 401), (4, 402), (4, 403);

-- Ravindra Jadeja
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (5, 501), (5, 502), (5, 503);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (5, 501), (5, 502), (5, 503);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (5, 501), (5, 502), (5, 503);

-- Pat Cummins
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (6, 601), (6, 602), (6, 603);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (6, 601), (6, 602), (6, 603);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (6, 601), (6, 602), (6, 603);

-- Steve Smith
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (7, 701), (7, 702), (7, 703);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (7, 701), (7, 702);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (7, 701), (7, 702), (7, 703);

-- David Warner
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (8, 801), (8, 802), (8, 803);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (8, 801), (8, 802);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (8, 801), (8, 802), (8, 803);

-- Glenn Maxwell
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (9, 901), (9, 902), (9, 903);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (9, 901), (9, 902);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (9, 901), (9, 902), (9, 903);

-- Mitchell Starc
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (10, 1001), (10, 1002), (10, 1003);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (10, 1001), (10, 1002), (10, 1003);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (10, 1001), (10, 1002), (10, 1003);

-- Jos Buttler
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (11, 1101), (11, 1102), (11, 1103);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (11, 1101);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (11, 1101), (11, 1102), (11, 1103);

-- Ben Stokes
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (12, 1201), (12, 1202), (12, 1203);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (12, 1201), (12, 1202), (12, 1203);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (12, 1201), (12, 1202), (12, 1203);

-- Kane Williamson
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (13, 1301), (13, 1302), (13, 1303);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (13, 1301);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (13, 1301), (13, 1302), (13, 1303);

-- Trent Boult
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (14, 1401), (14, 1402), (14, 1403);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (14, 1401), (14, 1402), (14, 1403);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (14, 1401), (14, 1402), (14, 1403);

-- Babar Azam
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (15, 1501), (15, 1502), (15, 1503);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (15, 1501);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (15, 1501), (15, 1502), (15, 1503);

-- Shadab Khan
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (16, 1601), (16, 1602), (16, 1603);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (16, 1601), (16, 1602), (16, 1603);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (16, 1601), (16, 1602), (16, 1603);

-- Temba Bavuma
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (17, 1701), (17, 1702), (17, 1703);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (17, 1701), (17, 1702), (17, 1703);

-- Quinton de Kock
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (18, 1801), (18, 1802), (18, 1803);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (18, 1801), (18, 1802), (18, 1803);

-- Dasun Shanaka
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (19, 1901), (19, 1902), (19, 1903);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (19, 1901), (19, 1902);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (19, 1901), (19, 1902), (19, 1903);

-- Shakib Al Hasan
INSERT INTO has_batting_stats (ID, Batting_id) VALUES (20, 2001), (20, 2002), (20, 2003);
INSERT INTO has_bowling_stats (ID, Bowling_id) VALUES (20, 2001), (20, 2002), (20, 2003);
INSERT INTO has_fielding_stats (ID, Fielding_id) VALUES (20, 2001), (20, 2002), (20, 2003);

INSERT INTO competes_in (Team_Name, tournament_id) VALUES
-- ICC Cricket World Cup 2023 (tournament_id=1)
('India', 1),
('Australia', 1),
('England', 1),
('New Zealand', 1),
('South Africa', 1),
('Pakistan', 1),
('Sri Lanka', 1),
('Bangladesh', 1),

-- ICC T20 World Cup 2022 (tournament_id=2)
('India', 2),
('Australia', 2),
('England', 2),
('New Zealand', 2),
('Pakistan', 2),
('South Africa', 2),

-- Asia Cup 2023 (tournament_id=3)
('India', 3),
('Pakistan', 3),
('Sri Lanka', 3),
('Bangladesh', 3);

-- Populate plays_in_tournament table (Player-Tournament participation)
-- Based on the tournament-specific stats we've added
INSERT INTO plays_in_tournament (ID, player_id, tournament_id) VALUES
-- ICC Cricket World Cup 2023 (tournament_id=1)
(1, 1, 1),  -- Rohit Sharma
(2, 2, 1),  -- Virat Kohli
(3, 3, 1),  -- Jasprit Bumrah
(4, 4, 1),  -- Hardik Pandya
(5, 5, 1),  -- Ravindra Jadeja
(6, 6, 1),  -- Pat Cummins
(7, 7, 1),  -- Steve Smith
(8, 8, 1),  -- David Warner
(9, 9, 1),  -- Glenn Maxwell
(10, 10, 1), -- Mitchell Starc
(11, 11, 1), -- Jos Buttler
(12, 12, 1), -- Ben Stokes
(13, 13, 1), -- Kane Williamson
(14, 14, 1), -- Trent Boult
(15, 15, 1), -- Babar Azam
(16, 16, 1), -- Shadab Khan
(17, 17, 1), -- Temba Bavuma
(18, 18, 1), -- Quinton de Kock
(19, 19, 1), -- Dasun Shanaka
(20, 20, 1), -- Shakib Al Hasan

-- ICC T20 World Cup 2022 (tournament_id=2)
(1, 1, 2),  -- Rohit Sharma
(2, 2, 2),  -- Virat Kohli
(3, 3, 2),  -- Jasprit Bumrah
(4, 4, 2),  -- Hardik Pandya
(5, 5, 2),  -- Ravindra Jadeja
(6, 6, 2),  -- Pat Cummins
(8, 8, 2),  -- David Warner
(9, 9, 2),  -- Glenn Maxwell
(11, 11, 2), -- Jos Buttler
(12, 12, 2), -- Ben Stokes
(13, 13, 2), -- Kane Williamson
(14, 14, 2), -- Trent Boult
(15, 15, 2), -- Babar Azam
(16, 16, 2), -- Shadab Khan
(17, 17, 2), -- Temba Bavuma
(18, 18, 2), -- Quinton de Kock
(19, 19, 2), -- Dasun Shanaka
(20, 20, 2), -- Shakib Al Hasan

-- Asia Cup 2023 (tournament_id=3)
(1, 1, 3),  -- Rohit Sharma
(2, 2, 3),  -- Virat Kohli
(3, 3, 3),  -- Jasprit Bumrah
(4, 4, 3),  -- Hardik Pandya
(5, 5, 3),  -- Ravindra Jadeja
(15, 15, 3), -- Babar Azam
(16, 16, 3), -- Shadab Khan
(19, 19, 3), -- Dasun Shanaka
(20, 20, 3); -- Shakib Al Hasan

INSERT INTO Player_tournament_stats(player_id, tournament_id) VALUES
-- ICC Cricket World Cup 2023 (tournament_id=1)
(1, 1),  -- Rohit Sharma
(2, 1),  -- Virat Kohli
(3, 1),  -- Jasprit Bumrah
(4, 1),  -- Hardik Pandya
(5, 1),  -- Ravindra Jadeja
(6, 1),  -- Pat Cummins
(7, 1),  -- Steve Smith
(8, 1),  -- David Warner
(9, 1),  -- Glenn Maxwell
(10, 1), -- Mitchell Starc
(11, 1), -- Jos Buttler
(12, 1), -- Ben Stokes
(13, 1), -- Kane Williamson
(14, 1), -- Trent Boult
(15, 1), -- Babar Azam
(16, 1), -- Shadab Khan
(17, 1), -- Temba Bavuma
(18, 1), -- Quinton de Kock
(19, 1), -- Dasun Shanaka
(20, 1), -- Shakib Al Hasan

-- ICC T20 World Cup 2022 (tournament_id=2)
(1, 2),  -- Rohit Sharma
(2, 2),  -- Virat Kohli
(3, 2),  -- Jasprit Bumrah
(4, 2),  -- Hardik Pandya
(5, 2),  -- Ravindra Jadeja
(6, 2),  -- Pat Cummins
(8, 2),  -- David Warner
(9, 2),  -- Glenn Maxwell
(11, 2), -- Jos Buttler
(12, 2), -- Ben Stokes
(13, 2), -- Kane Williamson
(14, 2), -- Trent Boult
(15, 2), -- Babar Azam
(16, 2), -- Shadab Khan
(17, 2), -- Temba Bavuma
(18, 2), -- Quinton de Kock
(19, 2), -- Dasun Shanaka
(20, 2), -- Shakib Al Hasan

-- Asia Cup 2023 (tournament_id=3)
(1, 3),  -- Rohit Sharma
(2, 3),  -- Virat Kohli
(3, 3),  -- Jasprit Bumrah
(4, 3),  -- Hardik Pandya
(5, 3),  -- Ravindra Jadeja
(15, 3), -- Babar Azam
(16, 3), -- Shadab Khan
(19, 3), -- Dasun Shanaka
(20, 3); -- Shakib Al Hasan

-- Create tournament-specific batting stats and link them to players
INSERT INTO Batting_stats (Batting_id, Format, Runs, Average, Strike_rate, Matches, Fifties, Hundreds, Highest_score) VALUES
-- ICC Cricket World Cup 2023 stats (tournament_id=1)
(10001, 'ODI', 765, 63.75, 98.32, 11, 6, 3, 152),  -- Virat Kohli in WC 2023
(10002, 'ODI', 597, 54.27, 92.45, 11, 3, 1, 131),  -- Rohit Sharma in WC 2023
(10003, 'ODI', 302, 27.45, 85.21, 11, 1, 0, 78),   -- Jasprit Bumrah in WC 2023
(10004, 'ODI', 420, 38.18, 112.34, 11, 2, 0, 89),  -- Hardik Pandya in WC 2023
(10005, 'ODI', 480, 48.00, 95.23, 11, 3, 0, 87),   -- Ravindra Jadeja in WC 2023
(10006, 'ODI', 350, 35.00, 88.76, 10, 2, 0, 72),   -- Pat Cummins in WC 2023
(10007, 'ODI', 402, 40.20, 86.45, 10, 3, 0, 94),   -- Steve Smith in WC 2023
(10008, 'ODI', 535, 53.50, 105.32, 10, 4, 2, 163), -- David Warner in WC 2023
(10009, 'ODI', 398, 39.80, 132.45, 10, 2, 1, 106), -- Glenn Maxwell in WC 2023
(10010, 'ODI', 285, 28.50, 85.67, 10, 1, 0, 68),   -- Mitchell Starc in WC 2023
(10011, 'ODI', 412, 41.20, 118.45, 10, 3, 0, 101), -- Jos Buttler in WC 2023
(10012, 'ODI', 375, 37.50, 92.34, 9, 2, 0, 89),    -- Ben Stokes in WC 2023
(10013, 'ODI', 465, 51.67, 82.45, 9, 3, 1, 134),   -- Kane Williamson in WC 2023
(10014, 'ODI', 320, 32.00, 85.23, 10, 1, 0, 76),   -- Trent Boult in WC 2023
(10015, 'ODI', 485, 53.89, 88.76, 9, 4, 1, 122),   -- Babar Azam in WC 2023
(10016, 'ODI', 210, 21.00, 95.45, 10, 0, 0, 45),   -- Shadab Khan in WC 2023
(10017, 'ODI', 356, 39.56, 82.34, 9, 2, 0, 93),    -- Temba Bavuma in WC 2023
(10018, 'ODI', 412, 45.78, 108.76, 9, 3, 1, 124),  -- Quinton de Kock in WC 2023
(10019, 'ODI', 287, 31.89, 92.45, 9, 1, 0, 78),     -- Dasun Shanaka in WC 2023
(10020, 'ODI', 365, 40.56, 85.67, 9, 2, 0, 93),    -- Shakib Al Hasan in WC 2023

-- ICC T20 World Cup 2022 stats (tournament_id=2)
(20001, 'T20', 296, 59.20, 136.45, 6, 4, 0, 82),   -- Virat Kohli in T20 WC 2022
(20002, 'T20', 174, 29.00, 142.34, 6, 1, 0, 53),   -- Rohit Sharma in T20 WC 2022
(20003, 'T20', 45, 9.00, 95.23, 6, 0, 0, 12),      -- Jasprit Bumrah in T20 WC 2022
(20004, 'T20', 128, 25.60, 145.67, 6, 0, 0, 48),   -- Hardik Pandya in T20 WC 2022
(20005, 'T20', 85, 17.00, 125.45, 6, 0, 0, 35),    -- Ravindra Jadeja in T20 WC 2022
(20006, 'T20', 65, 13.00, 110.23, 6, 0, 0, 22),    -- Pat Cummins in T20 WC 2022
(20007, 'T20', 98, 19.60, 128.76, 6, 0, 0, 45),    -- Glenn Maxwell in T20 WC 2022
(20008, 'T20', 213, 42.60, 142.34, 6, 2, 0, 75),   -- David Warner in T20 WC 2022
(20009, 'T20', 187, 37.40, 158.45, 6, 1, 0, 68),    -- Jos Buttler in T20 WC 2022
(20010, 'T20', 156, 31.20, 132.45, 6, 1, 0, 52),   -- Ben Stokes in T20 WC 2022
(20011, 'T20', 245, 49.00, 125.67, 6, 3, 0, 73),   -- Kane Williamson in T20 WC 2022
(20012, 'T20', 45, 9.00, 85.23, 6, 0, 0, 14),      -- Trent Boult in T20 WC 2022
(20013, 'T20', 285, 57.00, 132.45, 6, 3, 0, 82),   -- Babar Azam in T20 WC 2022
(20014, 'T20', 120, 24.00, 145.67, 6, 0, 0, 45),   -- Shadab Khan in T20 WC 2022
(20015, 'T20', 178, 35.60, 128.76, 6, 1, 0, 62),   -- Temba Bavuma in T20 WC 2022
(20016, 'T20', 212, 42.40, 148.45, 6, 2, 0, 68),   -- Quinton de Kock in T20 WC 2022
(20017, 'T20', 145, 29.00, 132.34, 6, 1, 0, 53),   -- Dasun Shanaka in T20 WC 2022
(20018, 'T20', 187, 37.40, 125.67, 6, 1, 0, 58),   -- Shakib Al Hasan in T20 WC 2022

-- Asia Cup 2023 stats (tournament_id=3)
(30001, 'ODI', 345, 57.50, 92.34, 6, 3, 1, 122),   -- Virat Kohli in Asia Cup 2023
(30002, 'ODI', 287, 47.83, 102.45, 6, 2, 1, 112),  -- Rohit Sharma in Asia Cup 2023
(30003, 'ODI', 45, 9.00, 85.67, 6, 0, 0, 15),      -- Jasprit Bumrah in Asia Cup 2023
(30004, 'ODI', 187, 31.16, 118.76, 6, 1, 0, 68),   -- Hardik Pandya in Asia Cup 2023
(30005, 'ODI', 156, 26.00, 92.34, 6, 1, 0, 52),    -- Ravindra Jadeja in Asia Cup 2023
(30006, 'ODI', 265, 44.16, 92.45, 6, 2, 0, 87),    -- Babar Azam in Asia Cup 2023
(30007, 'ODI', 120, 20.00, 135.67, 6, 0, 0, 45),   -- Shadab Khan in Asia Cup 2023
(30008, 'ODI', 198, 33.00, 82.34, 6, 1, 0, 76),    -- Dasun Shanaka in Asia Cup 2023
(30009, 'ODI', 245, 40.83, 88.76, 6, 2, 0, 93),    -- Shakib Al Hasan in Asia Cup 2023
(30010, 'ODI', 178, 29.67, 95.23, 6, 1, 0, 65);    -- Ravindra Jadeja in Asia Cup 2023 (duplicate for testing)

-- Create tournament-specific bowling stats and link them to players
INSERT INTO Bowling_stats (Bowling_id, Format, Matches, Wickets, Economy_rate, Best_figures) VALUES
-- ICC Cricket World Cup 2023 bowling stats (tournament_id=1)
(10001, 'ODI', 11, 15, 4.56, '3/28'),   -- Jasprit Bumrah in WC 2023
(10002, 'ODI', 11, 12, 5.23, '3/35'),   -- Hardik Pandya in WC 2023
(10003, 'ODI', 11, 16, 4.12, '5/42'),   -- Ravindra Jadeja in WC 2023
(10004, 'ODI', 10, 18, 5.34, '4/39'),   -- Pat Cummins in WC 2023
(10005, 'ODI', 10, 12, 5.67, '3/40'),   -- Glenn Maxwell in WC 2023
(10006, 'ODI', 10, 22, 4.89, '6/28'),   -- Mitchell Starc in WC 2023
(10007, 'ODI', 10, 14, 5.12, '3/35'),   -- Ben Stokes in WC 2023
(10008, 'ODI', 10, 15, 4.78, '4/27'),   -- Trent Boult in WC 2023
(10009, 'ODI', 9, 10, 5.45, '3/32'),    -- Shadab Khan in WC 2023
(10010, 'ODI', 9, 12, 4.56, '3/28'),    -- Shakib Al Hasan in WC 2023

-- ICC T20 World Cup 2022 bowling stats (tournament_id=2)
(20001, 'T20', 6, 8, 6.78, '3/11'),     -- Jasprit Bumrah in T20 WC 2022
(20002, 'T20', 6, 7, 7.45, '2/15'),     -- Hardik Pandya in T20 WC 2022
(20003, 'T20', 6, 9, 6.23, '3/20'),     -- Ravindra Jadeja in T20 WC 2022
(20004, 'T20', 6, 10, 7.12, '3/18'),    -- Pat Cummins in T20 WC 2022
(20005, 'T20', 6, 8, 7.89, '2/22'),     -- Glenn Maxwell in T20 WC 2022
(20006, 'T20', 6, 12, 7.45, '4/20'),    -- Mitchell Starc in T20 WC 2022
(20007, 'T20', 6, 6, 8.12, '2/25'),     -- Ben Stokes in T20 WC 2022
(20008, 'T20', 6, 9, 7.34, '3/15'),     -- Trent Boult in T20 WC 2022
(20009, 'T20', 6, 11, 6.78, '4/13'),    -- Shadab Khan in T20 WC 2022
(20010, 'T20', 6, 8, 6.45, '3/18'),     -- Shakib Al Hasan in T20 WC 2022

-- Asia Cup 2023 bowling stats (tournament_id=3)
(30001, 'ODI', 6, 9, 4.78, '3/28'),     -- Jasprit Bumrah in Asia Cup 2023
(30002, 'ODI', 6, 7, 5.45, '2/25'),     -- Hardik Pandya in Asia Cup 2023
(30003, 'ODI', 6, 8, 4.23, '3/20'),     -- Ravindra Jadeja in Asia Cup 2023
(30004, 'ODI', 6, 10, 5.12, '3/18'),    -- Shadab Khan in Asia Cup 2023
(30005, 'ODI', 6, 9, 4.89, '3/22');     -- Shakib Al Hasan in Asia Cup 2023

-- Create tournament-specific fielding stats and link them to players
INSERT INTO Fielding_stats (Fielding_id, Format, Matches, Catches, Stumpings, Runouts) VALUES
-- ICC Cricket World Cup 2023 fielding stats (tournament_id=1)
(10001, 'ODI', 11, 8, 0, 1),    -- Virat Kohli in WC 2023
(10002, 'ODI', 11, 6, 0, 2),     -- Rohit Sharma in WC 2023
(10003, 'ODI', 11, 3, 0, 0),     -- Jasprit Bumrah in WC 2023
(10004, 'ODI', 11, 5, 0, 1),     -- Hardik Pandya in WC 2023
(10005, 'ODI', 11, 7, 0, 2),     -- Ravindra Jadeja in WC 2023
(10006, 'ODI', 10, 4, 0, 0),     -- Pat Cummins in WC 2023
(10007, 'ODI', 10, 5, 0, 1),     -- Steve Smith in WC 2023
(10008, 'ODI', 10, 6, 0, 1),     -- David Warner in WC 2023
(10009, 'ODI', 10, 8, 0, 1),     -- Glenn Maxwell in WC 2023
(10010, 'ODI', 10, 3, 0, 0),     -- Mitchell Starc in WC 2023
(10011, 'ODI', 10, 12, 3, 2),    -- Jos Buttler in WC 2023
(10012, 'ODI', 9, 5, 0, 1),      -- Ben Stokes in WC 2023
(10013, 'ODI', 9, 6, 0, 1),      -- Kane Williamson in WC 2023
(10014, 'ODI', 10, 4, 0, 0),     -- Trent Boult in WC 2023
(10015, 'ODI', 9, 5, 0, 1),      -- Babar Azam in WC 2023
(10016, 'ODI', 10, 4, 0, 1),     -- Shadab Khan in WC 2023
(10017, 'ODI', 9, 3, 0, 0),      -- Temba Bavuma in WC 2023
(10018, 'ODI', 9, 15, 2, 1),     -- Quinton de Kock in WC 2023
(10019, 'ODI', 9, 4, 0, 1),      -- Dasun Shanaka in WC 2023
(10020, 'ODI', 9, 5, 0, 1),      -- Shakib Al Hasan in WC 2023

-- ICC T20 World Cup 2022 fielding stats (tournament_id=2)
(20001, 'T20', 6, 5, 0, 1),     -- Virat Kohli in T20 WC 2022
(20002, 'T20', 6, 4, 0, 1),      -- Rohit Sharma in T20 WC 2022
(20003, 'T20', 6, 2, 0, 0),      -- Jasprit Bumrah in T20 WC 2022
(20004, 'T20', 6, 3, 0, 1),      -- Hardik Pandya in T20 WC 2022
(20005, 'T20', 6, 4, 0, 1),      -- Ravindra Jadeja in T20 WC 2022
(20006, 'T20', 6, 2, 0, 0),      -- Pat Cummins in T20 WC 2022
(20007, 'T20', 6, 6, 1, 1),      -- Jos Buttler in T20 WC 2022
(20008, 'T20', 6, 3, 0, 0),      -- Ben Stokes in T20 WC 2022
(20009, 'T20', 6, 4, 0, 1),      -- Kane Williamson in T20 WC 2022
(20010, 'T20', 6, 2, 0, 0),      -- Trent Boult in T20 WC 2022
(20011, 'T20', 6, 3, 0, 1),      -- Babar Azam in T20 WC 2022
(20012, 'T20', 6, 4, 0, 1),      -- Shadab Khan in T20 WC 2022
(20013, 'T20', 6, 2, 0, 0),      -- Temba Bavuma in T20 WC 2022
(20014, 'T20', 6, 8, 2, 1),      -- Quinton de Kock in T20 WC 2022
(20015, 'T20', 6, 3, 0, 1),      -- Dasun Shanaka in T20 WC 2022
(20016, 'T20', 6, 4, 0, 1),      -- Shakib Al Hasan in T20 WC 2022

-- Asia Cup 2023 fielding stats (tournament_id=3)
(30001, 'ODI', 6, 4, 0, 1),      -- Virat Kohli in Asia Cup 2023
(30002, 'ODI', 6, 3, 0, 1),      -- Rohit Sharma in Asia Cup 2023
(30003, 'ODI', 6, 2, 0, 0),      -- Jasprit Bumrah in Asia Cup 2023
(30004, 'ODI', 6, 3, 0, 1),      -- Hardik Pandya in Asia Cup 2023
(30005, 'ODI', 6, 4, 0, 1),      -- Ravindra Jadeja in Asia Cup 2023
(30006, 'ODI', 6, 3, 0, 0),      -- Babar Azam in Asia Cup 2023
(30007, 'ODI', 6, 4, 0, 1),      -- Shadab Khan in Asia Cup 2023
(30008, 'ODI', 6, 2, 0, 0),      -- Dasun Shanaka in Asia Cup 2023
(30009, 'ODI', 6, 3, 0, 1);      -- Shakib Al Hasan in Asia Cup 2023

-- Link tournament-specific batting stats to players
INSERT INTO has_batting_stats_tournament (player_id, tournament_id, Batting_id) VALUES
-- ICC Cricket World Cup 2023 (tournament_id=1)
(2, 1, 10001),  -- Virat Kohli
(1, 1, 10002),  -- Rohit Sharma
(3, 1, 10003),  -- Jasprit Bumrah
(4, 1, 10004),  -- Hardik Pandya
(5, 1, 10005),  -- Ravindra Jadeja
(6, 1, 10006),  -- Pat Cummins
(7, 1, 10007),  -- Steve Smith
(8, 1, 10008),  -- David Warner
(9, 1, 10009),  -- Glenn Maxwell
(10, 1, 10010), -- Mitchell Starc
(11, 1, 10011), -- Jos Buttler
(12, 1, 10012), -- Ben Stokes
(13, 1, 10013), -- Kane Williamson
(14, 1, 10014), -- Trent Boult
(15, 1, 10015), -- Babar Azam
(16, 1, 10016), -- Shadab Khan
(17, 1, 10017), -- Temba Bavuma
(18, 1, 10018), -- Quinton de Kock
(19, 1, 10019), -- Dasun Shanaka
(20, 1, 10020), -- Shakib Al Hasan

-- ICC T20 World Cup 2022 (tournament_id=2)
(2, 2, 20001),  -- Virat Kohli
(1, 2, 20002),  -- Rohit Sharma
(3, 2, 20003),  -- Jasprit Bumrah
(4, 2, 20004),  -- Hardik Pandya
(5, 2, 20005),  -- Ravindra Jadeja
(6, 2, 20006),  -- Pat Cummins
(9, 2, 20007),  -- Glenn Maxwell
(8, 2, 20008),  -- David Warner
(11, 2, 20009), -- Jos Buttler
(12, 2, 20010), -- Ben Stokes
(13, 2, 20011), -- Kane Williamson
(14, 2, 20012), -- Trent Boult
(15, 2, 20013), -- Babar Azam
(16, 2, 20014), -- Shadab Khan
(17, 2, 20015), -- Temba Bavuma
(18, 2, 20016), -- Quinton de Kock
(19, 2, 20017), -- Dasun Shanaka
(20, 2, 20018), -- Shakib Al Hasan

-- Asia Cup 2023 (tournament_id=3)
(2, 3, 30001),  -- Virat Kohli
(1, 3, 30002),  -- Rohit Sharma
(3, 3, 30003),  -- Jasprit Bumrah
(4, 3, 30004),  -- Hardik Pandya
(5, 3, 30005),  -- Ravindra Jadeja
(15, 3, 30006), -- Babar Azam
(16, 3, 30007), -- Shadab Khan
(19, 3, 30008), -- Dasun Shanaka
(20, 3, 30009), -- Shakib Al Hasan
(5, 3, 30010);  -- Ravindra Jadeja (duplicate for testing)

-- Link tournament-specific bowling stats to players
INSERT INTO has_bowling_stats_tournament (player_id, tournament_id, Bowling_id) VALUES
-- ICC Cricket World Cup 2023 (tournament_id=1)
(3, 1, 10001),  -- Jasprit Bumrah
(4, 1, 10002),  -- Hardik Pandya
(5, 1, 10003),  -- Ravindra Jadeja
(6, 1, 10004),  -- Pat Cummins
(9, 1, 10005),  -- Glenn Maxwell
(10, 1, 10006), -- Mitchell Starc
(12, 1, 10007), -- Ben Stokes
(14, 1, 10008), -- Trent Boult
(16, 1, 10009), -- Shadab Khan
(20, 1, 10010), -- Shakib Al Hasan

-- ICC T20 World Cup 2022 (tournament_id=2)
(3, 2, 20001),  -- Jasprit Bumrah
(4, 2, 20002),  -- Hardik Pandya
(5, 2, 20003),  -- Ravindra Jadeja
(6, 2, 20004),  -- Pat Cummins
(9, 2, 20005),  -- Glenn Maxwell
(10, 2, 20006), -- Mitchell Starc
(12, 2, 20007), -- Ben Stokes
(14, 2, 20008), -- Trent Boult
(16, 2, 20009), -- Shadab Khan
(20, 2, 20010), -- Shakib Al Hasan

-- Asia Cup 2023 (tournament_id=3)
(3, 3, 30001),  -- Jasprit Bumrah
(4, 3, 30002),  -- Hardik Pandya
(5, 3, 30003),  -- Ravindra Jadeja
(16, 3, 30004), -- Shadab Khan
(20, 3, 30005); -- Shakib Al Hasan

-- Link tournament-specific fielding stats to players
INSERT INTO has_fielding_stats_tournament (player_id, tournament_id, Fielding_id) VALUES
-- ICC Cricket World Cup 2023 (tournament_id=1)
(2, 1, 10001),  -- Virat Kohli
(1, 1, 10002),  -- Rohit Sharma
(3, 1, 10003),  -- Jasprit Bumrah
(4, 1, 10004),  -- Hardik Pandya
(5, 1, 10005),  -- Ravindra Jadeja
(6, 1, 10006),  -- Pat Cummins
(7, 1, 10007),  -- Steve Smith
(8, 1, 10008),  -- David Warner
(9, 1, 10009),  -- Glenn Maxwell
(10, 1, 10010), -- Mitchell Starc
(11, 1, 10011), -- Jos Buttler
(12, 1, 10012), -- Ben Stokes
(13, 1, 10013), -- Kane Williamson
(14, 1, 10014), -- Trent Boult
(15, 1, 10015), -- Babar Azam
(16, 1, 10016), -- Shadab Khan
(17, 1, 10017), -- Temba Bavuma
(18, 1, 10018), -- Quinton de Kock
(19, 1, 10019), -- Dasun Shanaka
(20, 1, 10020), -- Shakib Al Hasan

-- ICC T20 World Cup 2022 (tournament_id=2)
(2, 2, 20001),  -- Virat Kohli
(1, 2, 20002),  -- Rohit Sharma
(3, 2, 20003),  -- Jasprit Bumrah
(4, 2, 20004),  -- Hardik Pandya
(5, 2, 20005),  -- Ravindra Jadeja
(6, 2, 20006),  -- Pat Cummins
(11, 2, 20007), -- Jos Buttler
(12, 2, 20008), -- Ben Stokes
(13, 2, 20009), -- Kane Williamson
(14, 2, 20010), -- Trent Boult
(15, 2, 20011), -- Babar Azam
(16, 2, 20012), -- Shadab Khan
(17, 2, 20013), -- Temba Bavuma
(18, 2, 20014), -- Quinton de Kock
(19, 2, 20015), -- Dasun Shanaka
(20, 2, 20016), -- Shakib Al Hasan

-- Asia Cup 2023 (tournament_id=3)
(2, 3, 30001),  -- Virat Kohli
(1, 3, 30002),  -- Rohit Sharma
(3, 3, 30003),  -- Jasprit Bumrah
(4, 3, 30004),  -- Hardik Pandya
(5, 3, 30005),  -- Ravindra Jadeja
(15, 3, 30006), -- Babar Azam
(16, 3, 30007), -- Shadab Khan
(19, 3, 30008), -- Dasun Shanaka
(20, 3, 30009); -- Shakib Al Hasan

-- Queries