<?php

namespace App\Http\Controllers;

use App\Models\Run;
use Illuminate\Http\Request;

class RunController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Run::all();
    }
    
    public function getAllRun()
    {
        $data = Run::get();
        return response()->json($data, 200);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        
    }
    public function createRun(Request $request,$user_id)
    {
        $run = new Run();
        $run->user_id = $user_id;
        $run->distance=$request->distance;
        $run->vitesse=$request->vitesse;
        $run->LatLng=$request->LatLng;
        $run->save();
        return response()->json($run, 201);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request,$user_id)
    {
        
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Run  $run
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        return Run::find($id);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Run  $run
     * @return \Illuminate\Http\Response
     */
    public function edit(Run $run)
    {
        //
    }
    public function runList($user_id)
    {
        $runs= Run::where('user_id',$user_id)->get();
        return $runs->toArray();

    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Run  $run
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Run $run)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Run  $run
     * @return \Illuminate\Http\Response
     */
    public function delete($id){
        $run= Run::findOrFail($id);
        $run->delete();
        return response(['message' => 'Quiz deleted Successfully'], 200);
    }
     public function destroy(Run $run)
    {
        //
    }
}
