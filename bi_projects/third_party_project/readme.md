# third party project
## steps
- Get permission to MixPanel - Access token
- Explore the data in MixPanel
- Extract sample data - Examine the schema, Which events. Developer docs
- Transform - if needed
    - Unnest the raw data.
    - {"event":"Gal", "properties":{"time":1, "b":2}}
    - {"event":"Gal", "time":1, "b":2}
- Load - Data to BigQuery. In development env
- Validate the data on DWH
- Develop script from A2Z in Python
- Schedualing
- Documentation
- Logs & alerts
- Configuration
- Validation procedure

```dtd
mkdir -p .\temp\bi\third_party_project\mp_api_raw_20241007.json
```