//
//  AnimalsRepository.swift
//  CustomCollectionLayout
//
//  Created by Орлов Артём on 08/12/2019.
//  Copyright © 2019 Orlov Artem. All rights reserved.
//

protocol IAnimalsRepository: AnyObject {
    func loadAnimals(completion: @escaping ((dogs: [AnimalModel], cats: [AnimalModel])) -> Void)
}

final class AnimalsRepository {
    private let dogs = Array(repeating: AnimalModel(name: "Corgi", image: #imageLiteral(resourceName: "bestDog")),
                                count: 100)
    private let cats = Array(repeating: AnimalModel(name: "Cat", image: #imageLiteral(resourceName: "cat")),
                             count: 111)
}

extension AnimalsRepository: IAnimalsRepository {
    func loadAnimals(completion: @escaping ((dogs: [AnimalModel], cats: [AnimalModel])) -> Void) {
        completion((dogs, cats))
    }
}
