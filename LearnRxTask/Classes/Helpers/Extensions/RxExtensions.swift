//
//  RxExtensions.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import RxSwift
import RxCocoa

extension Disposable {
    func lifeTime(until object: AutomaticDisposeCompatible) {
        self.disposed(by: object.disposeBag)
    }
}
