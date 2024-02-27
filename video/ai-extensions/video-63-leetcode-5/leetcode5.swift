class Solution {
    func longestPalindrome(_ s: String) -> String {
        if s.isEmpty { return "" }
        
        let characters = Array(s)
        var start = 0, end = 0
        
        for i in 0..<characters.count {
            let len1 = expandAroundCenter(characters, left: i, right: i)
            let len2 = expandAroundCenter(characters, left: i, right: i+1)
            let len = max(len1, len2)
            if len > end - start {
                start = i - (len - 1) / 2
                end = i + len / 2
            }
        }
        
        let range = start...end
        let longestPalindrome = range.map { String(characters[$0]) }.joined()
        
        return longestPalindrome
    }
    
    private func expandAroundCenter(_ chars: [Character], left: Int, right: Int) -> Int {
        var L = left, R = right
        while L >= 0 && R < chars.count && chars[L] == chars[R] {
            L -= 1
            R += 1
        }
        return R - L - 1
    }
}
