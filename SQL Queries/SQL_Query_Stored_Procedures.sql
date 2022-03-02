CREATE PROCEDURE dbo.spPrizes_Insert
	@PlaceNumber INT, 
	@PlaceName NVARCHAR(50), 
	@PrizeAmount MONEY, 
	@PrizePercentage float, 
	@id INT = 0 OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO dbo.Prizes (PlaceNumber, PlaceName, PrizeAmount, PrizePercentage)
	VALUES (@PlaceNumber, @PlaceName, @PrizeAmount, @PrizePercentage);

	SELECT @id = SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE dbo.spPeople_Insert
	@FirstName NVARCHAR(100), 
	@LastName NVARCHAR(100), 
	@EmailAddress NVARCHAR(200), 
	@PhoneNumber VARCHAR(20), 
	@id INT = 0 OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.People (FirstName, LastName, EmailAddress, PhoneNumber)
	VALUES (@FirstName, @LastName, @EmailAddress, @PhoneNumber);

	SELECT @id = SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE dbo.spTeams_GetAll
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM dbo.Teams;
END
GO

CREATE PROCEDURE dbo.spTeams_Insert
	@TeamName NVARCHAR(100), 
	@id INT = 0 OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.Teams (TeamName)
	VALUES (@TeamName);

	SELECT @id = SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE dbo.spTeamMembers_Insert
	@TeamId INT, 
	@PersonId INT, 
	@id INT = 0 OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.TeamMembers (TeamId, PersonId)
	VALUES (@TeamId, @PersonId);

	SELECT @id = SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE dbo.spMatchupEntries_GetByMatchup
	@MatchupId INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT me.*
	FROM dbo.MatchupEntries me
	WHERE me.MatchupId = @MatchupId;
END
GO

CREATE PROCEDURE dbo.spMatchups_GetByTournament
	@TournamentId INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT m.*
	FROM dbo.Matchups m
	Join dbo.MatchupEntries me ON m.id = me.MatchupId
	Join dbo.Teams tm ON tm.id = me.TeamCompetingId
	Join dbo.TournamentEntries te ON tm.id = te.TeamId
	WHERE te.TournamentId = @TournamentId;
END
GO

CREATE PROCEDURE dbo.spMatchups_Insert
	@TournamentId INT, 
	@MatchupRound INT, 
	@Id INT = 0 OUTPUT

AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.Matchups (TournamentId, MatchupRound)
	VALUES (@TournamentId, @MatchupRound)
	SELECT @Id= SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE dbo.spMatchupEntries_Insert
	@MatchupId INT, 
	@ParentMatchupId INT, 
	@TeamCompetingId INT, 
	@id INT=0 OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.MatchupEntries (MatchupId, ParentMatchupId, TeamCompetingId)
	VALUES (@MatchupId, @ParentMatchupId, @TeamCompetingId)

	SELECT @id= SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE dbo.spPeople_GetAll
AS
BEGIN
	SET NOCOUNT ON;

	SELECT p.*
	FROM dbo.People p;
END
GO

CREATE PROCEDURE dbo.spPrizes_GetByTournament
	@TournamentId INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT p.*
	FROM Prizes p
	Join dbo.TournamentPrizes tp ON p.id = tp.PrizeId
	WHERE tp.TournamentId = @TournamentId;
END
GO

CREATE PROCEDURE dbo.spTeam_GetByTournament
	@TournamentId INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT t.*
	FROM dbo.Teams t
	Join dbo.TournamentEntries te ON t.id = te.TeamId
	WHERE te.TournamentId = @TournamentId;
END
GO

CREATE PROCEDURE dbo.spTournament_Insert
	@TournamentName NVARCHAR (200), 
	@EntryFee MONEY, 
	@Id INT = 0 OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.Tournaments (TournamentName, EntryFee, Active)
	VALUES (@TournamentName, @EntryFee, 1);
	SELECT @id = SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE dbo.spTeamMembers_GetByTeam
	@TeamId INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT tm.*
	FROM dbo.TeamMembers tm
	Join dbo.Teams t ON t.id = tm.TeamId
	WHERE tm.TeamId = @TeamId;
END
GO

CREATE PROCEDURE dbo.spTournamentEntries_Insert
	@TournamentId INT, 
	@TeamId INT, 
	@id INT = 0 OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	 INSERT INTO dbo.TournamentEntries (TournamentId, TeamId)
	 VALUES (@TournamentId, @TeamId)
	 SELECT @id= SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE dbo.spTournamentPrizes_Insert
	@TournamentId INT, 
	@PrizeId INT, 
	@Id INT=0 OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.TournamentPrizes (TournamentId, PrizeId)
	VALUES (@TournamentId, @PrizeId);
	SELECT @id = SCOPE_IDENTITY();
END
GO

CREATE PROCEDURE dbo.spTournaments_GetAll
AS
BEGIN
	SET NOCOUNT ON;

	SELECT t.*
	FROM dbo.Tournaments t
END
GO