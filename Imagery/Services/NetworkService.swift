//
//  NetworkService.swift
//  Imagery
//
//  Created by Вадим Сосновский on 26.10.2022.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func fetchImages(searchText: String, completion: @escaping (ImageInfo?) -> Void)
    func loadImages(from url: URL, completion: @escaping (UIImage) -> Void)
    var cache: NSCache<AnyObject, UIImage> { get }
}

final class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    private init() {}
    
    private(set) var cache = NSCache<AnyObject, UIImage>()
    
    func fetchImages(searchText: String, completion: @escaping (ImageInfo?) -> Void) {
        
        print("config url is: \(Environment.baseURL)")
        let url = Environment.baseURL
        let parameters = [ "query": searchText,
                           "page": "1",
                           "per_page": "10"]
        
        let headers: HTTPHeaders = ["Authorization": Environment.accessKey]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: headers).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error: \(error)")
            }
            
            guard let data = dataResponse.data else { return }
            let resultData = self.decodeJSON(ImageInfo.self, data: data)
            completion(resultData)
        }
    }
    
    func loadImages(from url: URL, completion: @escaping (UIImage) -> Void) {
        
        if let cachedImage = cache.object(forKey: url as AnyObject) {
            completion(cachedImage)
            print("download from cahce")
        } else {
            AF.request(url, method: .get).responseData { (dataResponse) in
                guard let data = dataResponse.data else { print("Error: \(String(describing: dataResponse.error))")
                                                          return }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    print("download from the internet")
                    guard let image = image else { return }
                    completion(image)
                    self.cache.setObject(image, forKey: url as AnyObject)
                }
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(_ type: T.Type, data: Data) -> T {
        do {
            let decoder = JSONDecoder()
            let picInfo = try decoder.decode(type.self, from: data)
            return picInfo
        } catch {
            print(error)
        }
        return ImageInfo.init(results: [Result]()) as! T
    }
}
