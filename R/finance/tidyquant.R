# https://business-science.github.io/tidyquant/articles/TQ00-introduction-to-tidyquant.html

library(tidyverse)
library(tidyquant)

?tq_index
tq_index_options()
tq_index("DOW")
tq_index("SP500")

?tq_exchange
tq_exchange_options()
tq_exchange("NASDAQ")

?tq_get
tq_get_options()
tq_get("PLTR")

?tq_transmute
?periodReturn
tq_get("PLTR") %>%
  tq_mutate(
    select = adjusted,
    mutate_fun = periodReturn,
    period = "daily",
    col_rename = "daily.adjusted.returns"
  )
tq_mutate_fun_options()

?tq_performance
tq_performance_fun_options()
data(FANG)
FANG
FANG %>% count(symbol)
FANG <- c("FB", "AMZN", "NFLX" , "GOOG") %>%
  tq_get(
    get = "stock.prices",
    from = "2012-12-01",
    to = "2021-05-31"
  )
Ra <- FANG %>%
  group_by(symbol) %>%
  tq_transmute(
    select = adjusted,
    mutate_fun = periodReturn,
    period = "monthly",
    col_rename = "Ra"
  )
Ra
Ra %>% count(symbol)

# Get returns for SP500 as baseline
Rb <- "^GSPC" %>%
  tq_get(get  = "stock.prices",
         from = "2012-12-01",
         to = "2021-05-31") %>%
  tq_transmute(adjusted, periodReturn, period = "monthly", col_rename = "Rb")
Rb
# Merge stock returns with baseline
RaRb <- left_join(Ra, Rb, by = c("date" = "date"))
RaRb

# Get performance metrics
RaRb %>%
  tq_performance(Ra = Ra, performance_fun = SharpeRatio, p = 0.95)
?SharpeRatio
RaRb %>%
  tq_performance(Ra = Ra, Rb = Rb, performance_fun = table.CAPM)

FANG_annual_returns <- FANG %>%
  group_by(symbol) %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = periodReturn, 
               period     = "yearly", 
               type       = "arithmetic")
FANG_annual_returns
FANG_annual_returns %>%
  filter(symbol == "GOOG") %>%
  print(n = 50)

FANG_annual_returns %>%
  ggplot(aes(x = date, y = yearly.returns, fill = symbol)) +
  geom_col() +
  geom_hline(yintercept = 0, color = palette_light()[[1]]) +
  scale_y_continuous(labels = scales::percent) +
  labs(title = "FANG: Annual Returns",
       subtitle = "Get annual returns quickly with tq_transmute!",
       y = "Annual Returns", x = "") + 
  facet_wrap(~ symbol, ncol = 2, scales = "free_y") +
  theme_tq() + 
  scale_fill_tq()

FANG_daily_log_returns <- FANG %>%
  group_by(symbol) %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = periodReturn, 
               period     = "daily", 
               type       = "log",
               col_rename = "monthly.returns")
FANG_daily_log_returns

FANG_daily_log_returns %>%
  ggplot(aes(x = monthly.returns, fill = symbol)) +
  geom_density(alpha = 0.5) +
  labs(title = "FANG: Charting the Daily Log Returns",
       x = "Monthly Returns", y = "Density") +
  theme_tq() +
  scale_fill_tq() + 
  facet_wrap(~ symbol, ncol = 2)

FANG %>%
  group_by(symbol) %>%
  tq_transmute(select     = open:volume, 
               mutate_fun = to.period, 
               period     = "weeks")

FANG_daily <- FANG %>%
  group_by(symbol)

FANG_daily %>%
  ggplot(aes(x = date, y = adjusted, color = symbol)) +
  geom_line(size = 1) +
  labs(title = "Daily Stock Prices",
       x = "", y = "Adjusted Prices", color = "") +
  facet_wrap(~ symbol, ncol = 2, scales = "free_y") +
  scale_y_continuous(labels = scales::dollar) +
  theme_tq() + 
  scale_color_tq()

FANG_monthly <- FANG %>%
  group_by(symbol) %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = to.period, 
               period     = "months")

FANG_monthly %>%
  ggplot(aes(x = date, y = adjusted, color = symbol)) +
  geom_line(size = 1) +
  labs(title = "Monthly Stock Prices",
       x = "", y = "Adjusted Prices", color = "") +
  facet_wrap(~ symbol, ncol = 2, scales = "free_y") +
  scale_y_continuous(labels = scales::dollar) +
  theme_tq() + 
  scale_color_tq()

# Asset Returns
FANG_returns_monthly <- FANG %>%
  group_by(symbol) %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = periodReturn,
               period     = "monthly")

# Baseline Returns
baseline_returns_monthly <- "XLK" %>%
  tq_get(get  = "stock.prices",
         from = "2012-12-01", 
         to   = "2021-05-31") %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = periodReturn,
               period     = "monthly")

returns_joined <- left_join(FANG_returns_monthly, 
                            baseline_returns_monthly,
                            by = "date")
returns_joined

FANG_rolling_corr <- returns_joined %>%
  tq_transmute_xy(x          = monthly.returns.x, 
                  y          = monthly.returns.y,
                  mutate_fun = runCor,
                  n          = 6,
                  col_rename = "rolling.corr.6")
FANG_rolling_corr

FANG_rolling_corr %>%
  ggplot(aes(x = date, y = rolling.corr.6, color = symbol)) +
  geom_hline(yintercept = 0, color = palette_light()[[1]]) +
  geom_line(size = 1) +
  labs(title = "FANG: Six Month Rolling Correlation to XLK",
       x = "", y = "Correlation", color = "") +
  facet_wrap(~ symbol, ncol = 2) +
  theme_tq() + 
  scale_color_tq()

FANG_macd <- FANG %>%
  group_by(symbol) %>%
  tq_mutate(select     = close, 
            mutate_fun = MACD, 
            nFast      = 12, 
            nSlow      = 26, 
            nSig       = 9, 
            maType     = SMA) %>%
  mutate(diff = macd - signal) %>%
  select(-(open:volume))
FANG_macd

FANG_macd %>%
  filter(date >= as_date("2016-10-01")) %>%
  ggplot(aes(x = date)) + 
  geom_hline(yintercept = 0, color = palette_light()[[1]]) +
  geom_line(aes(y = macd, col = symbol)) +
  geom_line(aes(y = signal), color = "blue", linetype = 2) +
  geom_bar(aes(y = diff), stat = "identity", color = palette_light()[[1]]) +
  facet_wrap(~ symbol, ncol = 2, scale = "free_y") +
  labs(title = "FANG: Moving Average Convergence Divergence",
       y = "MACD", x = "", color = "") +
  theme_tq() +
  scale_color_tq()
