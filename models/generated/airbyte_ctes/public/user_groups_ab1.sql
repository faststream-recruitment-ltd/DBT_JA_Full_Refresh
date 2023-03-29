{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_user_groups') }}
select
    {{ json_extract_scalar('_airbyte_data', ['mentionName'], ['mentionName']) }} as mentionname,
    {{ json_extract_scalar('_airbyte_data', ['firstName'], ['firstName']) }} as firstname,
    {{ json_extract_scalar('_airbyte_data', ['lastName'], ['lastName']) }} as lastname,
    {{ json_extract_scalar('_airbyte_data', ['jobTitle'], ['jobTitle']) }} as jobtitle,
    {{ json_extract_scalar('_airbyte_data', ['timeZone'], ['timeZone']) }} as timezone,
    {{ json_extract_scalar('_airbyte_data', ['office', 'name'], ['office_name']) }} as office_name,
    {{ json_extract_scalar('_airbyte_data', ['office', 'city'], ['office_city']) }} as office_city,
    {{ json_extract_scalar('_airbyte_data', ['office', 'country'], ['office_country']) }} as office_country,
    {{ json_extract_scalar('_airbyte_data', ['office', 'phone'], ['office_phone']) }} as office_phone,
    {{ json_extract_scalar('_airbyte_data', ['office', 'street'], ['office_street']) }} as office_street,
    {{ json_extract_scalar('_airbyte_data', ['office', 'officeid'], ['office_officeid']) }} as office_officeid,
    {{ json_extract_scalar('_airbyte_data', ['office', 'countrycode'], ['office_countrycode']) }} as office_countrycode,
    {{ json_extract_scalar('_airbyte_data', ['office', 'postalcode'], ['office_postalcode']) }} as office_postalcode,
    {{ json_extract_scalar('_airbyte_data', ['office', 'state'], ['office_state']) }} as office_state,   
    {{ json_extract_scalar('_airbyte_data', ['userId'], ['userId']) }} as userid,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'userGroups'))->>'groupId' as groupId,
    jsonb_array_elements(jsonb_extract_path(_airbyte_data, 'userGroups'))->>'name' as group_name,
    {{ json_extract_scalar('_airbyte_data', ['deleted'], ['deleted']) }} as deleted,
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('_airbyte_data', ['culture'], ['culture']) }} as culture,
    {{ json_extract_scalar('_airbyte_data', ['position'], ['position']) }} as {{ adapter.quote('position') }},
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_user_groups') }} as table_alias
-- user_groups
where 1 = 1

