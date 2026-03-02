# -*- coding: utf-8 -*-
"""
Created on Fri Nov  7 12:42:22 2025
@author: Noah Asgodom
Project: Capstone 
"""


#------------------Step-1--------------
#Importin Library

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os
import statsmodels.formula.api as smf

#Load the Salary_Data.csv file into a pandas DataFrame
# Define the path to your CSV file
csv_file_path = 'Salary_Data.csv'

# Check if the CSV file exists
if not os.path.exists(csv_file_path):
    print(f" Error: The file '{csv_file_path}' was not found.")
    print("Please ensure 'Salary_Data.csv' is in the same directory as this script.")
    exit()

# Load the CSV into a DataFrame named after your first name
try:
    noah_data = pd.read_csv(csv_file_path)
    print(" Data loaded successfully:\n")
    print(noah_data.head())  # Display the first few rows

    print("\n Data Info:")
    noah_data.info()

    print("\n Descriptive Statistics:")
    print(noah_data.describe())
except Exception as e:
    print(f" Error loading CSV file: {e}")
    print("Please ensure the CSV file is correctly formatted and accessible.")
    exit()
    

#---------------------Step-2-----------------------
# Define and fit the OLS model
model = smf.ols(formula='Salary ~ YearsExperience',data=noah_data).fit()

#----------------------Step-3---------------------------

print("\n--------- OLS Regression Results ---------")
print(model.summary())


#-------------------Step-4----------------------
# Set scatter plot style
plt.figure(figsize=(10, 6))
sns.scatterplot(x='YearsExperience', y='Salary', data=noah_data, s=100, alpha=0.8, color='blue'
                ,label='Actual Salary Data')
#Add the regression line
#You can use the model's predict method on the original data's 'YearsExperience'
plt.plot(noah_data['YearsExperience'], model.predict(noah_data['YearsExperience']), color='red', 
         linestyle='--', linewidth=2, label='Regression Line')
plt.title('Salary vs. Years of Experience with Regression Line', fontsize=16)
plt.xlabel('Years of Experience', fontsize=12)
plt.ylabel('Salary', fontsize=12)
plt.grid(True, linestyle=':', alpha=0.7) # Add a grid for better readability
plt.legend(fontsize=10) # Display the legend
plt.tight_layout() # Adjust layout to prevent labels from overlapping
plt.show() # Display the plot



#-----------------Step-5-----------------------

# Prompt for user's name
name = input("Enter your name: ")

# Prompt for years of experience
try:
    experience_to_predict = float(input("\nEnter the years of experience to predict the salary: "))
except ValueError:
    print("Invalid input. Please enter a numeric value for experience.")
    exit()

# Create a new DataFrame for prediction
new_experience_df = pd.DataFrame({'YearsExperience': [experience_to_predict]})

# Predict the salary using the trained model
predicted_salary = model.predict(new_experience_df)

# Display the result
print("\n--- Salary Prediction ---")
print(f"\n{name}, for {experience_to_predict} years of experience, the predicted salary is: ${predicted_salary[0]:,.2f}")
