<?php

namespace App\Http\Controllers;

use App\Models\ItemTask;
use Exception;
use Illuminate\Http\Request;

class ItemTaskController extends Controller
{
    //
    public function index()
    {
        $itemTask = ItemTask::with('taskList')->get();
        return response()->json(['message' => 'success', 'data' => $itemTask], 200);
    }
    public function store(Request $request)
    {
        try {
            //code...
            $data = $request->all();
            $itemTask = new ItemTask();
            $itemTask->title_item = $data['titleItem'];
            $itemTask->list_task_id = $data['listTaskId'];
            $itemTask->done_item = $data['doneItem'];
            $itemTask->save();
            return response()->json(['message' => 'success'], 200);
        } catch (Exception $e) {
            //throw $th;
            return response()->json(['message' => $e], 500);
        }
    }
}
