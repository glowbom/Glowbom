 using System.Collections.Generic;
 using UnityEngine;
 using UnityEngine.UI;

 public class NameGenerator : MonoBehaviour
 {
     public InputField inputField;
     public Button generateButton;
     public Text resultText;

     private List<string> names = new List<string>
     {
         "Innova",
         "Creativio",
         "IdeaStorm",
         "Conceptualize",
         "Brainwave"
     };

     // Start is called before the first frame update
     void Start()
     {
         generateButton.onClick.AddListener(GenerateNames);
     }

     void GenerateNames()
     {
         resultText.text = ""; // Clear previous results
         foreach (var name in names)
         {
             resultText.text += name + "\n";
         }
     }
 }