{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('job_boards_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'reference',
        adapter.quote('name'),
        'boardid',
        object_to_string('links'),
    ]) }} as _airbyte_job_boards_hashid,
    tmp.*
from {{ ref('job_boards_ab2') }} tmp
-- job_boards
where 1 = 1

