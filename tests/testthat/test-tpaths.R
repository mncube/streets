test_that("tpaths gives same answer as mpaths when ti = i and tj = j", {
  expect_equal(tpaths(destination = c(4,4), target = c(4,4)),
               mpaths(c(4,4)))
})


test_that("tpaths throws an error when i < ti or j < tj", {
  expect_error(tpaths(destination = c(3,3), target = c(4,2)))
  expect_error(tpaths(destination = c(3,3), target = c(2,4)))
})
