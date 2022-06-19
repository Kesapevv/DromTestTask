//
//  AssemblyBuilder.swift
//  Drom
//
//  Created by Vadim Voronkov on 19.06.2022.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createMainVC(router: RouterProtocol) -> UIViewController
}

final class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    func createMainVC(router: RouterProtocol) -> UIViewController {
        let view = MainVC()
        let networkService = NetworkService()
        let presenter = MainVCPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
}
