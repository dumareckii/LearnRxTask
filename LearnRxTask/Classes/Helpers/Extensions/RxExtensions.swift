//
//  RxExtensions.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import RxSwift

extension Disposable {
    func lifeTime(_ object: LifeTimeDisposeCompatible) {
        self.disposed(by: object.disposeBag)
    }
}
