#!/usr/bin/env python3
"""Simple ML project with lighter dependencies"""

import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
import matplotlib
matplotlib.use('Agg')  # Non-interactive backend
import matplotlib.pyplot as plt

print("✅ Simple ML Project Test")
print(f"NumPy version: {np.__version__}")
print(f"Pandas version: {pd.__version__}")
print(f"Scikit-learn imported successfully")
print(f"Matplotlib version: {matplotlib.__version__}")

# Quick test
X = np.array([[1], [2], [3], [4], [5]])
y = np.array([2, 4, 6, 8, 10])
model = LinearRegression()
model.fit(X, y)
print(f"\n🎉 Linear regression test passed! Coefficient: {model.coef_[0]:.2f}")
