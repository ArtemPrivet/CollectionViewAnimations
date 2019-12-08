//
//  AnimalsRepository.swift
//  CustomCollectionLayout
//
//  Created by Орлов Артём on 08/12/2019.
//  Copyright © 2019 Orlov Artem. All rights reserved.
//

protocol IAnimalsRepository: AnyObject {
    func loadAnimals(completion: @escaping ([AnimalModel]) -> Void)
}

final class AnimalsRepository {
    private let animals = Array(repeating: AnimalModel(name: "Corgi", image: #imageLiteral(resourceName: "bestDog")),
                                count: 100)
}

extension AnimalsRepository: IAnimalsRepository {
    func loadAnimals(completion: @escaping ([AnimalModel]) -> Void) {
        completion(animals)
    }
}
