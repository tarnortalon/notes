# http://www.capitalspectator.com/portfolio-analysis-in-r-a-6040-us-stockbond-portfolio/

# rebalancing analysis for 60/40 US stock/bond portfolio

# load packages
library(quantmod)
library(tseries)
library(PerformanceAnalytics)
library(magrittr)

# download prices
spy <- tseries::get.hist.quote(
  instrument="spy",start="2003-12-31",quote="AdjClose",compression="d"
)
class(spy)
agg <- tseries::get.hist.quote(
  instrument="agg",start="2003-12-31",quote="AdjClose",compression="d"
)

# choose asset weights
w = c(0.6,0.4) # 60% / 40%

# merge price histories into one dataset
# calculate 1-day % returns
# and label columns
portfolio.prices <- xts::as.xts(zoo::merge.zoo(spy,agg))
class(portfolio.prices)
portfolio.returns <- portfolio.prices %>%
  TTR::ROC(1, "discrete") %>%
  na.omit()
class(portfolio.returns)
colnames(portfolio.returns) <- c("spy","agg")

# calculate portfolio total returns
# rebalanced portfolio
portfolio.rebal <- portfolio.returns %>%
  PerformanceAnalytics::Return.portfolio(
    rebalance_on = "years", weights = w, wealth.index = TRUE, verbose = TRUE
  )
class(portfolio.rebal)
names(portfolio.rebal)

# buy and hold portfolio/no rebalancing
portfolio.bh <- portfolio.returns %>%
  PerformanceAnalytics::Return.portfolio(
    weights = w, wealth.index = TRUE, verbose = TRUE
  )
class(portfolio.bh)
names(portfolio.bh)

# merge portfolio returns into one dataset
# label columns
portfolios.2 <- cbind(portfolio.rebal$returns, portfolio.bh$returns)
class(portfolios.2)
colnames(portfolios.2) <-c("rebalanced", "buy and hold")

portfolios.2 %>%
  PerformanceAnalytics::chart.CumReturns(
    wealth.index=TRUE,
    legend.loc="bottomright",
    main="Growth of $1 investment",
    ylab="$"
  )

# Compare return/risk
PerformanceAnalytics::table.AnnualizedReturns(portfolios.2)

# buy and hold drawdowns
PerformanceAnalytics::table.Drawdowns((portfolio.bh$returns))
# rebal drawdowns
PerformanceAnalytics::table.Drawdowns((portfolio.rebal$returns))

# Compare portfolio return distribution vs. normal distribution
qqnorm(portfolio.rebal$returns,main="Rebalanced Portfolio")
qqline(portfolio.rebal$returns,col="red")

# Compare rolling 1-year returns
portfolios.2 %>%
  PerformanceAnalytics::chart.RollingPerformance(
    width=252, legend.loc="bottomright", main="Rolling 1yr % returns"
  )

AAPL <- tq_get("AAPL", get = "stock.prices", from = "2015-09-01", to = "2016-12-31")

AAPL %>%
  ggplot(aes(x = date, y = close)) +
  geom_candlestick(aes(open = open, high = high, low = low, close = close)) +
  geom_ma(ma_fun = SMA, n = 50, linetype = 5, size = 1.25) +
  geom_ma(ma_fun = SMA, n = 200, color = "red", size = 1.25) + 
  labs(title = "AAPL Candlestick Chart", 
       subtitle = "50 and 200-Day SMA", 
       y = "Closing Price", x = "") + 
  coord_x_date(xlim = c(end - weeks(24), end),
               ylim = c(100, 120)) + 
  theme_tq()

AAPL %>%
  ggplot(aes(x = date, y = close)) +
  geom_line() +
  labs(title = "AAPL Line Chart", y = "Closing Price", x = "") + 
  theme_tq()
