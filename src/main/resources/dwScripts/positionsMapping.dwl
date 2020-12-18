%dw 2.0
output application/json
fun getStandardMatchKey(teamMemberId, position) = teamMemberId ++ (position.Location_Code default "") ++ (position.POS_Job_Code default "")
fun getRtiMatchKey(teamMemberId, position) = teamMemberId ++ (position.Location_Code default "") ++ (position.RTI_Department_Number default "")
fun getStandardPrimaryJobMatchkey(teamMemberId, position) = (
	if (position.Primary_Job == "1") (teamMemberId ++ "PrimaryJob")
	else "")
fun getRtiPrimaryJobMatchkey(teamMemberId, position) = ( 
	if (position.Primary_Job == "1") (teamMemberId ++ "PrimaryJob")
	else "")
fun getStandardPrimaryStoreAndJobMatch(teamMemberId, workerPrimaryLocation, position) = (
	if (workerPrimaryLocation == position.Location_Code) (teamMemberId ++ "PrimaryStore" ++ (position.POS_Job_Code default ""))
	else "")
fun getRtiPrimaryStoreAndJobMatch(teamMemberId, workerPrimaryLocation, position) = (
	if (workerPrimaryLocation == position.Location_Code) (teamMemberId ++ "PrimaryStore" ++ (position.RTI_Department_Number default ""))
	else "")
fun brandKey(standardKey, rtiKey) = (
	if (vars.currentCompany.companyCode contains("ARB")) rtiKey
	else standardKey)
---
flatten(payload.Report_Entry map ((item, index) -> (
	(item.All_Positions___Jobs_group map {
			standardMatch: getStandardMatchKey(item.Team_Member_ID, $),
			rtiMatch: getRtiMatchKey(item.Team_Member_ID, $),
			positionId: $.Position_ID,
			standardPrimaryJobMatch: getStandardPrimaryJobMatchkey(item.Team_Member_ID, $),
			standardPrimaryStoreAndJobMatch: getStandardPrimaryStoreAndJobMatch(item.Team_Member_ID, item.Worker_Location, $),
			rtiPrimaryJobMatch: getRtiPrimaryJobMatchkey(item.Team_Member_ID, $), // this works for altametrics as well
			rtiPrimaryStoreAndJobMatch: getRtiPrimaryStoreAndJobMatch(item.Team_Member_ID, item.Worker_Location, $), // this works for altametrics as well
			storeCode: ($.Location_Code default ""),
			payGroup: ($.Pay_Group default "")
		} distinctBy brandKey($.standardMatch, $.rtiMatch)
	)
)))