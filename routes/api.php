<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
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
Route::middleware('auth:sanctum')-> get('/user',function  (Request $request) {
    return $request-> user();
})->middleware("cors");




Route::post('/sanctum/token', function (Request $request) {
    $request->validate([
        'email' => 'required|email',
        'password' => 'required',   
    ]);
 
    $user = User::where('email', $request->email)->first();
 
    if (! $user || ! Hash::check($request->password, $user->password)) {
        throw ValidationException::withMessages([
            'email' => ['The provided credentials are incorrect.'],
        ]);
    }
 
    return $user->createToken($request->email)->plainTextToken;
})->middleware("cors");

Route::middleware('auth:sanctum')->get('/user/revoke', function (Request $request) {

    $user = $request-> user();
    $user->tokens()->delete();
    return 'token are deleted';
})->middleware("cors");




Route::post('/auth/register', [AuthController::class, 'register'])->middleware("cors");
Route::get('/user-profile', [AuthController::class, 'login'])->middleware("cors");
Route::post('/logout', [AuthController::class, 'logout'])->middleware("cors");

Route::get('/allUser', [UserController::class, 'getAll'])->middleware('cors');
Route::delete('/{id}',[ UserController::class, 'delete']);
Route::put('/{id}',[ UserController::class, 'update']);



Route::prefix('user')->group(function () {
    Route::delete('/{id}',[ UserController::class, 'delete']);
    Route::get('/{id}',[ UserController::class, 'get']);
    Route::put('/{id}',[ UserController::class, 'update']);
});
