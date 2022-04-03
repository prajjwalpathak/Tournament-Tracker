CREATE DATABASE Tournaments
GO

USE Tournaments;

CREATE TABLE dbo.Tournaments (
	id INT IDENTITY(1, 1) NOT NULL, 
	TournamentName NVARCHAR(200) NOT NULL, 
	EntryFee MONEY NOT NULL
		CONSTRAINT DF_Tournaments_EntryFee DEFAULT 0, 
	Active BIT NOT NULL

	CONSTRAINT PK_Tournaments PRIMARY KEY CLUSTERED (id ASC), 
);

CREATE TABLE dbo.Prizes (
	id INT IDENTITY(1, 1) NOT NULL, 
	PlaceNumber INT NOT NULL, 
	PlaceName NVARCHAR(50) NOT NULL, 
	PrizeAmount MONEY NOT NULL
		CONSTRAINT DF_Prizes_PrizeAmount DEFAULT 0, 
	PrizePercentage float
		CONSTRAINT DF_Prizes_PrizePercentage DEFAULT 0, 

	CONSTRAINT PK_Prizes PRIMARY KEY CLUSTERED (id ASC), 
);

CREATE TABLE dbo.TournamentPrizes (
	id INT IDENTITY(1, 1) NOT NULL, 
	TournamentId INT, 
	PrizeId INT, 

	CONSTRAINT PK_TournamentPrizes PRIMARY KEY CLUSTERED (id ASC), 
	CONSTRAINT FK_TP_Prizes FOREIGN KEY (PrizeId) REFERENCES Prizes(id), 
	CONSTRAINT FK_TP_Tournaments FOREIGN KEY (TournamentId) REFERENCES Tournaments(id)
);

CREATE TABLE dbo.Teams (
	id INT IDENTITY(1, 1) NOT NULL, 
	TeamName NVARCHAR(150) NOT NULL, 

	CONSTRAINT PK_Teams PRIMARY KEY CLUSTERED (id ASC)
);

CREATE TABLE dbo.TournamentEntries (
	id INT IDENTITY(1, 1) NOT NULL, 
	TournamentId INT, 
	TeamId INT, 

	CONSTRAINT PK_TournamentEntries PRIMARY KEY CLUSTERED (id ASC), 
	CONSTRAINT FK_TE_Teams FOREIGN KEY (TeamId) REFERENCES Teams(id), 
	CONSTRAINT FK_TE_Tournaments FOREIGN KEY (TournamentId) REFERENCES Tournaments(id)
);

CREATE TABLE dbo.People (
	id INT IDENTITY(1, 1) NOT NULL, 
	FirstName NVARCHAR(100) NOT NULL, 
	LastName NVARCHAR(100) NOT NULL, 
	EmailAddress NVARCHAR(200) NOT NULL, 
	PhoneNumber VARCHAR(20), 

	CONSTRAINT PK_People PRIMARY KEY CLUSTERED (id ASC)
);

CREATE TABLE dbo.TeamMembers (
	id INT IDENTITY(1, 1) NOT NULL, 
	TeamId INT, 
	PersonId INT, 

	CONSTRAINT PK_TeamMembers PRIMARY KEY CLUSTERED (id ASC), 
	CONSTRAINT FK_TeamMembers_People FOREIGN KEY (PersonId) REFERENCES People(id), 
	CONSTRAINT FK_TeamMembers_Team FOREIGN KEY (TeamId) REFERENCES Teams(id)
);

CREATE TABLE dbo.Matchups (
	id INT IDENTITY(1, 1) NOT NULL, 
	TournamentId INT NOT NULL, 
	WinnerId INT, 
	MatchupRound INT NOT NULL

	CONSTRAINT PK_Matchups PRIMARY KEY CLUSTERED (id ASC), 
	CONSTRAINT FK_Matchups_WinningTeam FOREIGN KEY (WinnerId) REFERENCES Teams(id)
);

CREATE TABLE dbo.MatchupEntries (
	id INT IDENTITY(1, 1) NOT NULL, 
	MatchupId INT, 
	ParentMatchupId INT NULL, 
	TeamCompetingId INT, 
	Score INT NOT NULL
		CONSTRAINT DF_ME_Score DEFAULT (0), 

	CONSTRAINT PK_MatchupEntries PRIMARY KEY CLUSTERED (id ASC), 
	CONSTRAINT FK_ME_Matchup FOREIGN KEY (MatchupId) REFERENCES Matchups(id), 
	CONSTRAINT FK_ME_TeamCompeting FOREIGN KEY (TeamCompetingId) REFERENCES Teams(id), 
);