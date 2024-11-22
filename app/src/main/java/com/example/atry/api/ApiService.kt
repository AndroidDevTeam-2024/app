package com.example.atry.api

import android.util.Log
import com.example.atry.api.NetworkManager.apiService
import com.example.atry.model.User
import retrofit2.Call
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Path

interface ApiService {

    data class LoginRequest(val name: String, val password: String)
    data class LoginResponse(val message: String, val success: Boolean)


    // 获取用户信息接口，传入用户 ID
    @POST("user/login")
    fun login(@Body loginRequest: LoginRequest): Response<LoginResponse> {
        Log.d("ApiService", "Requesting login with: $loginRequest")
        return try {
            val response = apiService.login(loginRequest)
            Log.d("ApiService", "Response: ${response.body()}")
            response
        } catch (e: Exception) {
            Log.e("ApiService", "Login failed", e)
            Response.success(LoginResponse("Error", false))  // Handle error response gracefully
        }
    }


    // 你可以根据需求继续添加其他接口，例如获取所有用户、创建用户等
    // @POST("users")
    // fun createUser(@Body user: User): Call<User>
}