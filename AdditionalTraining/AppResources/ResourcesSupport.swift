//
//  ResourcesSupport.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/13.
//

import UIKit

protocol Initializable: AnyObject {
    static var className: String { get }
    static var resourceName: String { get }
}

protocol ClassInitializable: Initializable {}

extension NSObject: ClassInitializable {

    static var className: String {
        String(describing: self)
    }

    static var resourceName: String {
        self.className
    }
}

extension Initializable where Self: UIViewController {
    
    static func instantiateInitialViewController(
        fromStoryboardOrNil customStoryboard: String? = nil
    ) -> Self {

        let finalStoryboardName = customStoryboard ?? self.resourceName
        let storyboard = UIStoryboard(name: finalStoryboardName, bundle: Bundle(for: self))
        let controller = storyboard.instantiateInitialViewController()

        return controller as! Self
    }
}
