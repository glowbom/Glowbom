class Solution {
  double findMedianSortedArrays(List<int> nums1, List<int> nums2) {
    // Make sure nums1 is the smaller array to ensure the binary search takes O(log(min(m,n))) time.
    if (nums1.length > nums2.length) {
      final temp = nums1;
      nums1 = nums2;
      nums2 = temp;
    }

    int m = nums1.length;
    int n = nums2.length;
    int imin = 0;
    int imax = m;
    int halfLen = (m + n + 1) ~/ 2;

    while (imin <= imax) {
      int i = (imin + imax) ~/ 2;
      int j = halfLen - i;

      if (i < m && nums2[j - 1] > nums1[i]) {
        imin = i + 1; // i is too small
      } else if (i > 0 && nums1[i - 1] > nums2[j]) {
        imax = i - 1; // i is too large
      } else {
        // i is perfect
        int maxLeft = 0;
        if (i == 0) {
          maxLeft = nums2[j - 1];
        } else if (j == 0) {
          maxLeft = nums1[i - 1];
        } else {
          maxLeft = nums1[i - 1] > nums2[j - 1] ? nums1[i - 1] : nums2[j - 1];
        }
        if ((m + n) % 2 == 1) {
          return maxLeft.toDouble();
        }

        int minRight = 0;
        if (i == m) {
          minRight = nums2[j];
        } else if (j == n) {
          minRight = nums1[i];
        } else {
          minRight = nums1[i] < nums2[j] ? nums1[i] : nums2[j];
        }

        return (maxLeft + minRight) / 2.0;
      }
    }

    throw Exception('No median found'); // This should never happen
  }
}
