{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('deleted_companies_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'companyid',
        'deletedat',
    ]) }} as _airbyte_deleted_companies_hashid,
    tmp.*
from {{ ref('deleted_companies_ab2') }} tmp
-- deleted_companies
where 1 = 1

