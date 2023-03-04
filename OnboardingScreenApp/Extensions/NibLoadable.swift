//
//  NibLoadable.swift
//  OnboardingScreenApp
//
//  Created by Aykhan Hajiyev on 04.03.23.
//

import UIKit

protocol NibLoadable: AnyObject {
    static var nib: UINib { get }
    static var identifier: String { get }
}

extension NibLoadable {
    static var nibName: String {
        String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension NibLoadable where Self: UIView {
    static func loadNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}

