function findMedianSortedArrays(nums1: number[], nums2: number[]): number {
  // Ensure nums1 is the smaller array
  if (nums1.length > nums2.length) [nums1, nums2] = [nums2, nums1];

  let m = nums1.length;
  let n = nums2.length;
  let imin = 0;
  let imax = m;
  let halfLen = Math.floor((m + n + 1) / 2);

  while (imin <= imax) {
    let i = Math.floor((imin + imax) / 2);
    let j = halfLen - i;

    if (i < m && nums2[j - 1] > nums1[i]) {
      // i is too small, must increase it
      imin = i + 1;
    } else if (i > 0 && nums1[i - 1] > nums2[j]) {
      // i is too big, must decrease it
      imax = i - 1;
    } else {
      // i is perfect
      let maxLeft = 0;
      if (i === 0) {
        maxLeft = nums2[j - 1];
      } else if (j === 0) {
        maxLeft = nums1[i - 1];
      } else {
        maxLeft = Math.max(nums1[i - 1], nums2[j - 1]);
      }
      if ((m + n) % 2 === 1) {
        return maxLeft;
      }

      let minRight = 0;
      if (i === m) {
        minRight = nums2[j];
      } else if (j === n) {
        minRight = nums1[i];
      } else {
        minRight = Math.min(nums2[j], nums1[i]);
      }

      return (maxLeft + minRight) / 2.0;
    }
  }

  return 0;
}
