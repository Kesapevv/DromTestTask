//
//  Router.swift
//  Drom
//
//  Created by Vadim Voronkov on 19.06.2022.
//

import Foundation
import UIKit

protocol RouterMain {
    var navigationContoller: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewContoller()
}

final class Router: RouterProtocol {
    
    var navigationContoller: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationContoller: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationContoller = navigationContoller
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewContoller() {
        if let navigationContoller = navigationContoller {
            guard let mainViewController = assemblyBuilder?.createMainVC(router: self) else { return }
            navigationContoller.viewControllers = [mainViewController]
        }
    }
    
}
