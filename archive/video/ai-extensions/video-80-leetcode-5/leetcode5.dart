
class Solution {
  String convert(String s, int numRows) {
    if (numRows == 1) return s;

    List<StringBuffer> rows = List<StringBuffer>.generate(
        numRows, (index) => StringBuffer());
    int currentRow = 0;
    bool goingDown = false;

    for (int i = 0; i < s.length; i++) {
      rows[currentRow].write(s[i]);
      if (currentRow == 0 || currentRow == numRows - 1) {
        goingDown = !goingDown;
      }
      currentRow += goingDown ? 1 : -1;
    }

    StringBuffer result = StringBuffer();
    for (StringBuffer row in rows) {
      result.write(row.toString());
    }

    return result.toString();
  }
}
