{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='job_boards_scd'
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
-- depends_on: {{ ref('job_boards_ab3') }}
select
    reference,
    {{ adapter.quote('name') }},
    boardid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_job_boards_hashid
from {{ ref('job_boards_ab3') }}
-- job_boards from {{ source('public', '_airbyte_raw_job_boards') }}
where 1 = 1

