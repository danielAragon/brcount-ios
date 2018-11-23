//
//  Network.swift
//  brcount
//
//  Created by Daniel Aragon Ore on 11/10/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation

class BetterRideApi{
    static private let baseUrl = "https://srv-desa.eastus2.cloudapp.azure.com/appbetterride/api/v1"
    static private let getSessionsUrl = "\(baseUrl)/userSession"
    static private let postCountingItemsUrl = "\(baseUrl)/countItem"
    static let getOperatorUrl = "\(baseUrl)/users"
    static let setOperatorUrl = "\(baseUrl)/operators"

    
    
    static func handleError(error: Error){
        print("Error while requesting Data: \(error.localizedDescription)")
    }
    
    static private func get<T: Decodable>(
        urlString: String,
        headers: [String: String],
        responseType: T.Type,
        responseHandler: @escaping ((T)-> (Void))){
            var request = URLRequest(url: URL(string: urlString)!)
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            for (key,val) in headers{
                request.addValue(val, forHTTPHeaderField: key)
            }
            let task = URLSession.shared.dataTask(with: request){
                (data, response, error) in
                guard
                    let data = data,
                    let httpResponse = response as? HTTPURLResponse,
                    error == nil,
                    httpResponse.statusCode == 200
                    else {
                        print((response as? HTTPURLResponse)!.statusCode)
                        return
                }
                do {
                    let dataResponse = try JSONDecoder().decode(responseType, from: data)
                    print(dataResponse)
                    DispatchQueue.main.async { responseHandler(dataResponse) }
                }catch{
                    print(error)
                }
            }
            task.resume()

    }
    
    static private func post<T: Decodable>(
        urlString: String,
        headers: [String: String],
        body: Codable,
        responseType: T.Type,
        responseHandler: @escaping ((T)-> (Void))){
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        for (key,val) in headers{
            request.addValue(val, forHTTPHeaderField: key)
        }
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            guard
                let data = data,
                let httpResponse = response as? HTTPURLResponse,
                error == nil,
                httpResponse.statusCode == 200
                else {
                    print((response as? HTTPURLResponse)!.statusCode)
                    return
            }
            let dataString = String(data: data, encoding: String.Encoding.utf8)
            print("\(dataString!)")
        }
        task.resume()
        
    }
    
    static func getSessions(operatorId: Int, status: SessionStatus,responseHandler: @escaping (SessionResponse) -> (Void)){
        let headers = ["token": "FG5325YGJM35"]
        self.get(urlString: "\(getSessionsUrl)/\(operatorId)/status/\(status.rawValue)",
                 headers: headers,
                 responseType: SessionResponse.self,
                 responseHandler: responseHandler)
    }
    static func getOperator(operatorId: Int ,responseHandler: @escaping (OperatorResponse) -> (Void)){
        let headers = ["token": "FG5325YGJM35"]
        self.get(urlString: "\(getOperatorUrl)/\(operatorId)",
            headers: headers,
            responseType: OperatorResponse.self,
            responseHandler: responseHandler)
    }
    static func setOperator(operatorId: Int, with body: Operator){
        let headers = ["token": "FG5325YGJM35"]
        self.post(urlString: setOperatorUrl,
                  headers: headers,
                  body: body,
                  responseType: Operator.self,
                  responseHandler: {_ in })
    }
    static func postCountingItems(with body: [CountingItem]){
        let headers = ["token": "FG5325YGJM35"]
        self.post(urlString: self.postCountingItemsUrl,
                  headers: headers, body: body,
                  responseType: CountingItem.self,
                  responseHandler: { _ in })
    }
}
