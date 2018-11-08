//
//  URLExtensions.swift
//  note
//
//  Created by Arseniy Zorin on 03/11/2018.
//  Copyright © 2018 ArseniyZ. All rights reserved.
//

import Foundation

extension URL{
    func urlwith(_ queries: [String: String]) -> URL?{
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap
            { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

