//
//  UIImageView.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 10.09.2022.
//

import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        Task {
            do {
                let image = try await loadImage(for: url)
                self.image = image
            } catch {
                print(error.localizedDescription)
                self.image = nil
            }
        }
    }
    
    func loadImage(for url: URL) async throws -> UIImage {
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(from: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return image
    }
}

