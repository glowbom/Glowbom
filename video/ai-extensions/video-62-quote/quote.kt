import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import kotlin.random.Random

data class Quote(val text: String, val author: String)

val quotes = listOf(
    Quote("Be yourself; everyone else is already taken.", "Oscar Wilde"),
    Quote("Two things are infinite: the universe and human stupidity; and I'm not sure about the universe.", "Albert Einstein"),
    Quote("So many books, so little time.", "Frank Zappa")
    // Add more quotes as needed
)

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MyApp {
                QuoteApp()
            }
        }
    }
}

@Composable
fun MyApp(content: @Composable () -> Unit) {
    MaterialTheme {
        Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colors.background) {
            content()
        }
    }
}

@Composable
fun QuoteApp() {
    var currentQuote by remember { mutableStateOf(quotes.random()) }

    Column(horizontalAlignment = Alignment.CenterHorizontally, modifier = Modifier.fillMaxSize().padding(16.dp)) {
        Text(text = "\"${currentQuote.text}\"", style = MaterialTheme.typography.h5, modifier = Modifier.padding(16.dp))
        Text(text = "- ${currentQuote.author}", style = MaterialTheme.typography.subtitle1, modifier = Modifier.padding(bottom = 32.dp))
        Button(onClick = {
            currentQuote = quotes.random()
        }) {
            Text("Next")
        }
    }
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    MyApp {
        QuoteApp()
    }
}
