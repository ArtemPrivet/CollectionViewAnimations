//
//  ViewController.swift
//  CustomCollectionLayout
//
//  Created by Орлов Артём on 03/12/2019.
//  Copyright © 2019 Orlov Artem. All rights reserved.
//

import UIKit

protocol IAnimalsView: AnyObject {
    func reloadDada()
    func animateSwitchCollections()
}

class AnimalsViewController: UIViewController {

    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    private let presenter: IAnimalsPresenter
    private lazy var segmentedControl: SegmentedControl = {
        let items = ["Dogs", "Cats"]
        let control = SegmentedControl(items: items)
        control.didChangeIndex = { [weak self] index in
            self?.presenter.didSelectAnimals(index: index)
        }
        return control
    }()

    private lazy var blurView: UIView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeImage))
        blurEffectView.addGestureRecognizer(tapGesture)
        return blurEffectView
    }()

    private lazy var animalImageView = AnimalImageView()
    private let animationDuration: TimeInterval = 0.5

    private var initialImageFrame: CGRect = .null

    init(presenter: IAnimalsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupCollectionView()
        presenter.didLoadView()
        title = "PetWorld"
        collectionView.backgroundColor = .white
    }
}

extension AnimalsViewController: IAnimalsView {
    func reloadDada() {
        collectionView.reloadData()
    }

    func animateSwitchCollections() {
        collectionView.layoutIfNeeded()
        let indexies = collectionView.indexPathsForVisibleItems.sorted()
        let cells = indexies.compactMap { collectionView.cellForItem(at: $0) }
        for (index, cell) in cells.enumerated() {
            let initialX = cell.frame.origin.x
            switch self.presenter.state {
            case .dogs:
                cell.frame.origin.x = cell.frame.origin.x - collectionView.bounds.width
            case .cats:
                cell.frame.origin.x = cell.frame.origin.x + collectionView.bounds.width
            }
            UIView.animate(withDuration: 0.5, delay: 0.1 * Double(index), options: .curveEaseInOut, animations: {
                cell.frame.origin.x = initialX
            }, completion: nil)
        }
    }
}

extension AnimalsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.animalsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimalsCollectionCell.identifier, for: indexPath) as! AnimalsCollectionCell
        let model = presenter.getAnimal(for: indexPath.item)
        cell.set(model: model)
        return cell
    }

}

extension AnimalsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 20)) / 3
        return CGSize(width: itemSize, height: itemSize * 2)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let attributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        guard let cell = collectionView.cellForItem(at: indexPath) as? AnimalsCollectionCell else { return }
        let model = presenter.getAnimal(for: indexPath.item)
        let frame = collectionView.convert(attributes.frame, to: collectionView.superview)
        let imageFrame = CGRect(x: frame.origin.x,
                                y: frame.origin.y,
                                width: cell.imageBounds.width,
                                height: cell.imageBounds.height)
        showFullImage(model.image, from: imageFrame)
    }
}

private extension AnimalsViewController {
    func configureViews() {
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AnimalsCollectionCell.self,
                                forCellWithReuseIdentifier: AnimalsCollectionCell.identifier)
    }

    func showFullImage(_ image: UIImage, from frame: CGRect) {
        animalImageView.image = image
        animalImageView.frame = frame
        initialImageFrame = frame

        view.addSubview(blurView)
        view.addSubview(animalImageView)
        blurView.alpha = 0

        UIView.animate(withDuration: animationDuration) {
            self.animalImageView.center = self.view.center
            self.animalImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.blurView.alpha = 1
        }
    }

    @objc
    func removeImage() {
        UIView.animate(withDuration: animationDuration, animations: {
            self.blurView.alpha = 0
            self.animalImageView.frame = self.initialImageFrame
        }) { _ in
            self.blurView.removeFromSuperview()
            self.animalImageView.removeFromSuperview()
            self.animalImageView.transform = CGAffineTransform.identity
        }
    }
}

