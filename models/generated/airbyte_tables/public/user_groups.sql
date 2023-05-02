{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "JobAdder",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='user_groups_scd'
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
-- depends_on: {{ ref('user_groups_ab3') }}
select
    userid,    
    mentionname,
    firstname,
    lastname,
    email,
    groupId,
    group_name,
    {{ adapter.quote('position') }},
    jobtitle,
    phone,
    culture,    
    timezone,
    office_name,
    office_city,
    office_country,
    office_phone,
    office_street,
    office_officeid,
    office_countrycode,
    office_postalcode,
    office_state,
    createdat,
    updatedat,
    deleted,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_groups_hashid
from {{ ref('user_groups_ab3') }}
-- user_groups from {{ source('public', '_airbyte_raw_user_groups') }}
where 1 = 1

