test_that("ddpaths returns correct values and behaves as expected", {

  #Test 1 ddpaths sums to 1 across all points on grid
  expect_equal(sum(ddpaths(c(2,2), c(0,0)),
                   ddpaths(c(2,2), c(0,1)),
                   ddpaths(c(2,2), c(1,0)),
                   ddpaths(c(2,2), c(1,1)),
                   ddpaths(c(2,2), c(1,2)),
                   ddpaths(c(2,2), c(2,1)),
                   ddpaths(c(2,2), c(2,2)),
                   ddpaths(c(2,2), c(0,2)),
                   ddpaths(c(2,2), c(2,0))), 1)

  #Test 2 ddpaths sums to 1 across all points on grid
  cumpaths <- 0
  for (x in 0:10){
    for (y in 0:10){
      cumpaths <- cumpaths + ddpaths(c(10,10), c(x,y))
    }
  }
  expect_equal(cumpaths, 1)

  #Test 3 ddpaths equals 0 when detour is at origin
  expect_equal(ddpaths(c(5,5), c(0,0)), 0)

  #Test 4 ddpaths equals 0 when detour is at destination
  expect_equal(ddpaths(c(5,5), c(5,5)), 0)

  #Test 5 ddpaths is symmetric
  expect_equal(ddpaths(c(100,100), c(63,29)), ddpaths(c(100,100), c(29,63)))

})
