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
import IDPCastable

class SignInViewController: UIViewController, DisposeBagOwner {

    let viewNibName = "SignInView"

    var rootView: SignInView? {
        return cast(self.viewIfLoaded)
    }

    let viewModel = SignInViewModelFactory.default()

    //MARK: - Initializations/Deinitialization

    required public init() {
        super.init(nibName: viewNibName, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("Deinit " + String(describing: type(of: self)))
    }

    //MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: -  Private methods

    private func configure() {

        guard let rootView = rootView else { return }

        let emailTextFieldSignal = rootView.emailTextField.rx.text.orEmpty.asObservable()
        let passwordTextFieldSignal = rootView.passwordTextField.rx.text.orEmpty.asObservable()

        let isValidEmail = validate(signal: emailTextFieldSignal, action: SignInValidator.validateEmail)
        let isValidPassword = validate(signal: passwordTextFieldSignal, action: SignInValidator.validatePassword)

        isValidEmail.map { [weak self] in
            self?.colorFor(state: $0)
        }
            .bind(to: rootView.emailTextField.rx.backgroundColor)
            .lifeTime(self)

        isValidPassword.map { [weak self] in
            self?.colorFor(state: $0)
        }
            .bind(to: rootView.passwordTextField.rx.backgroundColor)
            .lifeTime(self)

        Observable.combineLatest(
            isValidEmail,
            isValidPassword
        ) { $0 && $1 }
            .distinctUntilChanged()
            .bind(to: rootView.signInButton.rx.isEnabled)
            .lifeTime(self)

        let signedIn = rootView.signInButton.rx.tap.asObservable()
            .withLatestFrom (
                Observable.combineLatest(emailTextFieldSignal, passwordTextFieldSignal) { ($0, $1) }
            )
            .flatMapLatest { [weak self] email, password in
                self?.viewModel.signIn(withEmail: email, password: password) ?? Observable.just(false)
            }

        signedIn
            .bind(onNext: { [weak self] isSignedIn in
                guard isSignedIn == true else { return }
                self?.showAlert(
                    alertConfig: (
                        title: nil,
                        message: TextConstants.PopupConstants.signInSuccessful,
                        preferredStyle: .alert),
                    actionConfig: (
                        title: TextConstants.PopupConstants.actionOk,
                        style: .cancel))
            })
            .lifeTime(self)
    }

    private func validate(signal: Observable<String>,
                          action: @escaping (String) -> ValidationResult) -> Observable<Bool> {
        return signal.map {
            action($0).isValid
        }
    }

    private func colorFor(state isValid: Bool) -> UIColor {
        return isValid ? UIColor.clear : UIColor.red
    }

}
