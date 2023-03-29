{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_users') }}
select
    {{ json_extract_scalar('_airbyte_data', ['mentionName'], ['mentionName']) }} as mentionname,
    {{ json_extract_scalar('_airbyte_data', ['lastName'], ['lastName']) }} as lastname,
    {{ json_extract_scalar('_airbyte_data', ['jobTitle'], ['jobTitle']) }} as jobtitle,
    {{ json_extract_scalar('_airbyte_data', ['mobile'], ['mobile']) }} as mobile,
    {{ json_extract('table_alias', '_airbyte_data', ['office'], ['office']) }} as office,
    {{ json_extract_scalar('_airbyte_data', ['userId'], ['userId']) }} as userid,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['firstName'], ['firstName']) }} as firstname,
    {{ json_extract_scalar('_airbyte_data', ['deleted'], ['deleted']) }} as deleted,
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    {{ json_extract('table_alias', '_airbyte_data', ['links'], ['links']) }} as links,
    {{ json_extract_scalar('_airbyte_data', ['position'], ['position']) }} as {{ adapter.quote('position') }},
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_users') }} as table_alias
-- users
where 1 = 1

