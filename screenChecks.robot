*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String


*** Keywords ***
Verify Search Bar Is Visible
    Wait Until Page Contains Element    id:search_product

Verify Searched Term Is Visible
    [Arguments]    ${searchString}
    ${titleCaseString}    Convert To Title Case    ${searchString}
    Page Should Contain Element    xpath://div[contains(@class, 'productinfo')]//p[contains(text(), '${titleCaseString}')]


Verify Product Is Visible
    [Arguments]    ${productId}
    Page Should Contain Element    xpath://a[@data-product-id='${productId}']

Wait For Success Modal
    Wait Until Page Contains Element    xpath://div[@id='cartModal' and @class='modal show']//h4[contains(text(), 'Added!') and contains(@class, 'modal-title')]
    Wait Until Page Contains Element    xpath://div[@id='cartModal' and @class='modal show']//p[contains(text(), 'Your product has been added to cart.')]
    Wait Until Page Contains Element    xpath://div[@id='cartModal' and @class='modal show']//div[@class='modal-body']//a[@href='/view_cart']
    Wait Until Page Contains Element    xpath://div[@id='cartModal' and @class='modal show']//button[contains(text(), 'Continue Shopping')]

Verify Products In Cart
    [Arguments]    ${cartIds}
    ${cartLength}    Get Length    ${cartIds}
    FOR     ${i}    IN RANGE    ${cartLength}
        Page Should Contain Element     xpath://table[@id='cart_info_table']//tr[@id='product-${cartIds}[${i}]']
    END    # Assuming product names are displayed in the cart

Verify Cart Total
    [Arguments]    ${expected_total}
    ${actualTotal}    Extract Cart Total Sum
    Should Be Equal As Numbers    ${actual_total}    ${expected_total}

Extract Cart Total Sum
    ${elements}     Get Web Elements     xpath://*[@class='cart_total_price']
    @{texts}    Create List
    FOR    ${element}     IN    @{elements}
        ${text}    Get Text     ${element}
        ${numeric_part}    Get Substring     ${text}    4
        ${integer_value}    Convert To Integer    ${numeric_part}
        Append To List     ${texts}     ${integer_value}
    END
    
    ${sum_of_elements}    Evaluate    sum(@{texts})
    [Return]    ${sum_of_elements}

