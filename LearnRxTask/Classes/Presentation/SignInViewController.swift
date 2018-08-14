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

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewModel = SignInViewModel(
            input: (
                email: emailTextField.rx.text.orEmpty.asDriver().debug("email"),
                password: passwordTextField.rx.text.orEmpty.asDriver().debug("password"),
                signInTaps: signInButton.rx.tap.asDriver().debug("signIn")
            ),
            dependency: (
                API: ApiServiceFactory.default(),
                validationService: SignInValidationServiceFactory.default())
        )

        viewModel.signInEnabled.drive(onNext: { [weak self] enabled in
            self?.signInButton.isEnabled = enabled
            self?.signInButton.alpha = enabled ? 1 : 0.5
        }).disposed(by: disposeBag)

        viewModel.validatedEmail.skip(1).drive(onNext: { [weak self] result in
            self?.emailTextField.backgroundColor = result.isValid ? UIColor.clear : UIColor.red
        }).disposed(by: disposeBag)

        viewModel.validatedPassword.skip(1).drive(onNext: { [weak self] result in
            self?.passwordTextField.backgroundColor = result.isValid ? UIColor.clear : UIColor.red
        }).disposed(by: disposeBag)

        viewModel.signedIn.drive(onNext: { [weak self] signedIn in
            let alert = UIAlertController(
                title: nil,
                message: "Sign In successful",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)

        }).disposed(by: disposeBag)
    }
}
