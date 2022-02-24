Create Procedure dbo.spPrizes_Insert
	@PlaceNumber int, 
	@PlaceName nvarchar(50),
	@PrizeAmt money,
	@PrizePercent float,
	@id int = 0 output
As
Begin
	Set NoCount On;
	
	Insert into dbo.Prizes (PlaceNumber, PlaceName, PrizeAmt, PrizePercent)
	Values (@PlaceNumber, @PlaceName, @PrizeAmt, @PrizePercent);

	Select @id = SCOPE_IDENTITY();
End

Go

Create Procedure dbo.spPeople_Insert
	@FirstName nvarchar(100),
	@LastName nvarchar(100),
	@Email nvarchar(200),
	@PhoneNumber varchar(20),
	@id int = 0 output
As
Begin
	Set NoCount On;

	Insert into dbo.People (FirstName, LastName, Email, PhoneNumber)
	Values (@FirstName, @LastName, @Email, @PhoneNumber);

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