{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "jobadder",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='deleted_candidates_scd'
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
-- depends_on: {{ ref('deleted_candidates_ab3') }}
select
    deletedat,
    candidateid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_deleted_candidates_hashid
from {{ ref('deleted_candidates_ab3') }}
-- deleted_candidates from {{ source('public', '_airbyte_raw_deleted_candidates') }}
where 1 = 1

