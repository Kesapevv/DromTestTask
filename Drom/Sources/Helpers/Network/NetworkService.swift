//
//  NetworkService.swift
//  Drom
//
//  Created by Vadim Voronkov on 19.06.2022.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    var startIndex: Int { get set }
    var endIndex: Int { get set }
    func fetchResults(completion: @escaping (Result<UIImage?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    //Сделал некий "offset" по индексам, загружает по 3 картинки с запуска приложения, затем через скролл подгружает еще
    var startIndex: Int = 0
    var endIndex: Int = 2
    var imageCache = NSCache<NSString, UIImage>()
    
    func fetchResults(completion: @escaping (Result<UIImage?, Error>) -> Void) {
        if endIndex != ImageLinks.urlString.count {
            for i in ImageLinks.urlString[startIndex...endIndex] {
                guard let url = URL(string: i) else { continue }
                if let cashedImage = imageCache.object(forKey: url.absoluteString as NSString) {
                    completion(.success(cashedImage))
                } else {
                    let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
                    
                    URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                        if let error = error {
                            completion(.failure(error))
                        }
                        if let data = data {
                            guard let self = self else { return }; guard let image = UIImage(data: data) else { return }
                            self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                            completion(.success(image))
                        }
                    } .resume()
                    
                }
            }
        }
    }
    
}


