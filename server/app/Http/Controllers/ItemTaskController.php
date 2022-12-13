<?php

namespace App\Http\Controllers;

use App\Models\ItemTask;
use App\Models\ListTask;
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
            $titleItemName = ItemTask::where('title_item', $request->titleItem)->first();
            if ($titleItemName) {
                return response()->json(['message' => 'Title Name already exist'], 400);
            }
            ItemTask::create([
                'title_item' => $request->titleItem,
                'list_task_id' => $request->listTaskId,
                'done_item' => $request->doneItem,
            ]);
            $ListTaskId = ListTask::with('listItem')->where('id', $request->listTaskId)->get();
            // $data = ItemTask::where('list_task_id', '=', ListTask->id)->get();
            return response()->json(['message' => 'success', 'data' => $ListTaskId], 200);
        } catch (Exception $e) {
            //throw $th;
            return response()->json(['message' => $e], 500);
        }
    }
}
