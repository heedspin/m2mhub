SELECT DISTINCT
	im.fpartno AS PartNo
	, im.frev AS Rev
	, iv.fcpartrev AS CurRev
	, im.fdescript AS 'Description'
	, ih.fonhand AS OnHandQty
	, ih.flocation AS Locat
	, ih.fbinno AS BinNo
	, im.fstdcost AS StandCost
	, im.f2totcost AS RolledCost
	, im.flastcost AS LastActCost
	, im.fgroup AS 'Group'
	, im.fprodcl AS ProdClass
	, im.flastiss AS LastIssue
	, im.flastrcpt AS LastReceipt
	, im.fsafety AS Safety
FROM inmast AS im
	, inonhd AS ih
	, intran AS it
	, invcur AS iv
WHERE im.fpartno = ih.fpartno
	AND im.frev = ih.fpartrev
	AND im.fpartno = it.fpartno
	AND im.frev = it.fcpartrev
	AND im.flastrcpt < '2011-06-01'
	AND im.flastiss < '2011-06-01'
	AND ih.fonhand > '0'
	AND im.fbook <= '0'
	AND im.fpartno = iv.fcpartno
	AND im.fcstscode = 'A'
ORDER BY im.fprodcl, im.fgroup, im.fpartno
