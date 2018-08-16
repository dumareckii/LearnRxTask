//
//  UIViewController+Extension.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/16/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(
        alertConfig: (
            title: String?,
            message: String?,
            preferredStyle: UIAlertControllerStyle),
        actionConfig: (
            title: String?,
            style: UIAlertActionStyle),
        actionHandler: ((UIAlertAction) -> ())? = nil
    ) {
        let alert = UIAlertController(
            title: alertConfig.title,
            message: alertConfig.message,
            preferredStyle: alertConfig.preferredStyle)
        alert.addAction(
            UIAlertAction(
                title: actionConfig.title,
                style: actionConfig.style,
                handler: actionHandler))
        self.present(alert, animated: true, completion: nil)
    }
}
