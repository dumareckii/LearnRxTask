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

        rootView.emailTextField?.rx.text.orEmpty
        .map {
            SignInValidator.validateEmail(email: $0).isValid
        }
        .flatMap {
            rootView.emailTextField?.rx.backgroundColor = $0 ? UIColor.clear : UIColor.red
        }

        let passwordValid = rootView.passwordTextField?.rx.text
            .orEmpty
            .map {
                SignInValidator.validatePassword(password: $0).isValid
            }

        let everythingValid = Observable
                                .combineLatest(emailValid!, passwordValid!) { $0 && $1 }
                                .distinctUntilChanged()

//        emailValid?
//            .skip(1)
//            .bind(to: rootView.emailTextField!.rx.isValid)
//            .lifeTime(self)
//
//        passwordValid?
//            .skip(1)
//            .bind(to: rootView.passwordTextField!.rx.isValid)
//            .lifeTime(self)

        everythingValid
            .bind(to: rootView.signInButton!.rx.isEnabled)
            .lifeTime(self)

        let emailAndPassword = Observable
                                .combineLatest(rootView.emailTextField!.rx.text.orEmpty,
                                               rootView.passwordTextField!.rx.text.orEmpty)
        { ($0, $1) }

        let signedIn = rootView.signInButton?.rx.tap
            .asObservable()
            .withLatestFrom(emailAndPassword)
            .flatMapLatest { [weak self] email, password in
                self?.viewModel.signIn(withEmail: email, password: password)
        }

        signedIn?
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
}
