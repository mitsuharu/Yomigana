//
//  YomiganaTests.swift
//  YomiganaTests
//
//  Created by Mitsuharu Emoto on 2019/07/03.
//  Copyright © 2019 Mitsuharu Emoto. All rights reserved.
//

import XCTest
@testable import Yomigana

class YomiganaTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApi(){
        
        let exp: XCTestExpectation = expectation(description: "to hiragana")
        
        let inputText = "今日は良い天気です"
        let outputText = "きょうは よい てんきです"
        let sentence = Sentence(inputText)
        sentence.toHiragana { (result, errorType) in
            if result, let temp = sentence.converted{
                XCTAssertEqual(temp, outputText)
            }else{
                var str = "api failed"
                if let err = errorType{
                    str += ", err: \(err.description)"
                }
                XCTFail(str)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 30)
    }
    
}
