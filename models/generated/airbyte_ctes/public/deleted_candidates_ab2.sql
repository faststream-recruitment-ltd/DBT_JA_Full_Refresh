{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('deleted_candidates_ab1') }}
select
    cast(deletedat as {{ dbt_utils.type_string() }}) as deletedat,
    cast(candidateid as {{ dbt_utils.type_bigint() }}) as candidateid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('deleted_candidates_ab1') }}
-- deleted_candidates
where 1 = 1

