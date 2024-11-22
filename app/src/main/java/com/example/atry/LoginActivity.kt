package com.example.atry

import android.net.http.HttpException
import android.os.Build
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.annotation.RequiresExtension
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.unit.dp
import androidx.compose.ui.tooling.preview.Preview
import com.example.atry.api.ApiService
import com.example.atry.api.NetworkManager
import kotlinx.coroutines.launch
import java.io.IOException

class LoginActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            LoginScreen()
        }
    }

    @RequiresExtension(extension = Build.VERSION_CODES.S, version = 7)
    @Composable
    fun LoginScreen() {
        val context = LocalContext.current
        val coroutineScope = rememberCoroutineScope()


        var name by rememberSaveable { mutableStateOf("") }
        var password by rememberSaveable { mutableStateOf("") }

        var isLoginSuccessful by remember { mutableStateOf(false) }
        var isSignUpSuccessful by remember { mutableStateOf(false) }

        // Handling success messages
        var loginMessage by remember { mutableStateOf("") }
        var signupMessage by remember { mutableStateOf("") }

        Column(
            modifier = Modifier
                .padding(16.dp)
                .fillMaxSize(),
            verticalArrangement = Arrangement.Center
        ) {
            // Username TextField
            TextField(
                value = name,
                onValueChange = { name = it },
                label = { Text("Username") },
                modifier = Modifier.fillMaxWidth()
            )
            Spacer(modifier = Modifier.height(8.dp))

            // Password TextField
            TextField(
                value = password,
                onValueChange = { password = it },
                label = { Text("Password") },
                visualTransformation = PasswordVisualTransformation(),
                modifier = Modifier.fillMaxWidth()
            )
            Spacer(modifier = Modifier.height(16.dp))

            // Login Button
            Button(
                onClick = {
                    if (name.isNotEmpty() && password.isNotEmpty()) {
                        coroutineScope.launch {
                            // Call the login API
                            val loginRequest = ApiService.LoginRequest(name, password)
                            val response = NetworkManager.apiService.login(loginRequest)

                            if (response.isSuccessful) {
                                loginMessage = "Login success"
                            } else {
                                loginMessage = "Login failed"
                            }
                        }
                    } else {
                        loginMessage = "Please enter username and password and email."
                    }
                },
                modifier = Modifier.fillMaxWidth()
            ) {
                Text("Login")
            }

            Spacer(modifier = Modifier.height(8.dp))

            // Signup Button
            Button(
                onClick = {
                    if (name.isNotEmpty() && password.isNotEmpty()) {
                        // Simulate a signup action
                        signupMessage = "Sign Up Successful"
                        isSignUpSuccessful = true
                    } else {
                        signupMessage = "Please fill all fields for signup."
                        isSignUpSuccessful = false
                    }
                },
                modifier = Modifier.fillMaxWidth()
            ) {
                Text("Sign Up")
            }

            Spacer(modifier = Modifier.height(16.dp))

            // Display login success message or error
            if (loginMessage.isNotEmpty()) {
                Text(
                    text = loginMessage,
                    style = MaterialTheme.typography.bodyLarge,
                    color = if (isLoginSuccessful) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.error
                )
            }

            // Display signup success message or error
            if (signupMessage.isNotEmpty()) {
                Text(
                    text = signupMessage,
                    style = MaterialTheme.typography.bodyLarge,
                    color = if (isSignUpSuccessful) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.error
                )
            }
        }
    }
}


