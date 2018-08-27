//
//  Reactive+UIView.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/16/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base : UIView {
    
    public var backgroundColor : Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.backgroundColor = color
        }
    }
}
