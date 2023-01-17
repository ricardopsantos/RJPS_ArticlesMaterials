import Foundation

public extension URLRequest {

    static func with(urlString: String,
                     httpMethod: String,
                     httpBody: [String: Any]?,
                     headerValues: [String: String]?) -> URLRequest? {
        guard let theURL = URL(string: "\(urlString)") else {
            return nil
        }
        var request = URLRequest(url: theURL)
        request.httpMethod = httpMethod.uppercased()

        if let httpBody = httpBody {
            if httpBody.keys.count == 1, let dataRaw = httpBody["data-raw"] as? String {
                /**
                 curl --request POST 'https://login.microsoftonline.com/xxx-82a0-4bff-b9e9-xxxx/oauth2/token' \
                 --header 'Content-Type: application/x-www-form-urlencoded' \
                 --data-raw 'client_id=xxxx-f206-xxxx-86d8-xxxx&client_secret=b13828ebbc09a965bc&grant_type=client_credentials&resource=https://api.xxxx.com/b2bgateway'
                 */
                request.httpBody = Data(dataRaw.utf8)
            } else {
                request.httpBody = try? JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
            }
        }

        headerValues?.forEach({ (kv) in
            request.addValue(kv.value, forHTTPHeaderField: kv.key)
        })

        return request
    }
}
