//
//  Reactive+UIControl.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/16/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base : UIControl {
    
    public var backgroundColor : Binder<UIColor> {
        return Binder(self.base) { control, color in
            control.backgroundColor = color
        }
    }
}
