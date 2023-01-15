//
//  Created by Santos, Ricardo Patricio dos on 15/01/2023.
//

import Foundation

public struct ResponseDto {
    private init() { }
}

public extension ResponseDto {
    struct EmployeeServiceAvailability: Codable, Hashable {
        public let status: String
        public let data: [Employee]
        public let message: String
        public init() {
            self.status = ""
            self.data = []
            self.message = ""
        }
    }
    
    struct Employee: Codable, Hashable {
        public let id: Int
        public let employeeName: String
        public let employeeSalary, employeeAge: Int
        public let profileImage: String

        public init() {
            self.id = 0
            self.employeeName = ""
            self.employeeAge = 0
            self.employeeSalary = 0
            self.profileImage = ""
        }
        
        enum CodingKeys: String, CodingKey {
            case id
            case employeeName = "employee_name"
            case employeeSalary = "employee_salary"
            case employeeAge = "employee_age"
            case profileImage = "profile_image"
        }
    }
}
