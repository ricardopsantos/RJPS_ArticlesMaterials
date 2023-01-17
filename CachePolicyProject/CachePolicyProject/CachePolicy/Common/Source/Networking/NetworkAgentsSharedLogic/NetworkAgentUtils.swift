//
//  Created by Ricardo Santos on 21/01/2021.
//

import Foundation

extension NetworkinNameSpace {
    struct NetworkAgentUtils {
        static func parseCSV(data: Data) throws ->  Data {
            let dataString: String! = String.init(data: data, encoding: .utf8)

            guard let jsonKeys: [String] = dataString.components(separatedBy: "\n").first?.components(separatedBy: ",") else {
                throw FRPSimpleNetworkClientAPIError.parsing(description: "\(NetworkAgentUtils.self) CSV parsing fail")
            }

            var parsedCSV: [[String: String]] = dataString
                .components(separatedBy: "\n")
                .map({
                    var result = [String: String]()
                    for (index, value) in $0.components(separatedBy: ",").enumerated() {
                        if index < jsonKeys.count {
                            result["\(jsonKeys[index])"] = value
                        }
                    }
                    return result
                })

            parsedCSV.removeFirst()

            guard let jsonData = try? JSONSerialization.data(withJSONObject: parsedCSV, options: []) else {
                throw FRPSimpleNetworkClientAPIError.parsing(description: "\(NetworkAgentUtils.self) CSV parsing fail")
            }

            return jsonData
        }
    }
}
