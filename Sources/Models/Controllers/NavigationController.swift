//
//  NavigationController.swift
//  IBDecodable
//
//  Created by phimage on 02/04/2018.
//

import SWXMLHash

public struct NavigationController: XMLDecodable, KeyDecodable, ViewControllerProtocol {

    public let elementClass: String = "UINavgigationController"
    public let id: String
    public let customClass: String?
    public let customModule: String?
    public let customModuleProvider: String?
    public var storyboardIdentifier: String?
    public let layoutGuides: [ViewControllerLayoutGuide]?
    public let userDefinedRuntimeAttributes: [UserDefinedRuntimeAttribute]?
    public let connections: [AnyConnection]?
    public let tabBarItem: TabBar.TabBarItem?
    public let navigationBar: NavigationBar?
    public var rootView: ViewProtocol? { return navigationBar }

    static func decode(_ xml: XMLIndexer) throws -> NavigationController {
        let container = xml.container(keys: CodingKeys.self)
        return NavigationController(
            id:                   try container.attribute(of: .id),
            customClass:          container.attributeIfPresent(of: .customClass),
            customModule:         container.attributeIfPresent(of: .customModule),
            customModuleProvider: container.attributeIfPresent(of: .customModuleProvider),
            storyboardIdentifier: container.attributeIfPresent(of: .storyboardIdentifier),
            layoutGuides:         xml.byKey("layoutGuides")?.byKey("viewControllerLayoutGuide")?.all.flatMap(decodeValue),
            userDefinedRuntimeAttributes: xml.byKey("userDefinedRuntimeAttributes")?.children.flatMap(decodeValue),
            connections:          xml.byKey("connections")?.children.flatMap(decodeValue),
            tabBarItem:           xml.byKey("tabBarItem").flatMap(decodeValue),
            navigationBar:                 xml.byKey("navigationBar").flatMap(decodeValue)
        )
    }
}
