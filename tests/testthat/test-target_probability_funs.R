test_that("ptpaths gives 1 when the target location equals the destination and
          when the target location is at the origin", {

            expect_equal(ptpaths(destination = c(5,5), target = c(5,5)), 1)
            expect_equal(ptpaths(destination = c(5,5), target = c(0,0)), 1)

})


test_that("ptpaths returns correct values and behaves as expected", {

  # Test 1: Test with target at origin (0, 0)
  expect_equal(ptpaths(destination = c(4, 4), target = c(0, 0)), 1)

  # Test 2: Test with target at destination
  expect_equal(ptpaths(destination = c(4, 4), target = c(4, 4)), 1)

  # Test 3: Test with a symmetric case
  expect_equal(ptpaths(destination = c(10,10), target = c(4,8)),
               ptpaths(destination = c(10,10), target = c(8,4)))

  # Test 4: Test with another symmetric case
  expect_equal(ptpaths(destination = c(20, 20), target = c(19,19)),
               ptpaths(destination = c(20, 20), target = c(1,1)))

  # Test 5: Test with q = 0
  expect_equal(ptpaths(destination = c(0, 0), target = c(0, 0)), 1)

  # Test 6: Test with invalid target (greater than destination)
  expect_error(ptpaths(destination = c(2, 2), target = c(3, 3)), "Target coordinate must be on grid")
})
