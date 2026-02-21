//
//  UICollectionView+Extensions.swift
//  WeatherApp
//
//  Created by Александр Иванов on 21.02.2026.
//

import UIKit

extension UICollectionView {

    func register<Cell: UICollectionViewCell>(_ type: Cell.Type) {
        register(type, forCellWithReuseIdentifier: String(describing: Cell.self))
    }

    func dequeue<Cell: UICollectionViewCell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
    }
}
