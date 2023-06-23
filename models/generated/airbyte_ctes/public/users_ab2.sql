{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_ab1') }}
select
    cast(mentionname as {{ dbt_utils.type_string() }}) as mentionname,
    cast(lastname as {{ dbt_utils.type_string() }}) as lastname,
    cast(jobtitle as {{ dbt_utils.type_string() }}) as jobtitle,
    cast(mobile as {{ dbt_utils.type_string() }}) as mobile,
    cast(office as {{ type_json() }}) as office,
    cast(userid as {{ dbt_utils.type_bigint() }}) as userid,
    cast(createdat as timestamp with time zone) as createdat,
    cast(firstname as {{ dbt_utils.type_string() }}) as firstname,
    {{ cast_to_boolean('deleted') }} as deleted,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(links as {{ type_json() }}) as links,
    cast({{ adapter.quote('position') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('position') }},
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(updatedat as timestamp with time zone) as updatedat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_ab1') }}
-- users
where 1 = 1

