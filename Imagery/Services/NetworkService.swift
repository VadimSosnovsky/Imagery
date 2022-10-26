//
//  NetworkService.swift
//  Imagery
//
//  Created by Вадим Сосновский on 26.10.2022.
//

import UIKit

protocol NetworkServiceProtocol {
    func fetchImages(searchText: String, completion: @escaping (ImageInfo?) -> Void)
    func loadImages(from url: URL, completion: @escaping (UIImage) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    static var cache = NSCache<AnyObject, UIImage>()
    var url: URL?
    
    static let shared = NetworkService()
    private init() {}
    
    func fetchImages(searchText: String, completion: @escaping (ImageInfo?) -> Void) {
        let address = "https://api.unsplash.com/search/photos?page=1&per_page=8&query=\(searchText)&client_id=\(apiKey)"
        if let url = URL(string: address) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let response = response as? HTTPURLResponse, let data = data {
                    print("Status Code: \(response.statusCode)")
                    do {
                        let decoder = JSONDecoder()
                        let picInfo = try decoder.decode(ImageInfo.self, from: data)
                        completion(picInfo)
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func loadImages(from url: URL, completion: @escaping (UIImage) -> Void) {
        
        self.url = url
        
        if let cachedImage = NetworkService.cache.object(forKey: url as AnyObject) {
            completion(cachedImage)
            print("You get image from cache")
        } else {
            URLSession.shared.dataTask(with: url) { (data, respnse, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    if url == self.url{
                        DispatchQueue.main.async {
                            let image = UIImage(data: data)
                            if let image = image {
                                completion(image)
                                NetworkService.cache.setObject(image, forKey: url as AnyObject)
                                print("You get image from \(url)")
                            }
                        }
                    } else {
                        print("1111")
                    }
                }
            }.resume()
        }
    }
}
