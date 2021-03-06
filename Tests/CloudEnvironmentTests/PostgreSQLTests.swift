/*
 * Copyright IBM Corporation 2017
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import XCTest
import Configuration
@testable import CloudEnvironment

class PostgreSQLTests: XCTestCase {

    static var allTests : [(String, (PostgreSQLTests) -> () throws -> Void)] {
        return [
            ("testGetCredentials", testGetCredentials),
            ("testGetCredentialsDB", testGetCredentialsDB),
        ]
    }

    func testGetCredentials() {

        // Load test mappings.json file and Cloud Foundry test credentials-- VCAP_SERVICES and VCAP_APPLICATION
        let cloudEnv = CloudEnv(mappingsFilePath: "Tests/CloudEnvironmentTests/resources", cloudFoundryFile: "Tests/CloudEnvironmentTests/resources/config_cf_example.json")

        guard let credentials =  cloudEnv.getPostgreSQLCredentials(name: "PostgreSQLKey") else {
            XCTFail("Could not load PostgreSQL credentials.")
            return
        }

        XCTAssertEqual(credentials.host, "bluemix-sandbox-dal-9-portal.0.dblayer.com", "PostgreSQL service host should match.")
        XCTAssertEqual(credentials.username, "user", "PostgreSQL service username should match.")
        XCTAssertEqual(credentials.password, "password", "PostgreSQL service password should match.")
        XCTAssertEqual(credentials.port, 22387, "PostgreSQL service port should match.")
        XCTAssertEqual(credentials.database, "compose", "PostgreSQL service database should match.")

    }
    
    func testGetCredentialsDB() {
        
        // Load test mappings.json file and Cloud Foundry test credentials-- VCAP_SERVICES and VCAP_APPLICATION
        let cloudEnv = CloudEnv(mappingsFilePath: "Tests/CloudEnvironmentTests/resources", cloudFoundryFile: "Tests/CloudEnvironmentTests/resources/config_cf_example.json")
        
        guard let credentials =  cloudEnv.getPostgreSQLDatabaseCredentials(name: "PostgreSQLKeyDB") else {
            XCTFail("Could not load PostgreSQL credentials.")
            return
        }
        
        XCTAssertEqual(credentials.host, "123456789.123456789.databases.appdomain.cloud", "PostgreSQL service host should match.")
        XCTAssertEqual(credentials.username, "ibm_cloud_1234", "PostgreSQL service username should match.")
        XCTAssertEqual(credentials.password, "qwertyuiop", "PostgreSQL service password should match.")
        XCTAssertEqual(credentials.port, 12345, "PostgreSQL service port should match.")
        XCTAssertEqual(credentials.database, "dbname", "PostgreSQL service database should match.")
        
    }
    
}
