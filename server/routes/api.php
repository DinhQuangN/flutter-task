<?php

use App\Http\Controllers\ItemTaskController;
use App\Http\Controllers\ListTaskController;
use App\Models\ItemTask;
use App\Models\ListTask;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('/getList', [ListTaskController::class, 'index']);
Route::post('/createList', [ListTaskController::class, 'store']);
Route::post('/createItem', [ItemTaskController::class, 'store']);
Route::post('updateItem/{id}', [ItemTaskController::class, 'updateItem']);
Route::get('deleteList/{id}', [ListTaskController::class, 'delete']);
Route::get('deleteItem/{id}', [ItemTaskController::class, 'delete']);
