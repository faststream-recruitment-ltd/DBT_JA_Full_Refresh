{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "jobadder",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='job_ads_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('job_ads_ab3') }}
select
   owner_userId,
    owner_lastName,
    owner_firstName,
    summary,
    postat,
    description,
    title,
    expireat,
    jobBoard_name,
    boardId,
    reference,
    createdat,
    adid,
    createdBy_userId,
    createdBy_lastName,
    createdBy_firstName,
    contact_lastName,
    contactId,
    contact_firstName,
    company_name,
    companyId,
    jobId,
    job_jobTitle,
    {{ adapter.quote('state') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_job_ads_hashid
from {{ ref('job_ads_ab3') }}
-- job_ads from {{ source('public', '_airbyte_raw_job_ads') }}
where 1 = 1

