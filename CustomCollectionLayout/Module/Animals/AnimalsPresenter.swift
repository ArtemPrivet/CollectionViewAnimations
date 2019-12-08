//
//  AnimalsPresenter.swift
//  CustomCollectionLayout
//
//  Created by Орлов Артём on 08/12/2019.
//  Copyright © 2019 Orlov Artem. All rights reserved.
//

protocol IAnimalsPresenter: AnyObject {
    var animalsCount: Int { get }

    func getAnimal(for index: Int) -> AnimalModel
    func didLoadView()
}

final class AnimalsPresenter {

    weak var view: IAnimalsView?

    private let repository: IAnimalsRepository
    private var animals: [AnimalModel] = []

    init(repository: IAnimalsRepository) {
        self.repository = repository
    }
}

extension AnimalsPresenter: IAnimalsPresenter {
    var animalsCount: Int {
        animals.count
    }

    func getAnimal(for index: Int) -> AnimalModel {
        animals[index]
    }

    func didLoadView() {
        repository.loadAnimals { [weak self] animals in
            self?.animals = animals
            self?.view?.reloadDada()
        }
    }
}
