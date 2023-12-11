*** Settings ***
Library    SeleniumLibrary
Library    Collections


*** Keywords ***
Navigate To Products Menu
    ${PRODUCT_PAGE}    Set Variable    xpath://a[@href='/products']
    Click Element    ${PRODUCT_PAGE}

Search Item    
    [Arguments]    ${searchString}
    Input Text    id:search_product    ${searchString}
    Click Element    xpath://button[@id='submit_search']

Add Product To Cart
    [Arguments]    ${productId}
    ${element}    Get WebElement    xpath://a[@data-product-id='${productId}']
    Scroll Element Into View    xpath://a[@data-product-id='${productId}']
    ${result}    Run Keyword And Ignore Error    Click Element    ${element}
    #sometimes depending on screen size, when trying to add an item to cart, the Click Element fails due to a google ad pop up on the screen. The next few lines are there to handle this pop up and try the action again
    Run Keyword If    '${result}[0]' == 'FAIL'    Run Keywords    
    ...    Handle Popup    AND    Wait Until Keyword Succeeds    10s    3s    Click Element     ${element}

                        
Handle Popup
    Click Element    xpath=//div[@class='grippy-host']

Continue Shopping
    Click Element    xpath=//button[contains(text(), 'Continue Shopping')]

View Cart From Success Modal
    Wait Until Keyword Succeeds    10s    3s    Click Element    xpath://div[@id='cartModal']//a[@href='/view_cart']
