
class Solution {
    fun isPalindrome(x: Int): Boolean {
        if (x < 0 || (x % 10 == 0 && x != 0)) {
            return false
        }
        
        var revertedNumber = 0
        var number = x
        while (number > revertedNumber) {
            revertedNumber = revertedNumber * 10 + number % 10
            number /= 10
        }
        
        return number == revertedNumber || number == revertedNumber / 10
    }
}
