//
//  URLScheme.swift
//  APIClient
//
//  Created by umair irfan on 25/06/2023.
//

import Foundation


// TODO: Define URL Schemes Mechanism

public var BaseURL: URL = {
    if let urlString = Bundle(for: WebClient.self).object(forInfoDictionaryKey: "BaseURL") as? String,
        let url = URL(string: urlString) {
        return url
    } else {
        fatalError("Base URL not found.")
    }
}()

public var APIKey: String = {
    if let apiKey = Bundle(for: MovieService.self).object(forInfoDictionaryKey: "APIKey") as? String {
        return apiKey
    } else {
        fatalError("APIKey Not found")
    }
}()

public var PosterPath: String = {
    if let apiKey = Bundle(for: MovieService.self).object(forInfoDictionaryKey: "PosterURL") as? String {
        return apiKey
    } else {
        fatalError("PosterURL Not found")
    }
}()

public var BackdropPath: String = {
    if let apiKey = Bundle(for: MovieService.self).object(forInfoDictionaryKey: "BackdropURL") as? String {
        return apiKey
    } else {
        fatalError("PosterURL Not found")
    }
}()


