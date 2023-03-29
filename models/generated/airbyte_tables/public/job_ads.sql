{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
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
    {{ adapter.quote('owner') }},
    summary,
    postat,
    description,
    title,
    expireat,
    jobboards,
    reference,
    createdat,
    adid,
    createdby,
    contact,
    bulletpoints,
    links,
    company,
    {{ adapter.quote('state') }},
    job,
    otherapplyurls,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_job_ads_hashid
from {{ ref('job_ads_ab3') }}
-- job_ads from {{ source('public', '_airbyte_raw_job_ads') }}
where 1 = 1

