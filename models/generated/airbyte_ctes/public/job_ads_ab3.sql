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
        'owner_userId',
        'owner_lastName',
        'owner_firstName',
        'owner_deleted',
        'summary',
        'postat',
        'description',
        'title',
        'expireat',
        'jobBoard_name',
        'boardId',
        'reference',
        'createdat',
        'adid',
        'createdBy_email',
        'createdBy_userId',
        'createdBy_lastName',
        'createdBy_firstName',
        'createdBy_deleted',
        'contact_email',
        'contact_lastName',
        'contactId',
        'contact_firstName',
        'company_name',
        'companyId',
        adapter.quote('state'),
        'jobId',
        'job_source',
        'job_jobTitle',
        'job_status_name',
        'jobs_status_active',
        'jobs_status_statusId',
    ]) }} as _airbyte_job_ads_hashid,
    tmp.*
from {{ ref('job_ads_ab2') }} tmp
-- job_ads
where 1 = 1

