//
//  EVReflectionJsonTests.swift
//  EVReflection
//
//  Created by Edwin Vermeer on 6/15/15.
//  Copyright (c) 2015 evict. All rights reserved.
//

import UIKit
import XCTest

/**
Testing EVReflection for Json
*/
class EVReflectionJsonTests: XCTestCase {
    
    /**
    For now nothing to setUp
    */
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    /**
    For now nothing to tearDown
    */
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testJsonObject(){
        let jsonDictOriginal = [
            "id": 24,
            "name": "John Appleseed",
            "email": "john@appleseed.com",
            "company": [
                "name": "Apple",
                "address": "1 Infinite Loop, Cupertino, CA"
            ],
            "friends": [
                ["id": 27, "name": "Bob Jefferson"],
                ["id": 29, "name": "Jen Jackson"]
            ]
        ]
        print("Initial dictionary:\n\(jsonDictOriginal)\n\n")
        
        let userOriginal = User(dictionary: jsonDictOriginal)
        validateUser(userOriginal)
        
        print("------ And the objects are NSObject. Therefore this will still crash ------\n")
        let jsonString = userOriginal.toJsonString()
        print("JSON string from dictionary: \n\(jsonString)\n\n")

        let userRegenerated = User(json:jsonString)
        validateUser(userRegenerated)
        
        if userOriginal == userRegenerated {
            XCTAssert(true, "Success")
        } else {
            XCTAssert(false, "Faileure")
        }
    }
    
    func validateUser(user:User) {
        print("Validat user: \n\(user)\n\n")
        XCTAssertTrue(user.id == 24, "id should have been set to 24")
        XCTAssertTrue(user.name == "John Appleseed", "name should have been set to John Appleseed")
        XCTAssertTrue(user.email == "john@appleseed.com", "email should have been set to john@appleseed.com")
        
        XCTAssertNotNil(user.company, "company should not be nil")
        print("company = \(user.company)\n")
        XCTAssertTrue(user.company?.name == "Apple", "company name should have been set to Apple")
        print("company name = \(user.company?.name)\n")
        XCTAssertTrue(user.company?.address == "1 Infinite Loop, Cupertino, CA", "company address should have been set to 1 Infinite Loop, Cupertino, CA")
        
        XCTAssertNotNil(user.friends, "friends should not be nil")
        XCTAssertTrue(user.friends.count == 2, "friends should have 2 Users")
        
        XCTAssertTrue(user.friends[0].id == 27, "day should not be nil")
        XCTAssertTrue(user.friends[0].name == "Bob Jefferson", "day should not be nil")
        XCTAssertTrue(user.friends[1].id == 29, "day should not be nil")
        XCTAssertTrue(user.friends[1].name == "Jen Jackson", "day should not be nil")
    }
    
    func testJsonArray() {
        let jsonDictOriginal:String = "[{\"id\": 27, \"name\": \"Bob Jefferson\"}, {\"id\": 29, \"name\": \"Jen Jackson\"}]"
        let array:[User] = EVReflection.arrayFromJson(User(), json: jsonDictOriginal)
        print("Object array from json string: \n\(array)\n\n")
    }    
}

class User: EVObject {
    var id: Int = 0
    var name: String = ""
    var email: String?
    var company: Company?
    var friends: [User] = []
}

class Company: EVObject {
    var name: String = ""
    var address: String?
}

