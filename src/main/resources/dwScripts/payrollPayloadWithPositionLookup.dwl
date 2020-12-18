%dw 2.0
output application/json

fun isNotEmpty (value) = (
	(not (isEmpty (value)))
)
---
payload map ((item, index) -> {
	"batchId": trim(item.batchId),
    "payrollBatchIdentifier": trim(item.payrollBatchIdentifier),
    "payrollInputIdentifier": trim(item.payrollInputIdentifier),
    "startDate": trim(item.startDate),
    "endDate": trim(item.endDate),
    "teamMemberIdentifier": trim(item.teamMemberIdentifier),
    "positionCode": vars.lookupPostionId[trim(item.teamMemberIdentifier) ++ trim(item.siteId) ++ trim(item.jobCode)] default "P-100000002",
    "siteId": trim(item.siteId),
    "jobCode": trim(item.jobCode),
    "earningCode": trim(item.earningCode),
    "hours": trim(item.hours as String) default "",
    "amount": trim(item.amount as String) default "",
    "comments": ""
}) filter (
			($.hours !="" and $.hours !=null)
			or
			($.amount !="" and $.amount !=null)
		)