 import android.os.Bundle
 import androidx.activity.ComponentActivity
 import androidx.activity.compose.setContent
 import androidx.compose.foundation.layout.Column
 import androidx.compose.foundation.layout.fillMaxSize
 import androidx.compose.foundation.layout.padding
 import androidx.compose.foundation.text.BasicTextField
 import androidx.compose.material.Button
 import androidx.compose.material.Text
 import androidx.compose.runtime.*
 import androidx.compose.ui.Modifier
 import androidx.compose.ui.graphics.Color
 import androidx.compose.ui.text.input.TextFieldValue
 import androidx.compose.ui.unit.dp

 class MainActivity : ComponentActivity() {
     override fun onCreate(savedInstanceState: Bundle?) {
         super.onCreate(savedInstanceState)
         setContent {
             NameGeneratorApp()
         }
     }
 }

 @Composable
 fun NameGeneratorApp() {
     var textState by remember { mutableStateOf(TextFieldValue()) }
     val names = listOf("Innova", "Creativio", "IdeaStorm", "Conceptualize", "Brainwave")
     var generatedNames by remember { mutableStateOf(listOf<String>()) }

     Column(modifier = Modifier.fillMaxSize().padding(16.dp)) {
         BasicTextField(
             value = textState,
             onValueChange = { textState = it },
             modifier = Modifier.padding(16.dp)
         )
         Button(
             onClick = {
                 generatedNames = names.shuffled().take(5)
             },
             modifier = Modifier.padding(16.dp)
         ) {
             Text("Generate")
         }
         Column {
             generatedNames.forEach { name ->
                 Text(name)
             }
         }
     }
 }