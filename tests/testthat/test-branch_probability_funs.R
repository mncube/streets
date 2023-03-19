test_that("dbpaths is working as expected", {
  #Test 1 dbpaths sums to 1 across all points on grid
  expect_equal(sum(dbpaths(c(2,2), c(0,0)),
                   dbpaths(c(2,2), c(0,1)),
                   dbpaths(c(2,2), c(1,0)),
                   dbpaths(c(2,2), c(1,1)),
                   dbpaths(c(2,2), c(1,2)),
                   dbpaths(c(2,2), c(2,1)),
                   dbpaths(c(2,2), c(2,2)),
                   dbpaths(c(2,2), c(0,2)),
                   dbpaths(c(2,2), c(2,0))), 1)

  #Test 2 dbpaths sums to 1 across all points on grid
  cumpaths <- 0
  for (x in 0:10){
    for (y in 0:10){
      cumpaths <- cumpaths + dbpaths(c(10,10), c(x,y))
    }
  }
  expect_equal(cumpaths, 1)
})
