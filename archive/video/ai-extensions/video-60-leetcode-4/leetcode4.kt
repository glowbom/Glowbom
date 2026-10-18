class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        // Make sure nums1 is the smaller array
        let (nums1, nums2) = nums1.count <= nums2.count ? (nums1, nums2) : (nums2, nums1)
        let (m, n) = (nums1.count, nums2.count)
        var (imin, imax) = (0, m)
        let halfLen = (m + n + 1) / 2

        while imin <= imax {
            let i = (imin + imax) / 2
            let j = halfLen - i

            if i < m && nums2[j - 1] > nums1[i] {
                imin = i + 1
            } else if i > 0 && nums1[i - 1] > nums2[j] {
                imax = i - 1
            } else {
                // i is perfect
                let maxLeft: Int
                if i == 0 { maxLeft = nums2[j - 1] }
                else if j == 0 { maxLeft = nums1[i - 1] }
                else { maxLeft = max(nums1[i - 1], nums2[j - 1]) }

                if (m + n) % 2 == 1 { return Double(maxLeft) }

                let minRight: Int
                if i == m { minRight = nums2[j] }
                else if j == n { minRight = nums1[i] }
                else { minRight = min(nums1[i], nums2[j]) }

                return Double(maxLeft + minRight) / 2.0
            }
        }

        return 0.0 // Placeholder, execution should never reach here
    }
}
