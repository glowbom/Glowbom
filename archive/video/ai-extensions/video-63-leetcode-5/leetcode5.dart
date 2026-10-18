class Solution {
  String longestPalindrome(String s) {
    if (s.isEmpty) {
      return "";
    }

    int start = 0;
    int end = 0;

    for (int i = 0; i < s.length; i++) {
      int len1 = _expandAroundCenter(s, i, i);
      int len2 = _expandAroundCenter(s, i, i + 1);
      int len = len1 > len2 ? len1 : len2;

      if (len > end - start) {
        start = i - ((len - 1) >> 1);
        end = i + (len >> 1);
      }
    }

    return s.substring(start, end + 1);
  }

  int _expandAroundCenter(String s, int left, int right) {
    while (left >= 0 && right < s.length && s[left] == s[right]) {
      left--;
      right++;
    }
    return right - left - 1;
  }
}
