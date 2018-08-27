//
//  Disposable+Extension.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/16/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import RxSwift

extension Disposable {
    func lifeTime(_ object: DisposeBagOwner) {
        self.disposed(by: object.disposeBag)
    }
}
