//
//  DisposeBagOwner.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import RxSwift

private let disposeBagAssociation = Association(policy: .OBJC_ASSOCIATION_RETAIN)

protocol DisposeBagOwner {
    var disposeBag: DisposeBag { get }
}

extension DisposeBagOwner where Self: AnyObject {

    var disposeBag: DisposeBag {
        return disposeBagAssociation.lazyGet(base: self, initialiser: DisposeBag.init)
    }
}
