//
//  Loading.swift
//  iOS_KOSIGNSTORE
//
//  Created by Bong Kokkheang on 10/7/23.
//

import Foundation
import UIKit

class Loading {
    
    static var completion : () -> () = {}
    
    static func show() {
        let topViewController = UIApplication.topViewController()
        let sb  = UIStoryboard(name: "LoadingSB", bundle: nil)
        let vc  = sb.instantiateViewController(withIdentifier: "LoadingVC") as! LoadingVC
        completion = {
            DispatchQueue.main.async {
                vc.dismiss(animated: false)
            }
        }
        vc.modalTransitionStyle     = UIModalTransitionStyle.crossDissolve
        vc.modalPresentationStyle   = UIModalPresentationStyle.overFullScreen
        DispatchQueue.main.async {
            topViewController?.present(vc, animated: false)
        }
    }
    
    static func close() {
        completion()
    }
    
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
