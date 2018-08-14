//
//  AutomaticDisposeCompatibleExtensions.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import RxSwift
import RxCocoa

extension AutomaticDisposeCompatible where Self : NSObject {
    var disposeBag: DisposeBag {
        get {
            return associatedObject(base: self, key: &AssociatedObjectKeys.disposeBagKey)
            { return DisposeBag() }
        }
        set {
            associateObject(base: self, key: &AssociatedObjectKeys.disposeBagKey, value: newValue)
        }
    }
}
