*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource    apiCalls.robot
Resource    actions.robot
Resource    screenChecks.robot
Library    ExpectedShoppingCart


*** Variables ***
${BASE_URL}        http://automationexercise.com
${screenshotDirectory}    ./screenshots



*** Test Cases ***
Purchase Products
#1. Launch browser and 2. Navigate to page 'http://automationexercise.com'
    Open Browser    ${BASE_URL}    chrome
    Maximize Browser Window
    Capture Page Screenshot    ${screenshotDirectory}/1_browserStart.png


#3. Navigate to page 'Products'
    Navigate To Products Menu    
    Capture Page Screenshot    ${screenshotDirectory}/2_productsPage.png

#4. Verify if search bar is visible
    Verify Search Bar Is Visible

#5. write 'men tshirt' and 6. Click on 'search button'
    Search Item    men tshirt
    Capture Page Screenshot    ${screenshotDirectory}/3_firstSearchResults.png

    ${searchResults}    Expected Product Search Results    men tshirt     #this variable is created to store all the possible search results found with the API when searching for the string

#7. Verify 'men tshirt' is visible
    Verify Searched Term Is Visible    men tshirt
    Verify Product Is Visible    ${searchResults}[0][id]

    #cart is just an object created to store all the expected items to be found later in the cart. Further functions can be found in the ShoppingCart.py file inside the lib folder
    ${cart}    Create New Expected Shopping Cart

#8. Add product to cart
    Add Product To Cart    ${searchResults}[0][id]        #we choose to add the first result of the search
    Wait For Success Modal
    Capture Page Screenshot    ${screenshotDirectory}/4_firstSucessModal.png

    Add Expected Item    ${searchResults}[0][id]     1    ${searchResults}[0][price]    #adding item to the ShoppingCart ${cart} object

# Continue shopping and Verify if search bar becomes visible
    Continue Shopping
    Verify Search Bar Is Visible
    Capture Page Screenshot    ${screenshotDirectory}/5_continueShopping.png


# write 'top' and Click on 'search button'
    Search Item    top
    Capture Page Screenshot    ${screenshotDirectory}/6_secondSearchResults.png

    ${secondSearchResults}    Expected Product Search Results    top    #this variable is created to store all the possible search results found with the API when searching for the string

# Verify 'top' is visible
    Verify Searched Term Is Visible    top
    Verify Product Is Visible    ${secondSearchResults}[0][id]

#9. Add a second item to the cart (your choice)
    Add Product To Cart    ${secondSearchResults}[0][id]
    Wait For Success Modal
    Capture Page Screenshot    ${screenshotDirectory}/7_secondSucessModal.png

    Add Expected Item    ${secondSearchResults}[0][id]     1    ${secondSearchResults}[0][price]    #adding item to the ShoppingCart ${cart} object

#10. Click on 'Cart' button
    View Cart From Success Modal
    Capture Page Screenshot    ${screenshotDirectory}/8_cart.png

#11. verify that product are visible in cart
    ${cartIds}    Get Expected Cart Product Ids     #get method to find all the product IDs expected in the cart
    Verify Products In Cart    ${cartIds}

#12. verify that the sum of the product values is correct
    ${expectedTotalCost}    Get Expected Total Cost
    Verify Cart Total    ${expectedTotalCost}


Close Browser
    Capture Page Screenshot    ${screenshotDirectory}/9_closingBrowser.png
    Close Browser










