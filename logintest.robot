*** Settings ***
Library    SeleniumLibrary
Documentation    Test cases login trang OrangeHRM

*** Variables ***
${URL}            https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}        chrome
${VALID_USER}     Admin
${VALID_PASS}     admin123
${INVALID_USER}   abc
${INVALID_PASS}   xyz123

*** Test Cases ***

Đăng nhập hợp lệ
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//input[@name='username']    timeout=10s
    Custom Login    ${VALID_USER}    ${VALID_PASS}
    Verify Login Success
    Close Browser

Đăng nhập không hợp lệ
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//input[@name='username']    timeout=10s
    Custom Login    ${INVALID_USER}    ${INVALID_PASS}
    Verify Login Failed
    Close Browser

*** Keywords ***

Custom Login
    [Arguments]    ${username}    ${password}
    [Documentation]    Đăng nhập với tài khoản được cung cấp
    Input Text    xpath=//input[@name='username']    ${username}
    Input Text    xpath=//input[@name='password']    ${password}
    Click Button    xpath=//button[@type='submit']
    Sleep    2s

Verify Login Success
    [Documentation]    Kiểm tra sau khi đăng nhập thành công
    Page Should Contain Element    xpath=//p[@class='oxd-userdropdown-name']
    Log To Console     Đăng nhập thành công với tài khoản: ${VALID_USER}

Verify Login Failed
    [Documentation]    Kiểm tra thông báo khi đăng nhập thất bại
    Page Should Contain    Invalid credentials
    Log To Console     Đăng nhập thất bại vì sai tài khoản: ${INVALID_USER}
