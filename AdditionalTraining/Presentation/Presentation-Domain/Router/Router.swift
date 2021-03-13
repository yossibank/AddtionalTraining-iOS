//
//  Router.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/13.
//

import UIKit

typealias VoidBlock = () -> Void

protocol RouterProtocol: AnyObject {

    func push(
        _ route:  Route,
        from:     UIViewController,
        animated: Bool
    )

    func push(
        _ viewController: UIViewController,
        from:             UIViewController,
        animated:         Bool
    )

    func present(
        _ route:                    Route,
        from:                       UIViewController,
        presentationStyle:          UIModalPresentationStyle,
        wrapInNavigationController: Bool,
        animated:                   Bool,
        completion:                 VoidBlock?
    )

    func present(
        _ viewController:           UIViewController,
        from:                       UIViewController,
        presentationStyle:          UIModalPresentationStyle,
        wrapInNavigationController: Bool,
        animated:                   Bool,
        completion:                 VoidBlock?
    )

    func dismiss(
        _ vc:       UIViewController,
        animated:   Bool,
        completion: VoidBlock?
    )

    func initialWindow(
        _ route:  Route,
        type:     ControllerType
    ) -> UIViewController
}

extension RouterProtocol {

    func push(
        _ route:  Route,
        from:     UIViewController,
        animated: Bool = true
    ) {
        push(
            route,
            from:     from,
            animated: animated
        )
    }

    func push(
        _ viewController: UIViewController,
        from:             UIViewController,
        animated:         Bool = true
    ) {
        push(
            viewController,
            from:     from,
            animated: animated
        )
    }

    func present(
        _ route:                    Route,
        from:                       UIViewController,
        presentationStyle:          UIModalPresentationStyle = .pageSheet,
        wrapInNavigationController: Bool = true,
        animated:                   Bool = true,
        completion:                 VoidBlock? = nil
    ) {
        present(
            route,
            from:                       from,
            presentationStyle:          presentationStyle,
            wrapInNavigationController: wrapInNavigationController,
            animated:                   animated,
            completion:                 completion
        )
    }

    func present(
        _ viewController:           UIViewController,
        from:                       UIViewController,
        presentationStyle:          UIModalPresentationStyle = .pageSheet,
        wrapInNavigationController: Bool = true,
        animated:                   Bool = true,
        completion:                 VoidBlock? = nil
    ) {
        present(
            viewController,
            from:                       from,
            presentationStyle:          presentationStyle,
            wrapInNavigationController: wrapInNavigationController,
            animated:                   animated,
            completion:                 completion
        )
    }

    func dismiss(
        _ vc:       UIViewController,
        animated:   Bool = true,
        completion: VoidBlock? = nil
    ) {
        dismiss(
            vc,
            animated:   animated,
            completion: completion
        )
    }
}

enum Route {
    case signup
    case login

    fileprivate func viewController() -> UIViewController {

        let viewController: UIViewController

        switch self {

        case .signup:
            viewController = Resources.ViewControllers.App.signup()

        case .login:
            viewController = Resources.ViewControllers.App.login()
        }

        return viewController
    }
}

enum ControllerType {
    case normal
    case navigation
}

final class Router: RouterProtocol {

    func push(
        _ route:  Route,
        from:     UIViewController,
        animated: Bool
    ) {
        let destinationViewController = route.viewController()

        internalPush(
            destinationViewController,
            from:     from,
            animated: animated
        )
    }

    func push(
        _ viewController: UIViewController,
        from:             UIViewController,
        animated:         Bool
    ) {
        internalPush(
            viewController,
            from: from,
            animated: animated
        )
    }

    private func internalPush(
        _ resolvedViewController: UIViewController,
        from:                     UIViewController,
        animated:                 Bool
    ) {
        let vc = resolvedViewController
        let navVC =
            from as? MainNavigationController ??
            from.navigationController as? MainNavigationController

        navVC?.pushViewController(
            vc,
            animated: animated
        )
    }

    func present(
        _ route:                    Route,
        from:                       UIViewController,
        presentationStyle:          UIModalPresentationStyle,
        wrapInNavigationController: Bool,
        animated:                   Bool,
        completion:                 VoidBlock?
    ) {
        let vc = route.viewController()

        internalPresent(
            vc,
            from:                       from,
            presentationStyle:          presentationStyle,
            wrapInNavigationController: wrapInNavigationController,
            animated:                   animated,
            completion:                 completion
        )
    }

    func present(
        _ viewController:           UIViewController,
        from:                       UIViewController,
        presentationStyle:          UIModalPresentationStyle,
        wrapInNavigationController: Bool,
        animated:                   Bool,
        completion:                 VoidBlock?
    ) {
        internalPresent(
            viewController,
            from:                       from,
            presentationStyle:          presentationStyle,
            wrapInNavigationController: wrapInNavigationController,
            animated:                   animated,
            completion:                 completion
        )
    }

    private func internalPresent(
        _ resolvedController:       UIViewController,
        from:                       UIViewController,
        presentationStyle:          UIModalPresentationStyle,
        wrapInNavigationController: Bool,
        animated:                   Bool,
        completion:                 VoidBlock?
    ) {
        let vc = resolvedController

        if wrapInNavigationController {

            let navVC = MainNavigationController.instantiateInitialViewController()

            navVC.modalPresentationStyle = presentationStyle
            navVC.viewControllers = [vc]

            from.present(
                navVC,
                animated:   animated,
                completion: completion
            )
        } else {
            vc.modalPresentationStyle = presentationStyle

            from.present(
                vc,
                animated: animated,
                completion: completion
            )
        }
    }

    func dismiss(
        _ vc:       UIViewController,
        animated:   Bool,
        completion: VoidBlock?
    ) {
        if
            let navVC = vc.navigationController,
            navVC.viewControllers.count > 1
        {
            navVC.popViewController(
                animated: animated
            )
        } else {
            vc.dismiss(
                animated: animated,
                completion: completion
            )
        }
    }

    func initialWindow(
        _ route:  Route,
        type:     ControllerType
    ) -> UIViewController {

        var viewController: UIViewController

        switch type {

        case .normal:
            viewController = route.viewController()

        case .navigation:
            let navVC = MainNavigationController.instantiateInitialViewController()
            let vc = route.viewController()

            navVC.viewControllers.insert(vc, at: 0)

            viewController = navVC
        }

        return viewController
    }
}
