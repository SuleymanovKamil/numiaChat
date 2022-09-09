import Foundation

class RequestEncoder {
    static func get(parameters: [String : Any]) -> String {
        var string = ""
        
        for (key, value) in parameters {
            guard string != "" else {
                string += "?\(key)=\(value)"
                continue
            }
            string += "&\(key)=\(value)"
        }
        return string.replacingOccurrences(of: " ", with: "")
    }
    
    static func json(parameters: [String : Any]) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print(error)
            return nil
        }
    }
    
}
