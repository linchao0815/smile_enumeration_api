# redmine plugin: Smile Enumeration API

Provides API access for [Smile Project Enumerations Custom Field Format](https://github.com/Smile-SA/redmine_smile_project_enumerations_custom_field_format).

This plugin exposes project enumerations defined in Smile's custom field format as a JSON API.

## Reference

- Original plugin: https://github.com/Smile-SA/redmine_smile_project_enumerations_custom_field_format  
- Related issue: https://github.com/Smile-SA/redmine_smile_project_enumerations_custom_field_format/issues/19

## Usage

### Endpoint

GET /smile_enumerations/project.json


### Required Headers

X-Redmine-API-Key: your_api_key


Replace `your_api_key` with a valid Redmine API key for an authenticated user.

### Example Curl

```bash
curl -H "X-Redmine-API-Key: your_api_key" \
     https://your-redmine-domain/smile_enumerations/project.json
```
## Author

linchao chang
