# redmine plugin: Smile Enumeration API

Provides API access for [Smile Project Enumerations Custom Field Format](https://github.com/Smile-SA/redmine_smile_project_enumerations_custom_field_format).

This plugin exposes project enumerations defined in Smile's custom field format as a JSON API.

## Reference

- Original plugin: https://github.com/Smile-SA/redmine_smile_project_enumerations_custom_field_format  
- Related issue: https://github.com/Smile-SA/redmine_smile_project_enumerations_custom_field_format/issues/19

## Usage

### Endpoint

GET /smile_enumerations/project.json

### Example Curl

# use X-Redmine-API-Key header
curl -H "X-Redmine-API-Key: your_api_key" \
     http://your-redmine-domain/redmine/smile_enumerations/project.json

Replace `your_api_key` with a valid Redmine API key for an authenticated user.

## Author

linchao chang
