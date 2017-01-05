require 'rubygems'
require 'appium_lib'

APP_PATH = '/Users/chuentiwachuencharoensuk/Documents/SalaryManager/salary-manager/Build/Products/Debug-iphonesimulator/salary-manager.app'

desired_caps = {
  caps:       {
    platformName:  'iOS',
    versionNumber: '10.1',
    deviceName:    'iPhone SE',
    app:           APP_PATH,
    automationName: 'XCUITest'
  },
  appium_lib: {
    sauce_username:   nil, # don't run on Sauce
    sauce_access_key: nil
  }
}

# Start the driver
Appium::Driver.new(desired_caps).start_driver

module SimpleTest
  module IOS
    # Add all the Appium library methods to Test to make
    # calling them look nicer.
    Appium.promote_singleton_appium_methods SimpleTest

    elements     = driver.find_elements(:xpath,"//*")
    index=0
    elements.each {
      |element|
      print("Index: " + index.to_s)
      print(", Value: " + (element.attribute("value").nil? ? "" : element.attribute("value")))
      print(", Text: " + (element.text.nil? ? "" : element.text) + "\n")
      index = index + 1
    }

    cellElement = driver.find_element(:class_name, "XCUIElementTypeCell")
    cellElement.click()

    labelElement = driver.find_element(:id, "transactionName")
    print("Name: " + labelElement.attribute("value") + "\n")
    labelElement = driver.find_element(:id, "amount")
    print("Amount: " + labelElement.attribute("value")+ "\n")
    labelElement = driver.find_element(:id, "remark")
    print("Remark: " + labelElement.attribute("value")+ "\n")

    # Quit when you're done!
    driver_quit
    puts 'Tests Succeeded!'
  end
end
