package com.glowbom.custom

import androidx.compose.foundation.layout.*
import androidx.compose.material3.Card
import androidx.compose.material3.Divider
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp

class AiExtensions {
    companion object {
        // Flag to enable or disable the GlowbyScreen
        var enabled = true

        // Title for the GlowbyScreen
        var title = "Weather App"

        /**
         * Composable function that displays the GlowbyScreen when enabled is set to true.
         * The GlowbyScreen consists of the Current Weather Screen and the Weekly Forecast Screen.
         *
         * @param modifier Modifier to be applied to the Box layout
         */
        @Composable
        fun GlowbyScreen(
            modifier: Modifier = Modifier
        ) {
            if (enabled) {
                Column(
                    modifier = modifier
                        .fillMaxSize()
                        .padding(16.dp)
                ) {
                    CurrentWeatherScreen()
                    Divider(modifier = Modifier.padding(vertical = 16.dp))
                    WeeklyForecastScreen()
                }
            }
        }

        @Composable
        fun CurrentWeatherScreen() {
            Card(
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(
                    modifier = Modifier.padding(16.dp),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Text(text = "San Francisco", style = MaterialTheme.typography.headlineMedium)
                    Text(text = "🌤", style = MaterialTheme.typography.displayLarge, textAlign = TextAlign.Center)
                    Text(text = "72°", style = MaterialTheme.typography.displayMedium)
                    Text(text = "Sunny", style = MaterialTheme.typography.bodyMedium)
                }
            }
        }

        @Composable
        fun WeeklyForecastScreen() {
            Column {
                for (i in 0..6) {
                    ForecastCard()
                    Spacer(modifier = Modifier.height(8.dp))
                }
            }
        }

        @Composable
        fun ForecastCard() {
            Card(
                modifier = Modifier.fillMaxWidth()
            ) {
                Row(
                    modifier = Modifier.padding(16.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(text = "MON", style = MaterialTheme.typography.labelMedium)
                    Spacer(modifier = Modifier.weight(1f))
                    Text(text = "🌤", style = MaterialTheme.typography.displayMedium, textAlign = TextAlign.Center)
                    Spacer(modifier = Modifier.weight(1f))
                    Text(text = "68°/52°", style = MaterialTheme.typography.bodyMedium)
                }
            }
        }
    }
}
