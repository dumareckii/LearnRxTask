//
//  DisposeBagOwner.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import RxSwift

protocol DisposeBagOwner {
    var disposeBag: DisposeBag { get }
}

private struct AssociatedKey {
    static var disposeBagKey: UInt8 = 0
}

extension DisposeBagOwner where Self: AnyObject {

    var disposeBag: DisposeBag {
        return AssociatedObjectHelper.associatedObject(base: self, key: &AssociatedKey.disposeBagKey, initialiser: DisposeBag.init)
    }
}