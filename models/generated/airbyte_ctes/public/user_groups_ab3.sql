{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_groups_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'mentionname',
        'lastname',
        'jobtitle',
        'timezone',
        'office_name',
        'office_city',
        'office_country',
        'office_phone',
        'office_street',
        'office_officeid',
        'office_countrycode',
        'office_postalcode',
        'office_state', 
        'userid',
        'createdat',
        'firstname',
        'groupId',
        'group_name',
        boolean_to_string('deleted'),
        'phone',
        'culture',
        adapter.quote('position'),
        'email',
        'updatedat',
    ]) }} as _airbyte_user_groups_hashid,
    tmp.*
from {{ ref('user_groups_ab2') }} tmp
-- user_groups
where 1 = 1

