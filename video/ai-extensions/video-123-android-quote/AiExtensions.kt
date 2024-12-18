
package com.glowbom.custom

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontStyle
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import coil.compose.rememberAsyncImagePainter
import kotlin.random.Random
import java.util.UUID

class AiExtensions {
    companion object {
        // Flag to enable or disable the GlowbyScreen
        var enabled = true

        // Title for the GlowbyScreen
        var title = "App"

        // Feel free to use image loading library coil
        // and ktor for network requests
        // build the UI using material3

        /**
         * Composable function that displays the GlowbyScreen when enabled is set to true.
         * The GlowbyScreen consists of an image "glowby" which is displayed in the center of the screen.
         *
         * @param modifier Modifier to be applied to the Box layout
         */
        @Composable
        fun GlowbyScreen(
            modifier: Modifier = Modifier
        ) {
            if (enabled) {
                Box(
                    modifier = modifier
                        .fillMaxSize()
                ) {
                    // Replace this with the generated Kotlin Jetpack Compose view
                    // Ensure the generated content shows up in the center of the screen
                    // within a frame with a maximum width of 360.0.
                    QuoteCard()
                }
            }
        }

        @Composable
        fun QuoteCard(modifier: Modifier = Modifier) {
            val quotes = remember {
                mutableStateOf(
                    listOf(
                        Quote("The best way to predict the future is to create it.", "- Peter Drucker"),
                        Quote("The mind is everything. What you think you become.", "- Buddha"),
                        Quote("Life is what happens when you're busy making other plans.", "- John Lennon"),
                        Quote("Be the change that you wish to see in the world.", "- Mahatma Gandhi"),
                        Quote("Strive not to be a success, but rather to be of value.", "- Albert Einstein"),
                        Quote("It always seems impossible until it's done.", "- Nelson Mandela"),
                        Quote("The only limit to our realization of tomorrow will be our doubts of today.", "- Franklin D. Roosevelt"),
                        Quote("Do what you can, with what you have, where you are.", "- Theodore Roosevelt"),
                        Quote("Your time is limited, don't waste it living someone else's life.", "- Steve Jobs"),
                        Quote("Believe you can and you're halfway there.", "- Theodore Roosevelt")
                    )
                )
            }
            val currentQuote = remember { mutableStateOf(quotes.value.random()) }
            val backgroundImage = remember { mutableStateOf("https://picsum.photos/1920/1080?random=${UUID.randomUUID()}") }


            Box(modifier = Modifier.fillMaxSize()) {
                Image(
                    painter = rememberAsyncImagePainter(backgroundImage.value),
                    contentDescription = null,
                    modifier = Modifier.fillMaxSize(),
                    contentScale = ContentScale.Crop
                )

                Card(
                    modifier = Modifier
                        .align(Alignment.Center)
                        .wrapContentSize()
                        .padding(16.dp),
                    colors = CardDefaults.cardColors(
                        containerColor = Color.White.copy(alpha = 0.9f)
                    ),
                ) {
                    Column(
                        modifier = Modifier
                            .padding(16.dp)
                    ) {
                        Text(
                            text = "Quote of the Day",
                            style = MaterialTheme.typography.headlineSmall,
                            color = Color.Gray,
                            modifier = Modifier.align(Alignment.CenterHorizontally),
                             textAlign = TextAlign.Center,
                             
                        )

                        Text(
                            text = "\"${currentQuote.value.text}\"",
                            style = MaterialTheme.typography.bodyLarge,
                            fontStyle = FontStyle.Italic,
                            modifier = Modifier
                                .padding(top = 16.dp)
                                .align(Alignment.CenterHorizontally),
                                  textAlign = TextAlign.Center,
                            color = Color.DarkGray,
                            lineHeight = 30.sp
                        )
                        Text(
                            text = currentQuote.value.author,
                            style = MaterialTheme.typography.bodyMedium,
                            modifier = Modifier
                                .padding(top = 8.dp)
                                .align(Alignment.CenterHorizontally),
                                 textAlign = TextAlign.Center,
                            color = Color.Gray

                        )

                        Button(
                            onClick = {
                                currentQuote.value = quotes.value.random()
                                backgroundImage.value = "https://picsum.photos/1920/1080?random=${UUID.randomUUID()}"
                            },
                            modifier = Modifier
                                .padding(top = 16.dp)
                                .align(Alignment.CenterHorizontally)
                        ) {
                            Text(text = "New Quote")
                        }

                    }
                }
            }
        }


    }
}

data class Quote(val text: String, val author: String)

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    MaterialTheme {
        AiExtensions.GlowbyScreen()
    }
}
