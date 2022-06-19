//
//  MainVC.swift
//  Drom
//
//  Created by Vadim Voronkov on 19.06.2022.
//

import UIKit

final class MainVC: UIViewController {
    
    //MARK: - Properties
    
    var presenter: MainVCPresenterProtocol?
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    //MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.title = "Drom Auto"
        self.view.backgroundColor = .white
        self.setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupConstraints()
    }
    
    //MARK: - Methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([self.collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     self.collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     self.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
                                     self.collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    //MARK: - View
    
    private func setupViews() {
        self.setupCollectionView()
        self.setupRefreshControl()
    }
    
    private func setupCollectionView() {
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.refreshControl = self.refreshControl
    }
    
    private func setupRefreshControl() {
        self.refreshControl.addTarget(self, action: #selector(self.refreshCollectionView), for: .valueChanged)
    }
    
    //MARK: - Methods
    
    @objc func refreshCollectionView() {
        UIView.animate(withDuration: 0.5) {
            self.collectionView.layer.opacity = 0.0
        } completion: { [weak self] animated in
            guard let self = self else  { return }
            ImageModel.images.removeAll()
            self.collectionView.reloadData()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.presenter?.refreshData()
            UIView.animate(withDuration: 0.5) {
                self.collectionView.layer.opacity = 1.0
            }
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
    }
}

//MARK: - Extension

extension MainVC: MainVCProtocol {
    
    func success() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func failure(error: Error) {
        if ImageModel.images.isEmpty {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Ошибка", message: "Отсутствует интернет/Нет подгруженных раннее картинок", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Загрузить!", style: .default, handler: { [weak self] alert in
                    guard let self = self else { return }
                    self.presenter?.fetchData()
                }))
                self.present(alert, animated: true)
            }
        }
        print(error.localizedDescription)
    }
    
}


