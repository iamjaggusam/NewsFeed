//
//  HttpRequest.swift
//  NewsFeed
//
//  Created by JaGgu Sam on 21/07/21.
//

import Foundation

protocol HTTPTaskProtocol {
    func GET(api: String?, config: URLSessionConfiguration?, completionHandler: @escaping ([String: Any], TaskError) -> Void )
}

class HTTPTask: NSObject{
    
    // Function for GET method
    func GET(api: String?,
                         config: URLSessionConfiguration? = nil,
                         completionHandler: @escaping ([String: Any], TaskError) -> Void ) {
        guard let urlAvailable = api else {
            completionHandler([:], .other)
            return}
        let url = URL(string: urlAvailable)!
        sendRequest(url, method: "GET", completionHandler)
    }
    
    // send request with required details
    func sendRequest(_ url: URL, method: String, contentType: ContentType = .json, sessionConfig: URLSessionConfiguration? = nil, _ completionHandler: @escaping ([String: Any], TaskError) -> Void) {
        
        // Prepare urlRequest and establishing the connection.
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.timeoutInterval = 120
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error -> Void in
            guard let jsonData = data, !jsonData.isEmpty else {
                completionHandler([:], .noData)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: AnyObject]
                completionHandler(json ?? [:], .other)
            } catch {
                completionHandler([:], .httpError(code: error.localizedDescription))
            }

            // decoding the JSON data
            // Due to Bad JSON format i am not using Generics
//            do {
//                let decoder = JSONDecoder()
//                let jsonObject = try decoder.decode(T.self, from: jsonData)
//                print(jsonObject)
//                completionHandler(.success(jsonObject, statusCode))
//            } catch {
//                completionHandler(.failure(.jsonError, error.localizedDescription, statusCode))
//                print(error.localizedDescription)
//            }
           
        })
        
        task.resume()
    }
}

enum ContentType: String {
    case json = "application/json"
    case text = "text/plain"
}

//enum Result<T, TaskError> {
//    case success([String: Any], Int?)
//    case failure(TaskError, String, Int?)
//}

enum TaskError: Error {
    case httpError(code: String)
    case reachabilityError
    case jsonError
    case noData
    case other
}
