{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('job_ads_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string(adapter.quote('owner')),
        'summary',
        'postat',
        'description',
        'title',
        'expireat',
        array_to_string('jobboards'),
        'reference',
        'createdat',
        'adid',
        object_to_string('createdby'),
        object_to_string('contact'),
        array_to_string('bulletpoints'),
        object_to_string('links'),
        object_to_string('company'),
        adapter.quote('state'),
        object_to_string('job'),
        array_to_string('otherapplyurls'),
    ]) }} as _airbyte_job_ads_hashid,
    tmp.*
from {{ ref('job_ads_ab2') }} tmp
-- job_ads
where 1 = 1

