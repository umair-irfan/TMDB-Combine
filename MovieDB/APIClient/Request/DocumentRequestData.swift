//
//  DocumentConvertible.swift
//  APIClient
//
//  Created by umair irfan on 25/06/2023.
//

import Foundation


public protocol DocumentDataConvertible: Codable {
    var data: Data { get }
    var name: String { get }
    var fileName: String { get }
    var mimeType: String { get }
}

public struct DocumentRequestData: DocumentDataConvertible {
    public var data: Data
    public var name: String
    public var fileName: String
    public var mimeType: String
}
