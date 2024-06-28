package com.glowbom.custom

import androidx.compose.animation.core.*
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class AiExtensions {
    companion object {
        var enabled = true
        var title = "Build Completed"

        @Composable
        fun GlowbyScreen(modifier: Modifier = Modifier) {
            if (enabled) {
                Box(modifier = modifier.fillMaxSize().background(Color.Black)) {
                    AnimatedBackground()
                    Column(
                        modifier = Modifier.fillMaxSize(),
                        verticalArrangement = Arrangement.Center,
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        Box(modifier = Modifier.size(360.dp)) {
                            Stars()
                            RocketLaunch()
                            BuildCompletedText()
                            Fireworks()
                        }
                    }
                }
            }
        }

        @Composable
        fun AnimatedBackground() {
            val colors = listOf(Color(0xFF9C27B0), Color(0xFFFFEB3B), Color(0xFFE91E63))
            val transition = rememberInfiniteTransition()
            val translateAnim = transition.animateFloat(
                initialValue = 0f,
                targetValue = 1000f,
                animationSpec = infiniteRepeatable(
                    animation = tween(durationMillis = 10000, easing = LinearEasing),
                    repeatMode = RepeatMode.Reverse
                )
            )
            colors.forEachIndexed { index, color ->
                Box(
                    Modifier
                        .offset(x = translateAnim.value.dp * (index + 1))
                        .size(300.dp)
                        .clip(CircleShape)
                        .background(color.copy(alpha = 0.3f))
                )
            }
        }

        @Composable
        fun Stars() {
            repeat(50) {
                val animatedAlpha by rememberInfiniteTransition().animateFloat(
                    initialValue = 0.2f,
                    targetValue = 1f,
                    animationSpec = infiniteRepeatable(
                        animation = tween(durationMillis = 1000),
                        repeatMode = RepeatMode.Reverse
                    )
                )
                Box(
                    Modifier
                        .size(2.dp)
                        .alpha(animatedAlpha)
                        .background(Color.White)
                        .offset(
                            x = (Math.random() * 360).dp,
                            y = (Math.random() * 360).dp
                        )
                )
            }
        }

        @Composable
        fun RocketLaunch() {
            var launched by remember { mutableStateOf(false) }
            val rocketOffset by animateFloatAsState(
                targetValue = if (launched) -1000f else 0f,
                animationSpec = tween(2000, easing = LinearEasing)
            )
            
            LaunchedEffect(Unit) {
                delay(1000)
                launched = true
            }

            Box(
                Modifier
                    .offset(y = rocketOffset.dp)
                    .size(100.dp)
            ) {
                Box(
                    Modifier
                        .size(50.dp, 80.dp)
                        .background(Color.White, CircleShape)
                        .align(Alignment.Center)
                )
                Box(
                    Modifier
                        .size(30.dp)
                        .background(Color.Red, CircleShape)
                        .align(Alignment.BottomCenter)
                )
            }
        }

        @Composable
        fun BuildCompletedText() {
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    "BUILD COMPLETED!",
                    style = MaterialTheme.typography.headlineMedium,
                    color = Color.White,
                    fontWeight = FontWeight.Bold
                )
                Text(
                    "Glowby",
                    style = MaterialTheme.typography.headlineLarge,
                    color = Color.White,
                    fontWeight = FontWeight.ExtraBold,
                    fontSize = 48.sp
                )
                Text(
                    "TOGETHER WE SHIPPED - BACKRODBUILD.COM",
                    style = MaterialTheme.typography.bodyLarge,
                    color = Color.LightGray
                )
            }
        }

        @Composable
        fun Fireworks() {
            val fireworks = remember { mutableStateListOf<FireworkParticle>() }
            val coroutineScope = rememberCoroutineScope()

            LaunchedEffect(Unit) {
                while (true) {
                    delay(2000)
                    coroutineScope.launch {
                        repeat(20) {
                            fireworks.add(
                                FireworkParticle(
                                    x = (Math.random() * 360).toFloat(),
                                    y = (Math.random() * 360).toFloat(),
                                    color = Color(
                                        (Math.random() * 255).toInt(),
                                        (Math.random() * 255).toInt(),
                                        (Math.random() * 255).toInt()
                                    )
                                )
                            )
                        }
                    }
                }
            }

            fireworks.forEach { particle ->
                Box(
                    Modifier
                        .size(4.dp)
                        .background(particle.color)
                        .offset(x = particle.x.dp, y = particle.y.dp)
                )
            }
        }
    }
}

data class FireworkParticle(val x: Float, val y: Float, val color: Color)