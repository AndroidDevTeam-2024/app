package com.example.atry.api

import com.example.atry.api.ApiService
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object NetworkManager {

    // 定义后端 API 的基础 URL
    private const val BASE_URL = "http://127.0.0.1:3000"

    // 使用 lazy 初始化 Retrofit，确保只有一个实例
    private val retrofit: Retrofit by lazy {
        Retrofit.Builder()
            .baseUrl(BASE_URL)  // 设置基础 URL
            .addConverterFactory(GsonConverterFactory.create())  // 添加 Gson 转换器，用于解析 JSON 数据
            .build()
    }

    // 获取 ApiService 实例
    val apiService: ApiService by lazy {
        retrofit.create(ApiService::class.java)  // 创建 ApiService 的实现
    }
}