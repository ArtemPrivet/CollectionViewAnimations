//
//  AnimalsPresenter.swift
//  CustomCollectionLayout
//
//  Created by Орлов Артём on 08/12/2019.
//  Copyright © 2019 Orlov Artem. All rights reserved.
//

protocol IAnimalsPresenter: AnyObject {
    var animalsCount: Int { get }
    var state: State { get }

    func getAnimal(for index: Int) -> AnimalModel
    func didSelectAnimals(index: Int)
    func didLoadView()
}

final class AnimalsPresenter {

    weak var view: IAnimalsView?

    private let repository: IAnimalsRepository
    private var dogs: [AnimalModel] = []
    private var cats: [AnimalModel] = []
    var state: State = .dogs

    init(repository: IAnimalsRepository) {
        self.repository = repository
    }
}

extension AnimalsPresenter: IAnimalsPresenter {
    var animalsCount: Int {
        switch state {
        case .dogs:
           return dogs.count
        case .cats:
           return cats.count
        }
    }

    func getAnimal(for index: Int) -> AnimalModel {
        switch state {
        case .dogs:
           return dogs[index]
        case .cats:
           return cats[index]
        }
    }

    func didLoadView() {
        repository.loadAnimals{ [weak self] animals in
            self?.dogs = animals.dogs
            self?.cats = animals.cats
            self?.view?.reloadDada()
        }
    }

    func didSelectAnimals(index: Int) {
        switch index {
        case 0:
            state = .dogs
        case 1:
            state = .cats
        default:
            assertionFailure()
        }
        view?.reloadDada()
        view?.animateSwitchCollections()
    }
}
