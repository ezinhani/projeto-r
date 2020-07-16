<?php

namespace App\Models\Audit;

use Jenssegers\Mongodb\Eloquent\Model;
use OwenIt\Auditing\Audit;
use OwenIt\Auditing\Contracts\Audit as AuditableContract;

class MongoAudit extends Model implements AuditableContract
{
    use Audit;

    protected $connection = 'mongodb';

    protected $collection = 'audits';

    /**
     * Get the table associated with the model.
     *
     * @return string
     */
    public function getTable(): string
    {
        return $this->collection ?: parent::getTable();
    }

    /**
     * {@inheritdoc}
     */
    protected $guarded = [];

    /**
     * {@inheritdoc}
     */
    protected $casts = [
        'user_id' => 'string',
        'user_type' => 'string',
        'event' => 'string',
        'auditable_id' => 'string',
        'auditable_type' => 'string',
        'old_values' => 'json',
        'new_values' => 'json',
        'url' => 'string',
        'ip_address' => 'string',
        'user_agent' => 'string',
        'tags' => 'string',
    ];

    /**
     * {@inheritdoc}
     */
    public function auditable()
    {
        return $this->morphTo();
    }

    /**
     * {@inheritdoc}
     */
    public function user()
    {
        return $this->morphTo();
    }
}
