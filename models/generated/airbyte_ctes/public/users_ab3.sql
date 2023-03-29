{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'mentionname',
        'lastname',
        'jobtitle',
        'mobile',
        object_to_string('office'),
        'userid',
        'createdat',
        'firstname',
        boolean_to_string('deleted'),
        'phone',
        object_to_string('links'),
        adapter.quote('position'),
        'email',
        'updatedat',
    ]) }} as _airbyte_users_hashid,
    tmp.*
from {{ ref('users_ab2') }} tmp
-- users
where 1 = 1

