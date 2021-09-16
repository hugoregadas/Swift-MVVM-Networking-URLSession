//
//  Service.swift
//  URLSession_NetWorking
//
//  Created by Hugo Regadas on 10/09/2021.
//

import Foundation

enum ServiceError: Error {
    case badResponse
    case badStatusCode(Int)
    case badData
}

class Service{
    static let shared = Service()
    let configuration: URLSessionConfiguration
    let session: URLSession
    private var imageCache = NSCache <NSString, NSData>()
    
    private init() {
        //2 : Url configuration
        configuration = URLSessionConfiguration.default
        //3 : UrlSession
        session = URLSession(configuration: configuration)
    }
    
    func getDataFromService (completion: @escaping (ItemsObject?, Error?) -> (Void)) {
        //1 : Url Request
        var urlComponents = URLComponents(string: "https://5bb1cd166418d70014071c8e.mockapi.io/mobile/1-1/articles")!
        urlComponents.queryItems = [URLQueryItem(name: "page", value: "1"),
                                      URLQueryItem(name: "limit", value: "5")]

        let url = urlComponents.url
        
        guard let url = url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //4 : Url Task
        let task = session.dataTask(with: request) {data,response,error in
            //1 : error
            if let error = error{
                completion(nil, error)
                return
            }
            
            //2 : response
            guard let response = response as? HTTPURLResponse else {
                completion(nil, error)
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(nil, ServiceError.badStatusCode(response.statusCode))
                return
            }
            
            //3 : data
            guard let data = data else {
                completion(nil, ServiceError.badData)
                return
            }
            
            do {
                let itens = try JSONDecoder().decode(ItemsObject.self, from: data)
                completion(itens,nil)
            }catch let error{
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    
    func getImageWith(url urlImage: URL, idFile: String, completion: @escaping (_ data: Data?, Error?) -> Void){
       
        if let imageDate = self.imageCache.object(forKey: idFile as NSString){
            print("Cache")
            completion(imageDate as Data, nil)
            return
        }
        
        //1 url
        let urlRequest = URLRequest(url: urlImage)
        //4 session taks
        let taks = session.downloadTask(with: urlRequest) { localURL, response, error in
            //1 erro
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
                return
            }
            
            //2 response
            guard let response = response as? HTTPURLResponse else {
                completion(nil, error)
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(nil, ServiceError.badStatusCode(response.statusCode))
                return
            }
            
            //3 data
            guard let localURL = localURL else{
                completion(nil, ServiceError.badData)
                return
            }
            
            do {
                let data = try Data(contentsOf: localURL)
                self.imageCache.setObject(data as NSData, forKey: idFile as NSString)
                completion(data, nil)

            }catch let error{
                completion(nil,error)
            }
            
        }
        
        taks.resume()
    }
}

// https://www.youtube.com/watch?v=dND9iNMzeKs
