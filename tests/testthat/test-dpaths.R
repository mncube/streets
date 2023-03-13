test_that("dpaths gives 0 when ti = i and tj = j", {
  expect_equal(dpaths(destination = c(4,4), detour = c(4,4)),
               0)
})


test_that("dpaths throws an error when i < di or j < dj", {
  expect_error(dpaths(destination = c(3,3), detour = c(4,2)))
  expect_error(dpaths(destination = c(3,3), detour = c(2,4)))
})
