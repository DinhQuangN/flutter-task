<?php

namespace App\Http\Controllers;

use App\Models\ListTask;
use Exception;
use Illuminate\Http\Request;

class ListTaskController extends Controller
{
    //
    public function index()
    {
        $data = ListTask::with('listItem')->get();
        return response()->json($data);
    }
    public function store(Request $request)
    {
        try {
            $data = $request->all();
            $listTask = new ListTask();
            $listTask->title_task = $data['titleTask'];
            $listTask->icon_task = $data['iconTask'];
            $listTask->color_task = $data['colorTask'];
            $listTask->save();
            return response()->json(['message' => 'success'], 200);
        } catch (Exception $e) {
            return response()->json(['message' => $e], 500);
        }
    }
    public function delete($id)
    {
        try {
            $delete = ListTask::findOrFail($id);
            $delete->delete();
            return response()->json(['message' => 'success'], 200);
        } catch (Exception $e) {
            return response()->json(['message' => $e], 500);
        }
    }
}
