/// AiExtensions.tsx
"use client";
import React, { useState } from "react";
import Image from "next/image";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";

const enabled = true;
const title = "Search Web App";

const GlowbyScreen: React.FC = () => {
  if (!enabled) return null;

  const [searchTerm, setSearchTerm] = useState("");

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    alert(`Searching for: ${searchTerm}`);
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-pink-100">
      <div className="w-full max-w-md mx-auto">
        <Card className="bg-white bg-opacity-80 p-8 rounded-lg shadow-lg">
          <form onSubmit={handleSearch} className="mb-6">
            <div className="relative">
              <Input
                type="text"
                placeholder="search search"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="w-full py-2 px-4 rounded-full border border-gray-300 focus:outline-none focus:ring-2 focus:ring-pink-300 transition duration-300"
              />
              <Button type="submit" variant="ghost" className="absolute right-2 top-1/2 transform -translate-y-1/2">
                <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
              </Button>
            </div>
          </form>
          <div className="flex flex-wrap gap-2 justify-center">
            <Button variant="outline" className="hover:bg-pink-100 text-gray-800 font-semibold rounded-full border border-gray-400 shadow transition duration-300 ease-in-out transform hover:scale-105">
              Search
            </Button>
            <Button variant="outline" className="hover:bg-pink-100 text-gray-800 font-semibold rounded-full border border-gray-400 shadow transition duration-300 ease-in-out transform hover:scale-105">
              Consult
            </Button>
            <Button variant="outline" className="hover:bg-pink-100 text-gray-800 font-semibold rounded-full border border-gray-400 shadow transition duration-300 ease-in-out transform hover:scale-105">
              Enjoy
            </Button>
            <Button variant="outline" className="hover:bg-pink-100 text-gray-800 font-semibold rounded-full border border-gray-400 shadow transition duration-300 ease-in-out transform hover:scale-105">
              Lucky
            </Button>
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="outline" className="hover:bg-pink-100 text-gray-800 font-semibold rounded-full border border-gray-400 shadow transition duration-300 ease-in-out transform hover:scale-105">
                  <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                  </svg>
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent>
                <DropdownMenuItem>Profile</DropdownMenuItem>
                <DropdownMenuItem>Settings</DropdownMenuItem>
                <DropdownMenuItem>Logout</DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </div>
        </Card>
      </div>
    </div>
  );
};

export default GlowbyScreen;
export { enabled, title };