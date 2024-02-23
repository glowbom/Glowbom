import { useState, useEffect } from "react";
import Image from "next/image";
import styles from "../styles/Home.module.css"; // or your custom CSS module

export default function Home() {
  const [background, setBackground] = useState("");
  const [names, setNames] = useState([]);

  // Function to fetch images from Unsplash and update the background
  useEffect(() => {
    async function updateBackground() {
      const response = await fetch(
        "https://api.unsplash.com/photos/random?client_id=YOUR_UNSPLASH_ACCESS_KEY&query=inspiration"
      );
      const data = await response.json();
      setBackground(data.urls.regular);
    }

    updateBackground();
  }, []);

  // Function to generate names (placeholder function)
  function generateNames() {
    const ideas = [
      "Innova",
      "Creativio",
      "IdeaStorm",
      "Conceptualize",
      "Brainwave",
    ];
    setNames(ideas);
  }

  return (
    <div
      className={styles.container}
      style={{ backgroundImage: `url(${background})` }}
    >
      <div className={styles.card}>
        <h1 className={styles.title}>Name Generator App</h1>
        <input
          type="text"
          id="ideaInput"
          placeholder="Enter idea"
          className={styles.input}
        />
        <button onClick={generateNames} className={styles.button}>
          Generate
        </button>
        <ul className={styles.nameList}>
          {names.map((name, index) => (
            <li key={index} className={styles.nameItem}>
              {name}
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}
