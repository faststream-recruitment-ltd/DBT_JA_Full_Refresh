{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('deleted_jobs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'jobid',
        'deletedat',
    ]) }} as _airbyte_deleted_jobs_hashid,
    tmp.*
from {{ ref('deleted_jobs_ab2') }} tmp
-- deleted_jobs
where 1 = 1

