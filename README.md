# 🏏 Cricket Analytics Database  

## 📌 Overview  
This project implements a **relational database schema for cricket analytics**, designed to capture tournaments, bilateral series, matches, teams, players, venues, and detailed player statistics across batting, bowling, and fielding.  
It enables structured storage and querying of cricket data for analytics such as **player performance, match outcomes, and tournament trends**.  

---

## 📂 Schema Design  

The schema consists of multiple entities with relationships capturing real-world cricket structure:  

### 🔹 Core Entities  
- **Tournament** – Stores tournament details (e.g., World Cup, Champions Trophy).  
- **Bilateral_series** – Captures details of bilateral cricket series.  
- **Match** – Stores match information (umpire, result, scores, format, date).  
- **Venue** – Venue details with average batting stats per format.  
- **Team** – Teams with captain and vice-captain.  
- **Player** – Player information (age, DOB, styles, nationality, jersey no.).  

### 🔹 Relationships  
- `includes` – Connects series with matches.  
- `consists_of` – Connects tournaments with matches.  
- `played_at` – Links matches to venues.  
- `competes_in` – Teams participating in tournaments.  
- `plays_for` – Players playing for teams.  
- `plays_in_match` – Players appearing in matches.  
- `plays_in_tournament` – Players participating in tournaments.  

### 🔹 Match-Level Stats  
- **Player_match_stats** – Stores per-match player stats (runs, wickets, catches, etc.).  

### 🔹 Tournament-Level Stats  
- **Player_tournament_stats** – Player performance aggregated at tournament level.  
- `has_batting_stats_tournament`, `has_bowling_stats_tournament`, `has_fielding_stats_tournament` – Links players with format-specific tournament stats.  

### 🔹 Career Stats  
- **Batting_stats** – Stores career batting metrics (runs, average, strike rate, fifties, hundreds).  
- **Bowling_stats** – Career bowling metrics (matches, wickets, economy, best figures).  
- **Fielding_stats** – Career fielding metrics (catches, stumpings, runouts).  
- `has_batting_stats`, `has_bowling_stats`, `has_fielding_stats` – Links players with their career stats.  

---

## 🗝️ Keys and Constraints  
- **Primary Keys**: Each table has a unique identifier (`Match_id`, `Player_id`, `Batting_id`, etc.).  
- **Foreign Keys**: Ensure referential integrity (e.g., a match must exist before adding stats).  
- **Composite Keys**: Used in relationship tables (e.g., `(player_id, Match_id)` in `Player_match_stats`).  

---

## ⚡ Features Supported  
- Track matches within tournaments and series.  
- Capture player participation across teams, matches, and tournaments.  
- Maintain granular player performance data (match-wise + tournament-wise + career).  
- Query player stats across formats (ODI, T20, Test).  
- Analyze tournament-level outcomes and trends.  

---

## 📊 Example Use Cases  
- Get all matches of a given tournament or series.  
- Find top scorers/wicket-takers in a tournament.  
- Compare player stats across formats (ODI vs T20 vs Test).  
- Retrieve team composition for a tournament.  
- Analyze venue-based performance trends.  

---

## 🛠️ Tech Stack  
- **Database**: MySQL / MariaDB  
- **Schema**: SQL DDL (Data Definition Language)  
