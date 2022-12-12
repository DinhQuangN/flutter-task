<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ItemTask extends Model
{
    use HasFactory;
    protected $table = 'item_tasks';
    protected $fillable = ['title_item', 'done_item', 'list_task_id'];
    protected function taskList()
    {
        return $this->belongsTo(ListTask::class);
    }
}
