
class Solution {
    fun convert(s: String, numRows: Int): String {
        if (numRows == 1) return s

        val rows = Array(minOf(numRows, s.length)) { StringBuilder() }
        var curRow = 0
        var goingDown = false

        for (c in s) {
            rows[curRow].append(c)
            if (curRow == 0 || curRow == numRows - 1) goingDown = !goingDown
            curRow += if (goingDown) 1 else -1
        }

        val result = StringBuilder()
        for (row in rows) result.append(row)
        return result.toString()
    }
}
