# robotTest

This Robot Framework test suite automates the purchase of products on an e-commerce website. The test suite utilizes SeleniumLibrary to interact with the web browser and the custom library ExpectedShoppingCart to save the expected contents of the cart.

#Requirements
Robot Framework
Python 3.6 or higher
SeleniumLibrary

#Setup
Install the required libraries:
Bash
pip install robotframework
pip install robotframework-seleniumLibrary

#Running the Tests
Open a terminal window and navigate to the directory containing the test suite file (test_suite.robot).

Run the following command to execute the tests:
Bash
robot test_suite.robot

The test suite will launch a web browser, navigate to the e-commerce website, search for products, add them to the cart, and verify their presence. It will also capture screenshots at various points for better visualization/debugging purposes.

Expected Results:
The test suite should successfully purchase the selected products and verify that they are visible in the cart. The screenshots will provide visual evidence of the actions performed.
