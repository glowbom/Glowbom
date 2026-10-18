
function isPalindrome(x: number): boolean {
  // This is where the AI-generated TypeScript code goes
  if (x < 0) return false;
  let reversed = 0, original = x;
  while (x > 0) {
    reversed = reversed * 10 + (x % 10);
    x = Math.floor(x / 10);
  }
  return original === reversed;
}
