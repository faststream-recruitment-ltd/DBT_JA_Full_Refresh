{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_job_ads') }}
select
    {{ json_extract('table_alias', '_airbyte_data', ['owner'], ['owner']) }} as {{ adapter.quote('owner') }},
    {{ json_extract_scalar('_airbyte_data', ['summary'], ['summary']) }} as summary,
    {{ json_extract_scalar('_airbyte_data', ['postAt'], ['postAt']) }} as postat,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['expireAt'], ['expireAt']) }} as expireat,
    {{ json_extract_array('_airbyte_data', ['jobBoards'], ['jobBoards']) }} as jobboards,
    {{ json_extract_scalar('_airbyte_data', ['reference'], ['reference']) }} as reference,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['adId'], ['adId']) }} as adid,
    {{ json_extract('table_alias', '_airbyte_data', ['createdBy'], ['createdBy']) }} as createdby,
    {{ json_extract('table_alias', '_airbyte_data', ['contact'], ['contact']) }} as contact,
    {{ json_extract_string_array('_airbyte_data', ['bulletPoints'], ['bulletPoints']) }} as bulletpoints,
    {{ json_extract('table_alias', '_airbyte_data', ['links'], ['links']) }} as links,
    {{ json_extract('table_alias', '_airbyte_data', ['company'], ['company']) }} as company,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as {{ adapter.quote('state') }},
    {{ json_extract('table_alias', '_airbyte_data', ['job'], ['job']) }} as job,
    {{ json_extract_array('_airbyte_data', ['otherApplyUrls'], ['otherApplyUrls']) }} as otherapplyurls,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_job_ads') }} as table_alias
-- job_ads
where 1 = 1

