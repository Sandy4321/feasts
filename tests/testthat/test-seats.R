context("test-seats")

skip_if(!is.null(safely(seasonal::checkX13)(fail = TRUE)$error))
skip_if(!.Platform$OS.type == "windows" && Sys.info()["sysname"] != "Linux")

tsbl_co2 <- as_tsibble(co2)
test_that("Bad inputs for seats decomposition", {
  expect_warning(
    tsibble::pedestrian %>%
      filter(Sensor == "Southern Cross Station",
             Date == as.Date("2015-01-01")) %>%
      model(feasts:::SEATS(Count)),
    "The X-13ARIMA-SEATS method only supports seasonal patterns"
  )

  expect_warning(
    tsbl_co2 %>%
      model(feasts:::SEATS(value ~ seq_along(value))),
    "Exogenous regressors are not supported for X-13ARIMA-SEATS decompositions"
  )

  expect_warning(
    tsbl_co2 %>%
      model(feasts:::SEATS(value, x11="")),
    "Use \\`X11\\(\\)\\` to perform an X11 decomposition"
  )
})

test_that("X-13ARIMA-SEATS decomposition", {
  dcmp <- tsbl_co2 %>% model(feasts:::SEATS(value)) %>% components()
  seas_dcmp <- seasonal::seas(co2)

  expect_equivalent(
    dcmp$trend,
    unclass(seas_dcmp$data[,"trend"])
  )
  expect_equivalent(
    dcmp$seasonal,
    unclass(seas_dcmp$data[,"adjustfac"])
  )
  expect_equivalent(
    dcmp$irregular,
    unclass(seas_dcmp$data[,"irregular"])
  )
  expect_equal(
    dcmp$value / dcmp$seasonal,
    dcmp$season_adjust
  )
})
