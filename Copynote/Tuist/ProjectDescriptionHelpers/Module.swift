//
//  Module.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/06.
//

import ProjectDescription

public enum Module: String, CaseIterable {
    case application = "Application"
    case feature = "Feature"
    case core = "Core"
    case ui = "UI"
    case utils = "Utils"
    
    public var project: Project {
        return .init(
            name: self.rawValue,
            organizationName: self.organizationName,
            settings: self.settings,
            targets: self.subModules.map { $0.target }
        )
    }
    
    public var path: Path {
        return .relativeToRoot("Projects/\(self.rawValue)")
    }
    
    private var name: String {
        return "Copynote"
    }
    
    private var organizationName: String {
        return "Copynote"
    }
    
    private var subModules: [SubModule] {
        switch self {
        case .application: return [.app, .keyboard]
        case .feature: return [.feature]
        case .core: return [.core]
        case .ui: return [.ui]
        case .utils: return [.utils]
        }
    }
    
    private var settings: Settings {
        switch self {
//        case .application:
//            return .settings(configurations: [
//                .debug(
//                    name: "Debug",
//                    xcconfig: .relativeToRoot("Targets/App/Config/Debug.xcconfig")
//                ),
//                .release(
//                    name: "Release",
//                    xcconfig: .relativeToRoot("Targets/App/Config/Release.xcconfig")
//                )
//            ])
        case .application, .feature, .core, .ui, .utils: return .settings(base: .init())
        }
    }
}

private enum SubModule: String, CaseIterable {
    case app = "App"
    case keyboard = "Keyboard"
    case feature = "Feature"
    case core = "Core"
    case ui = "UI"
    case utils = "Utils"
    
    public var target: Target {
        Target.make(
            appName: self.appName,
            targetName: self.rawValue,
            platform: .iOS,
            product: self.product,
            deploymentTarget: self.deploymentTarget,
            infoPlist: self.infoPlist,
            dependencies: self.dependencies)
    }
    
    private var module: Module {
        switch self {
        case .app, .keyboard: return .application
        case .feature: return .feature
        case .core: return .core
        case .ui: return .ui
        case .utils: return .utils
        }
    }
    
    private var appName: String {
        return "Copynote"
    }
    
    private var deploymentTarget: DeploymentTarget {
        return .iOS(targetVersion: "15.0", devices: [.iphone])
    }
    
    private var product: Product {
        switch self {
        case .app: return .app
        case .keyboard: return .appExtension
        case .feature, .core, .ui, .utils: return .framework
        }
    }
    
    private var infoPlist: InfoPlist {
        switch self {
        case .app:
            return .extendingDefault(with: [
                "CFBundleShortVersionString": "1.0",
                "CFBundleVersion": "1",
                "UILaunchStoryboardName": "LaunchScreen",
                "UIApplicationSceneManifest": [
                    "UIApplicationSupportsMultipleScenes": false,
                    "UISceneConfigurations": []
                ],
                "UIAppFonts": [
                    "Item 0": "Pretendard-Medium.otf",
                    "Item 1": "Pretendard-Regular.otf",
                    "Item 2": "Pretendard-SemiBold.otf",
                    "Item 3": "Pretendard-Bold.otf",
                    "Item 4": "Happiness-Sans-Regular.otf",
                    "Item 5": "Happiness-Sans-SemiBold.otf",
                    "Item 6": "Happiness-Sans-Bold.otf"
                ]
            ])
        case .keyboard:
            return .extendingDefault(with: [
                "NSExtension": [
                    "NSExtensionAttributes": [
                        "IsASCIICapable": false,
                        "PrefersRightToLeft": false,
                        "PrimaryLanguage": "en-US",
                        "RequestsOpenAccess": false
                    ],
                    "NSExtensionPointIdentifier": "com.apple.keyboard-service",
                    "NSExtensionPrincipalClass": "$(PRODUCT_MODULE_NAME).KeyboardViewController"
                ],
                "CFBundleDisplayName": "KeyboardExtension"
            ])
        case .feature, .core, .ui, .utils: return .default
        }
    }
    
    private var dependencies: [TargetDependency] {
        switch self {
        case .app:
            return [
                .project(target: SubModule.feature.rawValue, path: SubModule.feature.module.path),
                .project(target: SubModule.core.rawValue, path: SubModule.core.module.path),
                .project(target: SubModule.ui.rawValue, path: SubModule.ui.module.path),
                .project(target: SubModule.utils.rawValue, path: SubModule.utils.module.path),
                .external(name: "RealmSwift"),
                .external(name: "Realm"),
                .external(name: "ComposableArchitecture"),
            ]
        case .keyboard:
            return [
                .project(target: SubModule.feature.rawValue, path: SubModule.feature.module.path),
                .project(target: SubModule.core.rawValue, path: SubModule.core.module.path),
                .project(target: SubModule.ui.rawValue, path: SubModule.ui.module.path),
                .project(target: SubModule.utils.rawValue, path: SubModule.utils.module.path),
                .external(name: "RealmSwift"),
                .external(name: "Realm"),
                .external(name: "ComposableArchitecture"),
            ]
        case .feature:
            return [
                .project(target: SubModule.core.rawValue, path: SubModule.core.module.path),
                .external(name: "RealmSwift"),
                .external(name: "Realm"),
                .external(name: "ComposableArchitecture"),
            ]
        case .core:
            return [
                .project(target: SubModule.utils.rawValue, path: SubModule.utils.module.path),
                .external(name: "RealmSwift"),
                .external(name: "Realm"),
                .external(name: "ComposableArchitecture"),
            ]
        case .ui:
            return [
                .project(target: SubModule.utils.rawValue, path: SubModule.utils.module.path),
                .external(name: "RealmSwift"),
                .external(name: "Realm"),
                .external(name: "ComposableArchitecture"),
            ]
        case .utils:
            return [
                
            ]
        }
    }
}
