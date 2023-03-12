test_that("mpaths gives expected value for (5,5) grid", {
  #(5 + 5)!/(5!*5!)=(10*9*8*7*6)/(5*4*3*2*1)=2*3*2*7*3
  expect_equal(mpaths(5,5), 2*3*2*7*3)
})
