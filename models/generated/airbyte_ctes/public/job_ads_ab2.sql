{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('job_ads_ab1') }}
select
    cast(owner_userId as {{ dbt_utils.type_string() }}) as owner_userId,
    cast(owner_lastName as {{ dbt_utils.type_string() }}) as owner_lastName,
    cast(owner_firstName as {{ dbt_utils.type_string() }}) as owner_firstName,
    cast(owner_deleted as {{ dbt_utils.type_string() }}) as owner_deleted,
    cast(summary as {{ dbt_utils.type_string() }}) as summary,
    cast(postat as {{ dbt_utils.type_string() }}) as postat,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(expireat as {{ dbt_utils.type_string() }}) as expireat,
    cast(jobBoard_name as {{ dbt_utils.type_string() }}) as jobBoard_name,
    cast(boardId as {{ dbt_utils.type_string() }}) as boardId,
    cast(reference as {{ dbt_utils.type_string() }}) as reference,
    cast(createdat as timestamp with time zone) createdat,
    cast(adid as {{ dbt_utils.type_bigint() }}) as adid,
    cast(createdBy_email as {{ dbt_utils.type_string() }}) as createdBy_email,
    cast(createdBy_userId as {{ dbt_utils.type_string() }}) as createdBy_userId,
    cast(createdBy_lastName as {{ dbt_utils.type_string() }}) as createdBy_lastName,
    cast(createdBy_firstName as {{ dbt_utils.type_string() }}) as createdBy_firstName,
    cast(createdBy_deleted as {{ dbt_utils.type_string() }}) as createdBy_deleted,
    cast(contact_email as {{ dbt_utils.type_string() }}) as contact_email,
    cast(contact_lastName as {{ dbt_utils.type_string() }}) as contact_lastName,
    cast(contactId as {{ dbt_utils.type_string() }}) as contactId,
    cast(contact_firstName as {{ dbt_utils.type_string() }}) as contact_firstName,
    cast(company_name as {{ dbt_utils.type_string() }}) as company_name,
    cast(companyId as {{ dbt_utils.type_string() }}) as companyId,
    cast({{ adapter.quote('state') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('state') }},
    cast(jobId as {{ dbt_utils.type_string() }}) as jobId,
    cast(job_source as {{ dbt_utils.type_string() }}) as job_source,
    cast(job_jobTitle as {{ dbt_utils.type_string() }}) as job_jobTitle,
    cast(job_status_name as {{ dbt_utils.type_string() }}) as job_status_name,
    cast(jobs_status_active as {{ dbt_utils.type_string() }}) as jobs_status_active,
    cast(jobs_status_statusId as {{ dbt_utils.type_string() }}) as jobs_status_statusId,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('job_ads_ab1') }}
-- job_ads
where 1 = 1

