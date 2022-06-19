//
//  SceneDelegate.swift
//  Drom
//
//  Created by Vadim Voronkov on 19.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblyModelBuilder()
        let router = Router(navigationContoller: navigationController, assemblyBuilder: assemblyBuilder)
        router.initialViewContoller()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
    }
    
}

