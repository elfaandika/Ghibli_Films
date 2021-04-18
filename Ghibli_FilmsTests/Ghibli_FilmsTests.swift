//
//  Ghibli_FilmsTests.swift
//  Ghibli_FilmsTests
//
//  Created by Elfa Andika on 13/04/21.
//

import Foundation
@testable import Ghibli_Films

import XCTest
import RxSwift
import RxTest
import RxBlocking



class Ghibli_FilmsTests: XCTestCase {

    

}

class APIServiceTest: XCTestCase {
    var disposeBag: DisposeBag!
    var apiService: APIService!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        apiService = APIService()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        disposeBag = nil
        apiService = nil
        scheduler = nil
        testScheduler = nil
        super.tearDown()
    }
    
    
    
}
