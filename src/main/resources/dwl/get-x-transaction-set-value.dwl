%dw 2.0
// Import function to process result.
import getXTransactionSetValue from dwl::Util
output application/json
---
// If x-transaction-set is set in the header, use what 
// is provided. Otherwise we will attempt to auto detect 
// the message type.
if (!isEmpty(attributes.headers.'x-transaction-set'))
	attributes.headers.'x-transaction-set'
else
	getXTransactionSetValue(payload)