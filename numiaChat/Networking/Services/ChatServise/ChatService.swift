//
//  ChatService.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//


protocol ChatService {
    func fetchMessages(offset: Int) async -> Result<Messages, RequestError>
}

final class ChatServiceImp: HTTPClient, ChatService {
    static let chatService = ChatServiceImp()
    
    func fetchMessages(offset: Int) async -> Result<Messages, RequestError> {
        return await sendRequest(endpoint: ChatEndpoint.fetchMessages(offset: offset), responseModel: Messages.self)
    }
    
}

final class MockChatServiceImp: ChatService {
    static let chatService = MockChatServiceImp()
    
    func fetchMessages(offset: Int) async -> Result<Messages, RequestError> {
        let messages = ["Сообщение 1","Сообщение 2","Сообщение 3","Сообщение 4","Сообщение 5","Сообщение 6","Очень длинное сообщение 7, которое не помещается в одну строчку. Очень длинное сообщение 7, которое не помещается в одну строчку.","Сообщение 8","Сообщение 9","Сообщение 10","Сообщение 11","Сообщение 12","Очень длинное сообщение 13, которое не помещается в одну строчку. Очень длинное сообщение 13, которое не помещается в одну строчку.","Сообщение 14","Сообщение 15","Сообщение 16","Сообщение 17","Сообщение 18","Очень длинное сообщение 19, которое не помещается в одну строчку. Очень длинное сообщение 19, которое не помещается в одну строчку.","Сообщение 20"]
        
        return .success(Messages(result: messages))
    }
    
}
