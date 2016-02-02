## Overview

The JSON schema files are descriptions of the format of the responses from REST calls.  The description is given in JSON as well (similar to XSD schema documents are XML themselves).

The Ruby json-schema gem can be used for validating JSON strings against these schema documents.

## Example

The example simple schema show below can be used to validate JSON that looks like the following

```
{
	"created":"2015-04-15-10:10:01ZT",
	"version":"1.2.7-012345",
	"summaries": [
	    {
		  "name":"Database Connection",
		  "status":"OK"
		},
		
		{
		  "name":"GeoBlocking Service",
		  "status":"NOT_OK"
		}
	  ]
	}
}
```

This schema description will match the above

```
{
    "type":"object",
    "$schema":"http://json-schema.org/draft-03/schema",
    "id":"http://jsonschema.net",
    "required":false,
    "properties":{
        "created":{
            "id":"http://jsonschema.net/created",
            "required":true,
            "type":"string"
        },
        "version":{
        	"id":"http://jsonschema.net/version",
        	"required":true,
        	"type":"string"
        },
        "summaries":{
            "id":"http://jsonschema.net/summaries",
            "required":false,
            "type":"array",
            "items":{
                "id":"http://jsonschema.net/summaries/0",
                "required":false,
                "type":"object",
                "properties":{
                    "name":{
                        "name":"http://jsonschema.net/summaries/0/name",
                        "required":false,
                        "type":"string"
                    },
                    "status":{
                        "id":"http://jsonschema.net/summaries/0/status",
                        "required":false,
                        "type":"string"
                    }
                }
            }
        }
    }
}
```


## More Info

See [json-schema.org](http://json-schema.org)

