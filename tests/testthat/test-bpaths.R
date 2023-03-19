test_that("bpaths works as expected", {

  #Test 1: Check bpaths against manual computation from notebooks
  expect_equal(dpaths(c(3,3), c(2,2)) + bpaths(c(3,3), c(2,2)), 26)

  #Test 2: Check bpaths against manual computation from notebooks
  expect_equal(dpaths(c(3,3), c(2, 1)) + bpaths(c(3,3), c(2,1)), 25)

  #Test 3: Check bpaths against manual computation from notebooks
  #This also serves as an edge case test with bj == 0
  expect_equal(dpaths(c(3,3), c(2, 0)) + bpaths(c(3,3), c(2,0)), 20)

  #Test 4: Check that bpaths == tpaths when bi == 0
  expect_equal(bpaths(c(5,5), c(0, 3)), tpaths(c(5,5), c(0, 3)))

  #Test 5:The bi == i edge case does not throw an error
  expect_no_error(bpaths(c(5,5), c(5,4)))

  #Test 6:The bj == j edge case does not throw an error
  expect_no_error(bpaths(c(5,5), c(4,5)))

  #Test 7: Test that bi == i && bj == j does not throw an error and equals mpaths
  expect_no_error(bpaths(c(5,5), c(5,5)))
  expect_equal(bpaths(c(5,5), c(5, 5)), bpaths(c(5,5), c(5, 5)))
})
