Create Database Tournaments
Go

Use Tournaments;

Create table dbo.Tournaments (
	id int Identity(1,1) NOT NULL,
	TournamentName nvarchar(200) NOT NULL,
	EntryFee money NOT NULL
		Constraint DF_Tournaments_EntryFee Default 0,

	Constraint PK_Tournaments Primary Key Clustered (id asc),
);

Create table dbo.Prizes (
	id int Identity(1,1) NOT NULL,
	PlaceNumber int NOT NULL,
	PlaceName nvarchar(50) NOT NULL,
	PrizeAmount money NOT NULL
		Constraint DF_Prizes_PrizeAmount Default 0,
	PrizePercentage float
		Constraint DF_Prizes_PrizePercentage Default 0,

	Constraint PK_Prizes Primary Key Clustered (id asc),
);

Create table dbo.TournamentPrizes (
	id int Identity(1,1) NOT NULL,
	TournamentId int,
	PrizeId int,

	Constraint PK_TournamentPrizes Primary Key Clustered (id asc),
	Constraint FK_TP_Prizes Foreign Key (PrizeId) References Prizes(id),
	Constraint FK_TP_Tournaments Foreign Key (TournamentId) References Tournaments(id)
);

Create table dbo.Teams (
	id int Identity(1,1) NOT NULL,
	TeamName nvarchar(150) NOT NULL,

	Constraint PK_Teams Primary Key Clustered (id asc)
);

Create table dbo.TournamentEntries (
	id int Identity(1,1) NOT NULL,
	TournamentId int,
	TeamId int,

	Constraint PK_TournamentEntries Primary Key Clustered (id asc),
	Constraint FK_TE_Teams Foreign Key (TeamId) References Teams(id),
	Constraint FK_TE_Tournaments Foreign Key (TournamentId) References Tournaments(id)
);

Create Table dbo.People (
	id int Identity(1,1) NOT NULL,
	FirstName nvarchar(100) NOT NULL,
	LastName nvarchar(100) NOT NULL,
	EmailAddress nvarchar(200) NOT NULL,
	PhoneNumber varchar(20),

	Constraint PK_People Primary Key Clustered (id asc)
);

Create table dbo.TeamMembers (
	id int Identity(1,1) NOT NULL,
	TeamId int,
	PersonId int,

	Constraint PK_TeamMembers Primary Key Clustered (id asc),
	Constraint FK_TeamMembers_People Foreign Key (PersonId) References People(id),
	Constraint FK_TeamMembers_Team Foreign Key (TeamId) References Teams(id)
);

Create table dbo.Matchups (
	id int Identity(1,1) NOT NULL,
	WinnerId int,
	MatchupRound int NOT NULL

	Constraint PK_Matchups Primary Key Clustered (id asc),
	Constraint FK_Matchups_WinningTeam Foreign Key (WinnerId) References Teams(id)
);

Create table dbo.MatchupEntries (
	id int Identity(1,1) NOT NULL,
	MatchupId int,
	TeamCompetingId int,
	Score int NOT NULL
		Constraint DF_ME_Score Default (0),

	Constraint PK_MatchupEntries Primary Key Clustered (id asc),
	Constraint FK_ME_Matchup Foreign Key (MatchupId) References Matchups(id),
	Constraint FK_ME_TeamCompeting Foreign Key (TeamCompetingId) References Teams(id),
);



Create Procedure dbo.spPrizes_Insert
	@PlaceNumber int, 
	@PlaceName nvarchar(50),
	@PrizeAmount money,
	@PrizePercentage float,
	@id int = 0 output
As
Begin
	Set NoCount On;
	
	Insert into dbo.Prizes (PlaceNumber, PlaceName, PrizeAmount, PrizePercentage)
	Values (@PlaceNumber, @PlaceName, @PrizeAmount, @PrizePercentage);

	Select @id = SCOPE_IDENTITY();
End

Go

Create Procedure dbo.spPeople_Insert
	@FirstName nvarchar(100),
	@LastName nvarchar(100),
	@EmailAddress nvarchar(200),
	@PhoneNumber varchar(20),
	@id int = 0 output
As
Begin
	Set NoCount On;

	Insert into dbo.People (FirstName, LastName, EmailAddress, PhoneNumber)
	Values (@FirstName, @LastName, @EmailAddress, @PhoneNumber);

	Select @id = SCOPE_IDENTITY();
End

Go

Create Procedure dbo.spTeams_Insert
	@TeamName nvarchar(100),
	@id int = 0 output
As
Begin
	Set NoCount On;

	Insert Into dbo.Teams (TeamName)
	Values (@TeamName);

	Select @id = SCOPE_IDENTITY();
End

Go

Create Procedure dbo.spTeamMembers_Insert
	@TeamId int, 
	@PersonId int,
	@id int = 0 output
As
Begin
	Set NoCount On;

	Insert Into dbo.TeamMembers (TeamId, PersonId)
	Values (@TeamId, @PersonId);

	Select @id = SCOPE_IDENTITY();

End

Go

Create Procedure dbo.spMatchupEntries_GetByMatchup
	@MatchupId int
As
Begin
	Set NoCount On;

	Select me.*
	From dbo.MatchupEntries me
	Where me.MatchupId = @MatchupId;

End

Go

Create Procedure dbo.spMatchups_GetByTournament
	@TournamentId int
As
Begin
	Set NoCount On;

	Select m.*
	From dbo.Matchups m
	Join dbo.MatchupEntries me On m.id = me.MatchupId
	Join dbo.Teams tm On tm.id = me.TeamCompetingId
	Join dbo.TournamentEntries te On tm.id = te.TeamId
	Where te.TournamentId = @TournamentId;
End

Go

Create Procedure dbo.spPeople_GetAll
As

Begin
	Set NoCount On;

	Select p.*
	From dbo.People p;
End

Go

Create Procedure dbo.spPrizes_GetByTournament
	@TournamentId int
As
Begin
	Set NoCount On;

	Select p.*
	From Prizes p
	Join dbo.TournamentPrizes tp On p.id = tp.PrizeId
	Where tp.TournamentId = @TournamentId;
End

Go

Create Procedure dbo.spTeam_GetByTournament
	@TournamentId int
As
Begin
	Set NoCount On;

	Select t.*
	From dbo.Teams t
	Join dbo.TournamentEntries te On t.id = te.TeamId
	Where te.TournamentId = @TournamentId;
End

Go

Create Procedure dbo.spTeamMembers_GetByTeam
	@TeamId int
As
Begin
	Set NoCount On;

	Select tm.*
	From dbo.TeamMembers tm
	Join dbo.Teams t On t.id = tm.TeamId
	Where tm.TeamId = @TeamId;
End

Go

Create Procedure dbo.spTournaments_GetAll
As
Begin
	Set NoCount On;

	Select t.*
	From dbo.Tournaments t
End

Go