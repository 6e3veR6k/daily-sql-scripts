SELECT
	--C.id AS CaseId,
	--C.Number AS CaseNumber, 
	--D.Number AS ActNumber,
	--D.id AS ActId,
	--R.ClaimDate AS ActCalcDate,
	--D.AddDate AS ActDate, -- clarify date
	--P.gid AS ProductGid,
	--P.BranchGID AS PolisBranch, -- or caseBranch?
	----дата відмови?
	CDD.*,
	DT.*
FROM dbo.Cases AS C
INNER JOIN dbo.CasesDocuments AS CD ON CD.CaseGID = C.gid 
INNER JOIN dbo.Documents AS CDD ON CDD.gid = CD.DocumentGID 
INNER JOIN meta.DocumentTypes AS DT ON DT.gid = CDD.TypeGID