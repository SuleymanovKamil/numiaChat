import Foundation

struct API {
    static let baseURL = "http://api.mappa.one"
    static let storage = "http://api.mappa.one//storage/show-image"
    
    struct UserAPI {
        static let logIn = "/user/login"
        static let register = "/user/register"
        static let userTypes = "/user/types"
        static let getProfile = "/user/show-profile"
        static let forgotPassword = "/user/forgot-password"
        static let changePassword = "/user/change-password"
    }
    
    struct InterestAPI {
        static let set = "/interest/set-interest-user"
        static let get = "/interest/get-interest-user"
        static let list = "/interest/get-list"
        static let delete = "/interest/delete/" //+ http://api.mappa.one//interest/delete/15
    }
    
    struct FavoriteAPI {
        static let add = "/favorite/add"
        static let list = "/favorite/list"
        static let delete = "/favorite/delete"
    }
    
    struct EventsAPI {
        static let getCities = "/city/get-list"
        static let getEventsTypes = "/event/get-type-list"
        static let list = "/event/list"
        static let sort = "/event/list?sort" //+ http://api.mappa.one//event/list?sort[id]=desc&paginate[page]=1
        static let getStatusList = "/event/get-status-list"
        static let getCategoryList = "/event/category-list"
        static let create = "/event/create"
        static let delete = "/event/delete" //+ http://api.mappa.one//event/delete/5068
    }
}
