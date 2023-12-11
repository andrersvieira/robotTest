*** Settings ***
Library    RequestsLibrary

*** Variables ***
${api_url}    https://automationexercise.com/api

*** Keywords ***
Expected Product Search Results
    [Arguments]    ${search_product}
    Create Session    search_api    ${api_url}    verify=False
    ${payload}    Create Dictionary    search_product=${search_product}
    ${headers}    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    ${response}   POST On Session   alias=search_api    url=${api_url}/searchProduct    headers=${headers}    data=${payload}

    ${json_data}   Set Variable    ${response.json()}

    Log To Console    ${json_data['responseCode']}
    Log To Console    ${json_data['products']}
    Should Be Equal As Numbers    ${json_data['responseCode']}    200
    [Return]     ${json_data['products']}