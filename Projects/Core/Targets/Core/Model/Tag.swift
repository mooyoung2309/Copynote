//
//  Tag.swift
//  Core
//
//  Created by 송영모 on 2023/03/14.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import RealmSwift

public struct Tag: Equatable, Identifiable {
    public var id: String
    public var title: String
    public var colorHex: String
    
    public init(id: String, title: String, colorHex: String) {
        self.id = id
        self.title = title
        self.colorHex = colorHex
    }
    
    func toRealm() -> TagRealm {
        return .init(id: id, title: title, colorHex: colorHex)
    }
}

public class TagRealm: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var title: String = ""
    @Persisted var colorHex: String = ""
    
    convenience init(id: String, title: String, colorHex: String) {
        self.init()
        
        self.id = id
        self.title = title
        self.colorHex = colorHex
    }
    
    func toDomain() -> Tag {
        return .init(id: id, title: title, colorHex: colorHex)
    }
}

// MARK: - Mock data

extension Tag {
    public static let mock = Self(
        id: UUID().uuidString,
        title: "🌎",
        colorHex: "#5FD8FF"
    )
    
    public static let mocks = [
        Self(
            id: UUID().uuidString,
            title: "🌎",
            colorHex: "#5FD8FF"
        ),
        Self(
            id: UUID().uuidString,
            title: "🥺",
            colorHex: "#00FF00"
        ),
        Self(
            id: UUID().uuidString,
            title: "🚀",
            colorHex: "#0000FF"
        ),
        Self(
            id: UUID().uuidString,
            title: "⛏️",
            colorHex: ""
        ),
    ]
}

