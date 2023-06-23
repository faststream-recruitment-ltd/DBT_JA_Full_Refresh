{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_groups_ab1') }}
select
    cast(userid as {{ dbt_utils.type_bigint() }}) as userid,
    cast(firstname as {{ dbt_utils.type_string() }}) as firstname,
    cast(mentionname as {{ dbt_utils.type_string() }}) as mentionname,
    cast(lastname as {{ dbt_utils.type_string() }}) as lastname,
    cast(createdat as timestamp with time zone) as createdat,
    cast(groupId as {{ dbt_utils.type_bigint() }}) as groupId,
    cast(group_name as {{ dbt_utils.type_string() }}) as group_name,   
    cast(jobtitle as {{ dbt_utils.type_string() }}) as jobtitle,
    cast(timezone as {{ dbt_utils.type_string() }}) as timezone,
    cast(office_name as {{ dbt_utils.type_string() }}) as office_name,
    cast(office_city as {{ dbt_utils.type_string() }}) as office_city,
    cast(office_country as {{ dbt_utils.type_string() }}) as office_country,
    cast(office_phone as {{ dbt_utils.type_string() }}) as office_phone,
    cast(office_street as {{ dbt_utils.type_string() }}) as office_street,
    cast(office_officeid as {{ dbt_utils.type_bigint() }}) as office_officeid,
    cast(office_countrycode as {{ dbt_utils.type_string() }}) as office_countrycode,
    cast(office_postalcode as {{ dbt_utils.type_string() }}) as office_postalcode,
    cast(office_state as {{ dbt_utils.type_string() }}) as office_state,  
    {{ cast_to_boolean('deleted') }} as deleted,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(culture as {{ dbt_utils.type_string() }}) as culture,
    cast({{ adapter.quote('position') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('position') }},
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(updatedat as timestamp with time zone) as updatedat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_groups_ab1') }}
-- user_groups
where 1 = 1

