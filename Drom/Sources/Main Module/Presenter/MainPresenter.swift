//
//  MainPresenter.swift
//  Drom
//
//  Created by Vadim Voronkov on 19.06.2022.
//

import Foundation

protocol MainVCProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainVCPresenterProtocol: AnyObject {
    init(view: MainVCProtocol, networkService: NetworkServiceProtocol)
    func fetchData()
    func refreshData()
}

final class MainVCPresenter: MainVCPresenterProtocol {
    
    var networkService: NetworkServiceProtocol
    weak var view: MainVCProtocol?
    
    required init(view: MainVCProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.fetchData()
    }
    
    func fetchData() {
        self.networkService.fetchResults { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                guard let image = image else { return }
                ImageModel.images.append(ImageModel(image: image))
                self.changeIndices()
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func changeIndices() {
        if self.networkService.endIndex < ImageLinks.urlString.count {
            self.networkService.startIndex = self.networkService.endIndex
            self.networkService.endIndex += 1
            self.view?.success()
        }
    }
    
    func refreshData() {
        self.networkService.startIndex = 0
        self.networkService.endIndex = 1
        self.fetchData()
    }
    
}
