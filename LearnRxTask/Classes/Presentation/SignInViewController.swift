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

class SignInViewController: UIViewController, LifeTimeDisposeCompatible {
    
    let viewNibName = "SignInView"

    var rootView: SignInView? {
        return self.viewIfLoaded as? SignInView
    }

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
        let viewModel = SignInViewModel(
            input: (
                email: rootView?.emailTextField?.rx.text.orEmpty.asDriver().debug(),
                password: rootView?.passwordTextField?.rx.text.orEmpty.asDriver().debug(),
                signInTaps: rootView?.signInButton?.rx.tap.asDriver().debug()
            ),
            API: ApiServiceFactory.default()
        )
        
        viewModel.signInEnabled.debug().drive(onNext: { [weak self] enabled in
            self?.rootView?.signInButton?.isEnabled = enabled
            self?.rootView?.signInButton?.alpha = enabled ? 1 : 0.5
        }).lifeTime(self)
        
        viewModel.validatedEmail.skip(1).debug().drive(onNext: { [weak self] result in
            self?.rootView?.emailTextField?.backgroundColor = result.isValid ? UIColor.clear : UIColor.red
        }).lifeTime(self)
        
        viewModel.validatedPassword.skip(1).debug().drive(onNext: { [weak self] result in
            self?.rootView?.passwordTextField?.backgroundColor = result.isValid ? UIColor.clear : UIColor.red
        }).lifeTime(self)
        
        viewModel.signedIn.drive(onNext: { [weak self] signedIn in
            self?.showAlert(
                alertConfig: (
                    title: nil,
                    message: TextConstants.PopupConstants.signInSuccessful,
                    preferredStyle: .alert),
                actionConfig: (
                    title: TextConstants.PopupConstants.actionOk,
                    style: .cancel))
        }).lifeTime( self)
    }
}


