//
//  TextFieldsAttributesTests.swift
//  TextFieldsAttributesTests
//
//  Created by Denis Yaremenko on 3/30/21.
//

import XCTest
@testable import TextFieldsAttributes

class TextFieldsAttributesTests: XCTestCase {
    
    var sut: ViewController!
    var navigationController: UINavigationController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String.init(describing: ViewController.self)) as? ViewController
        sut.loadViewIfNeeded()
        navigationController = UINavigationController.init(rootViewController: sut)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        navigationController = nil
    }
     
    func testEmailTextField_WhenCreated_HasEmailAddressContentTypeSet() throws {
        let emailTextField = try XCTUnwrap(sut.emailTextField, "Email address UITextField is not connected")
        
        XCTAssertEqual(emailTextField.textContentType, .emailAddress, "Email adress uitextfield does not have an Email Address Content type Set")
    }
    
    
    func testEmailTextField_WhenCreated_HasEmailKeyboardTypeSet() throws {
        let emailTextField = try XCTUnwrap(sut.emailTextField, "Email address UITextField is not connected")
        
        XCTAssertEqual(emailTextField.keyboardType, .emailAddress, "Email address UITextField does not have Email Keyboard type set")
    }
    
    func testPasswordTextField_WhenCreated_IsSecureTextEntryField() throws {
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "The Password UITextField is not connected")
        
        XCTAssertTrue(passwordTextField.isSecureTextEntry, "Password UITextField is not a Secure Text Entry Field")
            
    }
    
    func testNextViewButton_WhenTapped_SecondViewControllerIsPushed_Version1() {
        
        let myPredicate = NSPredicate { (input, _) -> Bool in
            return (input as? UINavigationController)?.topViewController is SecondViewController
        }
        
        expectation(for: myPredicate, evaluatedWith: navigationController)
        // simulate nextviewbutton event - sendActions
        sut.nextViewButton.sendActions(for: .touchUpInside)
        
        // waitForExpectation runs the run loop while evaluating events untill all the expectations are fulfiled or the time out is reached
        // our expectation will continuously evaluate the predicate until it matches or until the expectation times out
        // in this case if timeout is reached and the predicate validation tells us that the top view controller is a second view controller then the test method will passed or otherwise it will fail
        waitForExpectations(timeout: 2)
    }
    
    func testNextButton_WhenTapped_SecondViewControllerPushed_Version2() {
        sut.nextViewButton.sendActions(for: .touchUpInside)
 
        RunLoop.current.run(until: Date()) // run it and stop it right away
        
        guard let _ = navigationController.topViewController as? SecondViewController else {
            XCTFail()
            return
        }
    }
    
    func testNextButton_WhenTapped_SecondViewControllerPushed_Version3() {
        let spyNavCtrl = SpyNavigationController(rootViewController: sut)
        sut.nextViewButton.sendActions(for: .touchUpInside)
        
        guard let _ = spyNavCtrl.pushedViewController as? SecondViewController else {
             XCTFail()
            return
        }
   
        XCTAssertTrue(true)
    }
}
