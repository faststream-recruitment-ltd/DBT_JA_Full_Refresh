{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_deleted_contacts') }}
select
    {{ json_extract_scalar('_airbyte_data', ['deletedAt'], ['deletedAt']) }} as deletedat,
    {{ json_extract_scalar('_airbyte_data', ['contactId'], ['contactId']) }} as contactid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_deleted_contacts') }} as table_alias
-- deleted_contacts
where 1 = 1

