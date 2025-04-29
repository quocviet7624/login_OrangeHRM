*** Settings ***
Documentation     Viết test case trang login OrangeHRM
Library           SeleniumLibrary

*** Variables ***
${URL}            https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${USERNAME}       Admin
${PASSWORD}       admin123
${WRONG_USER}     saiuser
${WRONG_PASS}     saipass
${BROWSER}        chrome

*** Test Cases ***
Đăng nhập thành công
    Mở trình duyệt
    Đăng nhập    ${USERNAME}    ${PASSWORD}
    Kiểm tra đăng nhập thành công
    Đóng trình duyệt

Đăng nhập thất bại
    Mở trình duyệt
    Đăng nhập    ${WRONG_USER}    ${WRONG_PASS}
    Kiểm tra đăng nhập thất bại
    Đóng trình duyệt

*** Keywords ***
Mở trình duyệt
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s

Đăng nhập
    [Arguments]    ${user}    ${pass}
    Wait Until Element Is Visible    xpath://input[@name="username"]    10s
    Input Text     xpath://input[@name="username"]    ${user}
    Input Text     xpath://input[@name="password"]    ${pass}
    Click Button   xpath://button[@type="submit"]

Kiểm tra đăng nhập thành công
    Wait Until Page Contains Element    xpath://*[@class="oxd-userdropdown-name"]    10s
    Element Should Be Visible           xpath://*[@class="oxd-userdropdown-name"]

Kiểm tra đăng nhập thất bại
    Wait Until Page Contains    Invalid credentials    10s
    Page Should Contain         Invalid credentials

Đóng trình duyệt
    Close Browser
