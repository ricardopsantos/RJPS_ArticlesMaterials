import PlaygroundSupport
import Foundation
import UIKit

public func perfectMapper<A: Encodable, B: Decodable>(inValue: A, outValue: B.Type) -> B? {
    do {
        let encoded = try JSONEncoder().encode(inValue)
        let decoded = try JSONDecoder().decode(((B).self), from: encoded)
        return decoded
    } catch {
        return nil
    }
}

struct EmployeeDto: Codable {
    let id, employeeName, employeeSalary, employeeAge: String?
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
    
    static var random: EmployeeDto {
        let random = "\(Int.random(in: 1..<100))"
        return EmployeeDto.init(id: "\(random)",
                                employeeName:"name_\(random)",
                                employeeSalary: "\(random) €",
                                employeeAge: "\(random)",
                                profileImage: nil)
    }
}

extension EmployeeDto {
    var toModel1: EmployeeModel { return EmployeeModel(id: self.id, employeeName: self.employeeName) }
    var toModel2: EmployeeModel? { return perfectMapper(inValue: self, outValue: EmployeeModel.self) }
}

struct EmployeeModel: Codable {
    let id, employeeName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
    }
}

class SimpleViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        self.view = view
        
        let dto = EmployeeDto.random
        let model1 = dto.toModel1
        let model2 = dto.toModel2
        
        print(model1)
        print(model2)
    }
    

}

PlaygroundPage.current.liveView = SimpleViewController()



