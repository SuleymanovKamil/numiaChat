protocol Endpoint {
    var path: String { get }
    var method: RequestMethod { get }
    var parameters: [String: Any]? { get }
    var header: [String: String]? { get }
}

