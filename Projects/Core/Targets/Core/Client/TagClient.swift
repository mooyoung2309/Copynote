//
//  TagClient.swift
//  Core
//
//  Created by 송영모 on 2023/03/14.
//  Copyright © 2023 Copynote. All rights reserved.
//

import ComposableArchitecture

public struct TagClient {
    public var fetchTagItems: () -> [Tag]
}

extension TagClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchTagItems: { Tag.mocks }
    )
    
    public static let testValue = Self(
        fetchTagItems: unimplemented("\(Self.self).fetchTagItems")
    )
}

extension DependencyValues {
    public var tagClient: TagClient {
        get { self[TagClient.self] }
        set { self[TagClient.self] = newValue }
    }
}

extension TagClient: DependencyKey {
    public static let liveValue = TagClient(
        fetchTagItems: {
            return Tag.mocks
        }
    )
}
