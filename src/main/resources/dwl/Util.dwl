/**
 * A library with needed DataWeave utility functions.
 */

%dw 2.0

// Used for SHA function to generate ID.
import dw::Crypto

// For string manipulation.
import * from dw::core::Strings

/**
 * Generates a GUID with the provided string. This is 
 * helpful because the GUID generated is predictable.
 * @param InStr is the input string to the hash function.
 * @return A string with the predictable hashed value.
 */ 
fun mapGuid(InStr:String) = 
    (Crypto::SHA1(InStr as Binary))[0 to 7]
    ++ "-" ++ (Crypto::SHA1(InStr as Binary))[8 to 11]
    ++ "-" ++ (Crypto::SHA1(InStr as Binary))[12 to 15]
    ++ "-" ++ (Crypto::SHA1(InStr as Binary))[16 to 19]
    ++ "-" ++ (Crypto::SHA1(InStr as Binary))[20 to 31]

/**
 * Converts anything to a JSON string representation. Note that 
 * if you are serializing an object datetime fields may have local 
 * timezone information so this can cause issues with repeatability 
 * for munit tests. Note that the writeAttributes part is very important 
 * so that the XML attributes will be converted to string as well. 
 * @param data is the data type to convert to JSON.
 * @return A JSON formatted string of the provided variable.
 */
fun toString(data) = write(data, "application/json", { "writeAttributes": true })

/**
 * Cleans the provided object of blank strings, null values,
 * empty objects, and empty arrays.
 * @param obj is an Object to clean.
 * @return A cleaned object.
 */
fun clean(obj:Object) = (
    removeNull(
        obj mapObject (value, key, index) -> (
            if (typeOf(value) as String == "Array")
                (key): clean(value)
            else if (typeOf(value) as String == "Object")
                (key): clean(value)
            else if (!isEmpty(value) and value != "")
                (key): value
            else (key): null
        )
    )
)

/**
 * Cleans the provided array of blank strings, null values,
 * empty objects, and empty arrays.
 * @param arr is an Array to clean.
 * @return A cleaned Array.
 */
fun clean(arr:Array) = (
    removeNull(
        arr map (value, index) -> (
            if (typeOf(value) as String == "Array")
                clean(value)
            else if (typeOf(value) as String == "Object")
                clean(value)
            else if (!isEmpty(value) and value != "")
                value
            else null
        )
    )
)

/**
 * Removes all null items from an array.
 * @param arr is an array.
 * @return An array with null items removed.
 */
fun removeNull(arr:Array) = (
    if (!isEmpty(arr))
        arr filter ($ != null and !isEmpty($))
    else []
)

/**
 * Removes all null values from an object.
 * @param obj is an object.
 * @return An object with null values removed.
 */
fun removeNull(obj:Object) = (
    if (!isEmpty(obj))
        obj mapObject (value, key, index) -> 
        (
            (key): value
        ) if (!isEmpty(value))
    else {}
)

/**
 * Formats the provided X12 date (YYYYMMDD) to the 
 * FHIR date format (YYYY-MM-DD). If the provided date 
 * doesn't match the X12 format, it simply returns 
 * what was provided.
 * @param dateStr is a string with the X12 date to format.
 * @return A FHIR formatted date or what was passed in 
 * if the X12 format isn't matched.
 */
fun formatDate(dateStr) = 
if (!(dateStr contains("-")) and sizeOf(dateStr) == 8)
    substring(dateStr, 0, 4) ++ "-" 
    ++ substring(dateStr, 4, 6) ++ "-"
    ++ substring(dateStr, 6, 8)
else
    dateStr

/**
 * Removed any generated IDs such as GUIDS from the 
 * payload for testing purposes.
 * @param data is FHIR bundle with the data to remove 
 * IDs from.
 * @return The FHIR bundle with generated IDs removed.
 */
fun removeGeneratedIds(data) = 
(data - "entry" - "identifier") ++ 
{
    entry: data.entry map (item, index) -> 
    removeAllInstances(
        (
            if (!isEmpty(item.request))
                (item - "fullUrl" - "resource" - "request")
                ++ { resource: (item.resource - "id") }
                ++ { request: (item.request - "url") }
            else
                (item - "fullUrl" - "resource")
                ++ { resource: (item.resource - "id") }
        ), ["reference", "created"]
    )
}

/**
 * Recursivly removes all instances of the provided 
 * fieldName within the provided data structure.
 * @param data is an array or object to remove the 
 * field from.
 * @param fieldNames is a array of strings with the field  
 * names to remove.
 * @return The data with the field removed.
 */
fun removeAllInstances(data, fieldNames:Array) = 
(
    if (typeOf(data) as String == "Array")
        data map (item, index) -> removeAllInstances(item, fieldNames)
    else if (typeOf(data) as String == "Object")
        data mapObject ((value, key, index) -> 
            (
                (key): removeAllInstances(value, fieldNames)
            ) if !(fieldNames contains(key as String))
        )
    else 
        data
)

/**
 * Gets the first Set Header (ST) line in 
 * the message and returns it.
 * @param data is a X12 payload.
 * @return A string with the Set Header line or null.
 */
fun getSetHeader(data) = 
(
    data splitBy("\n")
        filter (line, ind) -> line startsWith("ST*")
)[0]


/**
 * Gets the x-transaction-set header value to provide 
 * to X12 system API from the provided message.
 * @param data is a X12 payload.
 * @return The x-transaction-set header value for 
 * the provided message or an empty string if not 
 * matched.
 */
fun getXTransactionSetValue(data) = 
(
    using (parts = getSetHeader(data) splitBy("*"))
    if (parts[1] == "271" and (parts[3] startsWith("005010X279A1")))
        "005010X279A1-271"
    else if (parts[1] == "278" and (parts[3] startsWith("005010X215")))
        "005010X215-278RS"
    else if (parts[1] == "278" and (parts[3] startsWith("005010X217")))
        "005010X217-278RS"
    else ""
)