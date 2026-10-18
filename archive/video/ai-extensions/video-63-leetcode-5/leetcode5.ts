function longestPalindrome(s: string): string {
  if (s.length < 1) return "";
  let start = 0,
    end = 0;

  for (let i = 0; i < s.length; i++) {
    let len1 = expandAroundCenter(s, i, i);
    let len2 = expandAroundCenter(s, i, i + 1);
    let len = Math.max(len1, len2);
    if (len > end - start) {
      start = i - ((len - 1) >> 1);
      end = i + (len >> 1);
    }
  }

  return s.substring(start, end + 1);
}

function expandAroundCenter(s: string, left: number, right: number): number {
  while (left >= 0 && right < s.length && s[left] === s[right]) {
    left--;
    right++;
  }
  return right - left - 1;
}
