<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ListTask extends Model
{
    use HasFactory;
    protected $table = 'list_tasks';
    protected $fillable = ['title_task', 'icon_task', 'color_task'];
    public function listItem()
    {
        return $this->hasMany(ItemTask::class, 'list_task_id', 'id');
    }
}
