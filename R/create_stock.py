import FinanceDataReader as fdr

# 삼성전자(005930) : (2017-01-0 ~ 2019-12-31)
samsung_df = fdr.DataReader('005930', '2017-01-01', '2019-12-31')

# Apple(AAPL) : (2017-01-0 ~ 2019-12-31)
apple_df = fdr.DataReader('AAPL', '2017-01-01', '2019-12-31')

# AMAZON(AMZN) : (2017-01-0 ~ 2019-12-31)
aws_df = fdr.DataReader('AMZN', '2017-01-01', '2019-12-31')

samsung_df.to_csv("database/stock_samsung.csv", sep = "|", na_rep = "NaN")
apple_df.to_csv("database/stock_apple.csv", sep = "|", na_rep = "NaN")
aws_df.to_csv("database/stock_aws.csv", sep = "|", na_rep = "NaN")
