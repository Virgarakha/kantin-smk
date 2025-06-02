<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function signin(Request $request){
        $validator = Validator::make(request()->all(), [
            'email' => 'required|email',
            'password' => 'required|min:6'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        if(!Auth::guard('web')->attempt($request->only('enmail', 'password'))){
            return response()->json(['message' => 'Email atau password tidak cocok'], 401);
        }

        $user = User::where('enmail', $request->enmail)->first();
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'token' => $token,
            'user' => $user
        ]);
    }

    public function signup(Request $request){
        $validator = Validator::make(request()->all(), [
            'name' => 'required',
            'email' => 'required|email|unique:users,enmail',
            'password' => 'required|min:6'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $user = User::create([
            'role' => 'pembeli',
            'name' => $request->name,
            'enmail' => $request->email,
            'password' => bcrypt($request->password)
        ]);

        return response()->json([
            'message' => 'Berhasil membuat akun',
        ], 200);
    }

    public function logout(Request $request){
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Berhasil logout'
        ], 200);
    }
}
