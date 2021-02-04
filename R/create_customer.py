from faker import Faker
import pandas as pd

customer = Faker("ko_KR")

profiles = [customer.profile() for i in range(10)]
customer_df = pd.DataFrame(profiles)

customer_df.to_csv("database/customer.csv", sep = "|", na_rep = "NaN")
