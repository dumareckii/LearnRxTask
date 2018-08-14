//
//  AutomaticDisposeCompatible.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import RxSwift
import RxCocoa

protocol AutomaticDisposeCompatible {
    var disposeBag: DisposeBag { get }
}
