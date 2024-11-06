import pandas as pd
import scipy.stats as stats

# Sample data (replace this with the actual dataset)
data = {
    "Annual Income": [1167493, 2231892, 806949, 896857, 1184194, 2559110, 1454735, 714628, 776188, 1560907],
    "Current Loan Amount": [445412, 99999999, 347666, 206602, 217646, 548746, 215952, 99999999, 99999999, 99999999]
}

df = pd.DataFrame(data)

# Calculate Pearson correlation and p-value
correlation_coefficient, p_value = stats.pearsonr(df["Annual Income"], df["Current Loan Amount"])

# Output the result
print(f"Pearson Correlation Coefficient: {correlation_coefficient}")
print(f"P-value: {p_value}")

# Evaluate the result
alpha = 0.05  # significance level
if p_value < alpha:
    print("Reject the null hypothesis: There is a significant correlation between income and loan approval amount.")
else:
    print("Fail to reject the null hypothesis: No significant correlation between income and loan approval amount.")
