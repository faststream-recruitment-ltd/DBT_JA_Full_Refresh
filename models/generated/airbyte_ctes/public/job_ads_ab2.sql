{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('job_ads_ab1') }}
select
    cast({{ adapter.quote('owner') }} as {{ type_json() }}) as {{ adapter.quote('owner') }},
    cast(summary as {{ dbt_utils.type_string() }}) as summary,
    cast(postat as {{ dbt_utils.type_string() }}) as postat,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(expireat as {{ dbt_utils.type_string() }}) as expireat,
    jobboards,
    cast(reference as {{ dbt_utils.type_string() }}) as reference,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(adid as {{ dbt_utils.type_bigint() }}) as adid,
    cast(createdby as {{ type_json() }}) as createdby,
    cast(contact as {{ type_json() }}) as contact,
    bulletpoints,
    cast(links as {{ type_json() }}) as links,
    cast(company as {{ type_json() }}) as company,
    cast({{ adapter.quote('state') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('state') }},
    cast(job as {{ type_json() }}) as job,
    otherapplyurls,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('job_ads_ab1') }}
-- job_ads
where 1 = 1

