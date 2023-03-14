test_that("pftarg gives 1 when the target location equals the destination and
          when the target location is at the origin", {

            expect_equal(pftarg(destination = c(5,5), target = c(5,5)), 1)
            expect_equal(pftarg(destination = c(5,5), target = c(0,0)), 1)

})
