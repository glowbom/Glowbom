package com.glowbom.custom

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

class AiExtensions {
    companion object {
        // Flag to enable or disable the GlowbyScreen
        var enabled = true

        // Title for the GlowbyScreen
        var title = "App"

        /**
         * Composable function that displays the GlowbyScreen when enabled is set to true.
         * The GlowbyScreen consists of a Tic-tac-toe game when enabled is true.
         *
         * @param modifier Modifier to be applied to the Box layout
         */
        @Composable
        fun GlowbyScreen(
            modifier: Modifier = Modifier
        ) {
            if (enabled) {
                // Tic-tac-toe game implementation...
                val boardSize = 3
                val board = remember { mutableStateOf(Array(boardSize) { Array(boardSize) { "" } }) }
                val currentPlayer = remember { mutableStateOf("X") }
                val winner = remember { mutableStateOf("") }

                // Check for a win condition
                fun checkWinner() {
                    // Check rows and columns
                    for (i in 0 until boardSize) {
                        if (board.value[i][0] != "" && board.value[i][0] == board.value[i][1] && board.value[i][0] == board.value[i][2]) {
                            winner.value = board.value[i][0]
                        }
                        if (board.value[0][i] != "" && board.value[0][i] == board.value[1][i] && board.value[0][i] == board.value[2][i]) {
                            winner.value = board.value[0][i]
                        }
                    }
                    // Check diagonals
                    if (board.value[0][0] != "" && board.value[0][0] == board.value[1][1] && board.value[0][0] == board.value[2][2]) {
                        winner.value = board.value[0][0]
                    }
                    if (board.value[2][0] != "" && board.value[2][0] == board.value[1][1] && board.value[2][0] == board.value[0][2]) {
                        winner.value = board.value[2][0]
                    }
                }

                Box(modifier = modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Column {
                        for (i in 0 until boardSize) {
                            Row {
                                for (j in 0 until boardSize) {
                                    Box(
                                        Modifier
                                            .clickable {
                                                if (board.value[i][j] == "" && winner.value == "") {
                                                    val newBoard = board.value.map { it.copyOf() }.toTypedArray() // Create a new copy of the board
                                                    newBoard[i][j] = currentPlayer.value // Update the new copy with the new value
                                                    board.value = newBoard // Assign the new copy to the board state
                                                    checkWinner()
                                                    currentPlayer.value = if (currentPlayer.value == "X") "O" else "X"
                                                }
                                            }
                                            .size(100.dp)  // Increase the size of the box
                                    ) {
                                        Surface(
                                            color = if (board.value[i][j] == "X") Color.Red else if (board.value[i][j] == "O") Color.Green else Color.Gray,
                                        ) {
                                            Text(
                                                text = board.value[i][j],
                                                color = Color.White,
                                                modifier = Modifier.padding(16.dp),
                                                style = TextStyle(fontSize = 24.sp, fontWeight = FontWeight.Bold)  // Increase the size of the text and make it bold
                                            )
                                        }
                                    }
                                }
                            }
                        }
                        Text(text = "Winner: ${winner.value}")
                    }
                }
            }
        }
    }
}
