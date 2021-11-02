
SELECT
	--CD.DocumentGID, --change to id
	--D.gid,
	--D.id,

	--D.Name,
	--D.Serial,
	--D.Number,
	--D.StartDate,
	--D.EndDate,
	--D.IssuedBy,
	--D.IssuedDate,
	--D.ObjectGID,
	--D.TypeGID,
	--D.Type,
	--D.IsLockedOut,
	--D.AutoGeneratNumbere,

	--CD.CaseGID, --change to id
	
	--CD.AddDate,
	--D.AddDate,
	--IIF(CD.AddDate = D.AddDate, 'TRUE', 'FALSE'),
	
	--CD.AddUserGID, --change to name
	--D.AddUserGID, --change to name
	--IIF(CD.AddUserGID = D.AddUserGID, 'TRUE', 'FALSE'),

	--CD.AuthorGID, --change to name
	--D.AuthorGID, --change to name
	--IIF(CD.AuthorGID = D.AuthorGID, 'TRUE', 'FALSE'),

	--CD.ProcessingStatusGID, --change to name

	--CD.StatusGID, --change to name

	--CD.IsAccepted,

	--CD.ParentGID, -- foreing key to CD.gid - change to parentId

	--CD.Deleted,
	--D.Deleted,
	--IIF(CD.Deleted = D.Deleted, 'TRUE', 'FALSE'),
	--C.*
	*
FROM dbo.Cases AS C 
INNER JOIN dbo.CasesDocuments AS CD ON C.gid = CD.CaseGID
INNER JOIN dbo.Documents AS D ON D.gid = CD.DocumentGID



WHERE C.Number = '21--325'
ORDER BY CD.CaseGID


