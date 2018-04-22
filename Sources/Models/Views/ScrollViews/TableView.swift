//
//  TableView.swift
//  IBLinterCore
//
//  Created by SaitoYuta on 3/11/18.
//

import SWXMLHash

// MARK: - TableView

public struct TableView: XMLDecodable, KeyDecodable, ViewProtocol {

    public let id: String
    public let elementClass: String = "UITableView"

    public let alwaysBounceVertical: Bool?
    public let autoresizingMask: AutoresizingMask?
    public let clipsSubviews: Bool?
    public let constraints: [Constraint]?
    public let contentMode: String?
    public let customClass: String?
    public let customModule: String?
    public let dataMode: DataMode?
    public let estimatedRowHeight: Float?
    public let isMisplaced: Bool?
    public let opaque: Bool?
    public let rect: Rect
    public let rowHeight: Float?
    public let sectionFooterHeight: Float?
    public let sectionHeaderHeight: Float?
    public let separatorStyle: String?
    public let style: String?
    public let subviews: [AnyView]?
    public let translatesAutoresizingMaskIntoConstraints: Bool?
    public let userInteractionEnabled: Bool?
    public let userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
    public let connections: [AnyConnection]?
    public let sections: [TableViewSection]?
    public let prototypeCells: [TableViewCell]?

    public enum DataMode: XMLAttributeDecodable, KeyDecodable {
        case `static`, prototypes

        public func encode(to encoder: Encoder) throws { fatalError() }

        static func decode(_ attribute: XMLAttribute) throws -> TableView.DataMode {
            switch attribute.text {
            case "static":     return .static
            case "prototypes": return .prototypes
            default:
                throw IBError.unsupportedTableViewDataMode(attribute.text)
            }
        }
    }

    static func decode(_ xml: XMLIndexer) throws -> TableView {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .isMisplaced: return "misplaced"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }

        return TableView(
            id:                                        try container.attribute(of: .id),
            alwaysBounceVertical:                      container.attributeIfPresent(of: .alwaysBounceVertical),
            autoresizingMask:                          xml.byKey("autoresizingMask").flatMap(decodeValue),
            clipsSubviews:                             container.attributeIfPresent(of: .clipsSubviews),
            constraints:                               xml.byKey("constraints")?.byKey("constraint")?.all.compactMap(decodeValue),
            contentMode:                               container.attributeIfPresent(of: .contentMode),
            customClass:                               container.attributeIfPresent(of: .customClass),
            customModule:                              container.attributeIfPresent(of: .customModule),
            dataMode:                                  container.attributeIfPresent(of: .dataMode),
            estimatedRowHeight:                        container.attributeIfPresent(of: .estimatedRowHeight),
            isMisplaced:                               container.attributeIfPresent(of: .isMisplaced),
            opaque:                                    container.attributeIfPresent(of: .opaque),
            rect:                                      try decodeValue(xml.byKey("rect")),
            rowHeight:                                 container.attributeIfPresent(of: .rowHeight),
            sectionFooterHeight:                       container.attributeIfPresent(of: .sectionFooterHeight),
            sectionHeaderHeight:                       container.attributeIfPresent(of: .sectionHeaderHeight),
            separatorStyle:                            container.attributeIfPresent(of: .separatorStyle),
            style:                                     container.attributeIfPresent(of: .style),
            subviews:                                  xml.byKey("subviews")?.children.compactMap(decodeValue),
            translatesAutoresizingMaskIntoConstraints: container.attributeIfPresent(of: .translatesAutoresizingMaskIntoConstraints),
            userInteractionEnabled:                    container.attributeIfPresent(of: .userInteractionEnabled),
            userDefinedRuntimeAttributes:              xml.byKey("userDefinedRuntimeAttributes")?.children.compactMap(decodeValue),
            connections:                               xml.byKey("connections")?.children.compactMap(decodeValue),
            sections:                                  xml.byKey("sections")?.children.compactMap(decodeValue),
            prototypeCells:                            xml.byKey("prototypes")?.children.compactMap(decodeValue)
        )
    }
}

// MARK: - TableViewSection

public struct TableViewSection: XMLDecodable, KeyDecodable {

    public let id: String
    public let headerTitle: String?
    public let footerTitle: String?
    public let colorLabel: String?
    public let cells: [TableViewCell]?
    public let userComments: AttributedString?

    static func decode(_ xml: XMLIndexer) throws -> TableViewSection {
        assert(xml.element?.name == "tableViewSection")
        let container = xml.container(keys: CodingKeys.self)
        return TableViewSection(
            id:           try container.attribute(of: .id),
            headerTitle:  container.attributeIfPresent(of: .headerTitle),
            footerTitle:  container.attributeIfPresent(of: .footerTitle),
            colorLabel:   container.attributeIfPresent(of: .colorLabel),
            cells:        xml.byKey("cells")?.children.compactMap(decodeValue),
            userComments: xml.byKey("attributedString")?.withAttribute("key", "userComments").flatMap(decodeValue)
        )
    }
}
// MARK: - TableViewCell

public struct TableViewCell: XMLDecodable, KeyDecodable, ViewProtocol {

    public let id: String
    public let elementClass: String = "UITableView"

    public let autoresizingMask: AutoresizingMask?
    public let clipsSubviews: Bool?
    public let constraints: [Constraint]?
    public let contentView: TableViewContentView
    public let contentMode: String?
    public let customClass: String?
    public let customModule: String?
    public let isMisplaced: Bool?
    public let opaque: Bool?
    public let rect: Rect
    private let _subviews: [AnyView]?
    public var subviews: [AnyView]? {
        return (_subviews ?? []) + [AnyView(contentView)]
    }
    public let translatesAutoresizingMaskIntoConstraints: Bool?
    public let userInteractionEnabled: Bool?
    public let userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
    public let connections: [AnyConnection]?

    public struct TableViewContentView: XMLDecodable, KeyDecodable, ViewProtocol {
        public let id: String
        public let elementClass: String = "UITableViewContentView"

        public let autoresizingMask: AutoresizingMask?
        public let clipsSubviews: Bool?
        public let constraints: [Constraint]?
        public let contentMode: String?
        public let customClass: String?
        public let customModule: String?
        public let isMisplaced: Bool?
        public let opaque: Bool?
        public let rect: Rect
        public let subviews: [AnyView]?
        public let translatesAutoresizingMaskIntoConstraints: Bool?
        public let userInteractionEnabled: Bool?
        public let userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
        public let connections: [AnyConnection]?

        static func decode(_ xml: XMLIndexer) throws -> TableViewCell.TableViewContentView {
            let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
                let stringValue: String = {
                    switch key {
                    case .isMisplaced: return "misplaced"
                    default: return key.stringValue
                    }
                }()
                return MappedCodingKey(stringValue: stringValue)
            }

            return TableViewContentView(
                id:                                        try container.attribute(of: .id),
                autoresizingMask:                          xml.byKey("autoresizingMask").flatMap(decodeValue),
                clipsSubviews:                             container.attributeIfPresent(of: .clipsSubviews),
                constraints:                               xml.byKey("constraints")?.byKey("constraint")?.all.compactMap(decodeValue),
                contentMode:                               container.attributeIfPresent(of: .contentMode),
                customClass:                               container.attributeIfPresent(of: .customClass),
                customModule:                              container.attributeIfPresent(of: .customModule),
                isMisplaced:                               container.attributeIfPresent(of: .isMisplaced),
                opaque:                                    container.attributeIfPresent(of: .opaque),
                rect:                                      try decodeValue(xml.byKey("rect")),
                subviews:                                  xml.byKey("subviews")?.children.compactMap(decodeValue),
                translatesAutoresizingMaskIntoConstraints: container.attributeIfPresent(of: .translatesAutoresizingMaskIntoConstraints),
                userInteractionEnabled:                    container.attributeIfPresent(of: .userInteractionEnabled),
                userDefinedRuntimeAttributes:              xml.byKey("userDefinedRuntimeAttributes")?.children.compactMap(decodeValue),
                connections:                               xml.byKey("connections")?.children.compactMap(decodeValue)
            )
        }
    }

    static func decode(_ xml: XMLIndexer) throws -> TableViewCell {
        let container = xml.container(keys: MappedCodingKey.self).map { (key: CodingKeys) in
            let stringValue: String = {
                switch key {
                case .isMisplaced: return "misplaced"
                default: return key.stringValue
                }
            }()
            return MappedCodingKey(stringValue: stringValue)
        }

        return TableViewCell(
            id:                                        try container.attribute(of: .id),
            autoresizingMask:                          xml.byKey("autoresizingMask").flatMap(decodeValue),
            clipsSubviews:                             container.attributeIfPresent(of: .clipsSubviews),
            constraints:                               xml.byKey("constraints")?.byKey("constraint")?.all.compactMap(decodeValue),
            contentView:                               try decodeValue(xml.byKey("tableViewCellContentView")),
            contentMode:                               container.attributeIfPresent(of: .contentMode),
            customClass:                               container.attributeIfPresent(of: .customClass),
            customModule:                              container.attributeIfPresent(of: .customModule),
            isMisplaced:                               container.attributeIfPresent(of: .isMisplaced),
            opaque:                                    container.attributeIfPresent(of: .opaque),
            rect:                                      try decodeValue(xml.byKey("rect")),
            _subviews:                                 xml.byKey("subviews")?.children.compactMap(decodeValue),
            translatesAutoresizingMaskIntoConstraints: container.attributeIfPresent(of: .translatesAutoresizingMaskIntoConstraints),
            userInteractionEnabled:                    container.attributeIfPresent(of: .userInteractionEnabled),
            userDefinedRuntimeAttributes:              xml.byKey("userDefinedRuntimeAttributes")?.children.compactMap(decodeValue),
            connections:                               xml.byKey("connections")?.children.compactMap(decodeValue)
        )
    }
}
