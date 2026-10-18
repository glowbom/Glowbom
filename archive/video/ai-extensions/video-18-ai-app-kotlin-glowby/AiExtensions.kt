package com.glowbom.custom

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL

class AiExtensions {
    companion object {
        // Flag to enable or disable the GlowbyScreen
        var enabled = true

        // Title for the GlowbyScreen
        var title = "InspirARTion"


        /**
         * Composable function that displays the AI Art generation screen when enabled is set to true.
         * It allows users to input a phrase and generates art based on that phrase.
         *
         * @param modifier Modifier to be applied to the Box layout
         */
        @Composable
        fun GlowbyScreen(
            modifier: Modifier = Modifier
        ) {
            var inputText by remember { mutableStateOf("") }
            var apiKey by remember { mutableStateOf("") }
            var imageBitmap by remember { mutableStateOf<Bitmap?>(null) }
            var isLoading by remember { mutableStateOf(false) }

            Column(
                modifier = modifier.fillMaxSize(),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                BasicTextField(
                    value = apiKey,
                    onValueChange = { apiKey = it },
                    singleLine = true,
                    visualTransformation = PasswordVisualTransformation(),
                    keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Password),
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp),
                    decorationBox = { innerTextField ->
                        if (apiKey.isEmpty()) {
                            Text("Enter your OpenAI API Key here")
                        }
                        innerTextField()
                    }
                )

                BasicTextField(
                    value = inputText,
                    onValueChange = { inputText = it },
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp),
                    decorationBox = { innerTextField ->
                        if (inputText.isEmpty()) {
                            Text("Enter your inspirational phrase here")
                        }
                        innerTextField()
                    }
                )

                // Inside the Composable function
                val coroutineScope = rememberCoroutineScope() // Remember a CoroutineScope tied to the Composable's lifecycle

                Button(
                    onClick = {
                        coroutineScope.launch {
                            isLoading = true
                            imageBitmap = fetchArt(apiKey, inputText)
                            isLoading = false
                        }
                    },
                    modifier = Modifier.padding(16.dp)
                ) {
                    Text(if (isLoading) "Generating..." else "Generate Art")
                }


                imageBitmap?.let { bitmap ->
                    Image(
                        bitmap = bitmap.asImageBitmap(),
                        contentDescription = "Generated Art",
                        modifier = Modifier
                            .height(300.dp)
                            .fillMaxWidth()
                            .align(Alignment.CenterHorizontally)
                    )
                }
            }
        }

        // Placeholder function to simulate fetching art from an API
        private suspend fun fetchArt(apiKey: String, inputPhrase: String): Bitmap? {
            if (apiKey.isBlank() || inputPhrase.isBlank()) {
                // Handle case where API key or input phrase is not provided
                return null
            }

            // Endpoint for DALL-E 3 API
            val apiUrl = URL("https://api.openai.com/v1/images/generations")

            // Create the JSON payload with the prompt
            val jsonPayload = JSONObject()
            jsonPayload.put("prompt", inputPhrase)
            jsonPayload.put("n", 1)
            jsonPayload.put("model", "dall-e-3") // Use DALL-E 3 model

            return withContext(Dispatchers.IO) {
                try {
                    val connection = apiUrl.openConnection() as HttpURLConnection
                    connection.requestMethod = "POST"
                    connection.setRequestProperty("Content-Type", "application/json")
                    connection.setRequestProperty("Authorization", "Bearer $apiKey")
                    connection.doOutput = true

                    // Send the POST request
                    connection.outputStream.use { os ->
                        os.write(jsonPayload.toString().toByteArray())
                    }

                    // Check the response code and proceed accordingly
                    if (connection.responseCode == HttpURLConnection.HTTP_OK) {
                        // Read the response to get the URL of the generated image
                        val jsonResponse = JSONObject(connection.inputStream.bufferedReader().use { it.readText() })
                        val imageUrls = jsonResponse.getJSONArray("data").getJSONObject(0).getString("url")

                        // Fetch the image from the provided URL
                        val imageUrl = URL(imageUrls)
                        val imageConnection = imageUrl.openConnection() as HttpURLConnection
                        imageConnection.connect()
                        val imageStream = imageConnection.inputStream
                        val generatedBitmap = BitmapFactory.decodeStream(imageStream)
                        imageStream.close()
                        imageConnection.disconnect()

                        generatedBitmap  // Placeholder for the Bitmap you will return
                    } else {
                        // Handle errors as needed
                        null
                    }
                } catch (e: Exception) {
                    // Handle exceptions as needed
                    null
                }
            }
        }
    }
}