<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class UserController extends Controller
{


    public function getAll()
    {
        $data = User::get();
        return response()->json($data, 200);
    }

    public function get($id){
        $data = User::find($id);
        return response()->json($data, 200);
      }

    public function delete($id)
    {
        $res = User::find($id)->delete();
        return response()->json([
            'message' => "Successfully deleted",
            'success' => true
        ], 200);
    }


    public function update(Request $request, $id)
    {
        $data['name'] = $request['name'];
        $data['email'] = $request['email'];
        User::find($id)->update($data);
        return response()->json([
            'message' => "Successfully updated",
            'success' => true
        ], 200);
    }
}
