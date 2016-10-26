//
//  GetAllProjectsBuilderTest.swift
//  Redmine
//
//  Created by David Martinez on 26/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import XCTest
@testable import Redmine

class GetAllProjectsBuilderTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func test_should_return_empty_list_when_no_data () {
        let data : Data? = nil
        let builder = GetAllProjectsBuilder()
        let result = builder.buildData(data)
        XCTAssertTrue(result.count == 0)
    }
    
    func test_should_return_two_items_when_data_has_two_items () {
        let json = "{\"projects\":[{\"created_on\":\"2013-02-22T14:02:27Z\",\"description\":\"Proyecto para gestionar las tareas que compondrán la versión 13 de la aplicación.\",\"id\":108,\"identifier\":\"araipad13\",\"name\":\"ARAIpad 13\",\"updated_on\":\"2015-01-23T08:00:43Z\"},{\"created_on\":\"2014-03-28T16:21:04Z\",\"description\":\"Proyecto para la gestión interna de la salida a producción del Site Andorra\",\"id\":165,\"identifier\":\"ara-andorra-bbt\",\"name\":\"ARA Andorra BBT\",\"updated_on\":\"2015-01-23T07:59:23Z\"}]}"
        
        let data = json.data(using: String.Encoding.utf8)
        let builder = GetAllProjectsBuilder()
        let result = builder.buildData(data)
        XCTAssertTrue(result.count == 2)
    }
    
    func test_should_match_fields_items_when_list_has_that_fields () {
        let json = "{\"projects\":[{\"created_on\":\"2013-02-22T14:02:27Z\",\"description\":\"Proyecto para gestionar las tareas que compondrán la versión 13 de la aplicación.\",\"id\":108,\"identifier\":\"araipad13\",\"name\":\"ARAIpad 13\",\"updated_on\":\"2015-01-23T08:00:43Z\"},{\"created_on\":\"2014-03-28T16:21:04Z\",\"description\":\"Proyecto para la gestión interna de la salida a producción del Site Andorra\",\"id\":165,\"identifier\":\"ara-andorra-bbt\",\"name\":\"ARA Andorra BBT\",\"updated_on\":\"2015-01-23T07:59:23Z\"}]}"
        let data = json.data(using: String.Encoding.utf8)
        let builder = GetAllProjectsBuilder()
        let result = builder.buildData(data)
        
        let projectOne = result.first!
        XCTAssertEqual(projectOne.id, "108")
        XCTAssertEqual(projectOne.name, "ARAIpad 13")
    }
    
    func test_should_ignore_project_when_it_hasnt_id () {
        let json = "{\"projects\":[{\"created_on\":\"2013-02-22T14:02:27Z\",\"description\":\"Proyecto para gestionar las tareas que compondrán la versión 13 de la aplicación.\",\"identifier\":\"araipad13\",\"name\":\"ARAIpad 13\",\"updated_on\":\"2015-01-23T08:00:43Z\"}]}"
        
        let data = json.data(using: String.Encoding.utf8)
        let builder = GetAllProjectsBuilder()
        let result = builder.buildData(data)
        XCTAssertTrue(result.count == 0)
    }
    
    func test_should_ignore_project_when_it_hasnt_name () {
        let json = "{\"projects\":[{\"created_on\":\"2013-02-22T14:02:27Z\",\"description\":\"Proyecto para gestionar las tareas que compondrán la versión 13 de la aplicación.\",\"id\":108,\"identifier\":\"araipad13\",\"updated_on\":\"2015-01-23T08:00:43Z\"}]}"
        
        let data = json.data(using: String.Encoding.utf8)
        let builder = GetAllProjectsBuilder()
        let result = builder.buildData(data)
        XCTAssertTrue(result.count == 0)
    }
}
