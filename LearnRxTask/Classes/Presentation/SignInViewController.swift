//
//  SignInViewController.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController, AutomaticDisposeCompatible {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewModel = SignInViewModel(
            input: (
                email: emailTextField.rx.text.orEmpty.asDriver().debug(),
                password: passwordTextField.rx.text.orEmpty.asDriver().debug(),
                signInTaps: signInButton.rx.tap.asDriver().debug()
            ),
            API: ApiServiceFactory.default()
        )

        viewModel.signInEnabled.debug().drive(onNext: { [weak self] enabled in
            self?.signInButton.isEnabled = enabled
            self?.signInButton.alpha = enabled ? 1 : 0.5
        }).lifeTime(until: self)

        viewModel.validatedEmail.skip(1).debug().drive(onNext: { [weak self] result in
            self?.emailTextField.backgroundColor = result.isValid ? UIColor.clear : UIColor.red
        }).lifeTime(until: self)

        viewModel.validatedPassword.skip(1).debug().drive(onNext: { [weak self] result in
            self?.passwordTextField.backgroundColor = result.isValid ? UIColor.clear : UIColor.red
        }).lifeTime(until: self)

        viewModel.signedIn.drive(onNext: { [weak self] signedIn in
            let alert = UIAlertController(
                title: nil,
                message: "Sign In successful",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)

        }).lifeTime(until: self)
    }
}


