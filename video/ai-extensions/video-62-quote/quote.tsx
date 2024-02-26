// pages/index.tsx
import { useState } from "react";
import Head from "next/head";
import Image from "next/image";

type Quote = {
  text: string;
  author: string;
};

const quotes: Quote[] = [
  {
    text: "Be yourself; everyone else is already taken.",
    author: "Oscar Wilde",
  },
  {
    text: "Two things are infinite: the universe and human stupidity; and I'm not sure about the universe.",
    author: "Albert Einstein",
  },
  { text: "So many books, so little time.", author: "Frank Zappa" },
  // Add more quotes as needed
];

const getRandomQuote = () => {
  const randomIndex = Math.floor(Math.random() * quotes.length);
  return quotes[randomIndex];
};

const Home: React.FC = () => {
  const [currentQuote, setCurrentQuote] = useState<Quote>(getRandomQuote());

  const handleNextQuote = () => {
    setCurrentQuote(getRandomQuote());
  };

  return (
    <div className="bg-gray-100 flex items-center justify-center h-screen">
      <Head>
        <title>Daily Quote App</title>
      </Head>
      <div className="max-w-lg mx-auto p-8 bg-white rounded-lg shadow-lg">
        <div className="mb-4">
          <Image
            src="https://source.unsplash.com/random/800x600"
            alt="Random Unsplash Image"
            width={800}
            height={600}
            className="object-cover rounded-lg"
          />
        </div>
        <div className="mb-4">
          <p className="text-lg text-gray-800">"{currentQuote.text}"</p>
        </div>
        <div className="mb-4">
          <p className="text-md text-gray-600">- {currentQuote.author}</p>
        </div>
        <div className="flex justify-center">
          <button
            className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-700 transition duration-300"
            onClick={handleNextQuote}
          >
            NEXT
          </button>
        </div>
      </div>
    </div>
  );
};

export default Home;
