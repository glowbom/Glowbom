// AiExtensions.tsx
"use client";
import React, { useState } from "react";
import Image from "next/image";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";

const enabled = true;
const title = "Daily Challenge App";

const challenges = [
  "Write a letter to your future self.",
  "Take a walk and photograph something interesting.",
  "Learn to cook a new recipe.",
  "Read a chapter of a book you've been putting off.",
  "Do a random act of kindness.",
  "Practice meditation for 10 minutes.",
  "Declutter your workspace.",
];

const GlowbyScreen: React.FC = () => {
  const [challenge, setChallenge] = useState(
    "Click the button to see today's challenge!"
  );
  const [imageSrc, setImageSrc] = useState(
    "https://source.unsplash.com/random/600x400"
  );

  const getRandomChallenge = () => {
    const randomChallenge =
      challenges[Math.floor(Math.random() * challenges.length)];
    setChallenge(randomChallenge);
    setImageSrc(
      `https://source.unsplash.com/random/600x400?sig=${Math.random()}`
    );
  };

  if (!enabled) return null;

  return (
    <div className="flex flex-col items-center justify-center min-h-screen">
      <Card className="mb-4">
        <Image
          src={imageSrc}
          alt="Daily Challenge"
          width={600}
          height={400}
          className="rounded-lg"
        />
      </Card>
      <Card className="mb-6 p-4 bg-white rounded shadow-lg">
        <p className="text-lg font-semibold">{challenge}</p>
      </Card>
      <Button
        onClick={getRandomChallenge}
        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
      >
        Challenge
      </Button>
    </div>
  );
};

export default GlowbyScreen;
export { enabled, title };
