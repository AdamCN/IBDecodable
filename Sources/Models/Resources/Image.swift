//
//  Image.swift
//  IBDecodable
//
//  Created by phimage on 01/04/2018.
//

import SWXMLHash

public struct Image: XMLDecodable, KeyDecodable, ResourceProtocol {
    public let name: String
    public let width: String
    public let height: String
    public let mutableData: MutableData?

    static func decode(_ xml: XMLIndexer) throws -> Image {
        let container = xml.container(keys: CodingKeys.self)
        return Image(
            name:          try container.attribute(of: .name),
            width:         try container.attribute(of: .width),
            height:        try container.attribute(of: .height),
            mutableData:   xml.byKey("mutableData").flatMap(decodeValue))
    }
}

public struct MutableData: XMLDecodable, KeyDecodable {
    public let key: String
    public let content: String?

    static func decode(_ xml: XMLIndexer) throws -> MutableData {
        let container = xml.container(keys: CodingKeys.self)
        return MutableData(
            key:      try container.attribute(of: .key),
            content:  xml.element?.text)
    }
}
