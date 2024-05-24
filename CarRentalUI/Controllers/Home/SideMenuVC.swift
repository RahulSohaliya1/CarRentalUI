//
//  SideMenuVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 24/07/23.
//

import UIKit

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var mainBackGroundView: UIView!
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var createNewCarBtn: UIButton!
    @IBOutlet weak var createNewEventBtn: UIButton!
    @IBOutlet weak var contactSupportBtn: UIButton!
    @IBOutlet weak var mainLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sideMenuOptionsTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CreateNewCarVC") as! CreateNewCarVC
            navigationController?.pushViewController(vc, animated: true);
            
        case 1:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CreateNewEventVC") as! CreateNewEventVC
            navigationController?.pushViewController(vc, animated: true);
            
        case 2:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ContactSupportVC") as! ContactSupportVC
            navigationController?.pushViewController(vc, animated: true);
            
        case 3:
            UserDefaults.standard.set(false, forKey: "USER_LOGIN")
            let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
            let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "OnBoardingVC") as UIViewController
            navigationController.viewControllers = [rootViewController]
            AppDelegate.sharedApplication().window?.rootViewController = navigationController
            
        default:
            break
        }
    }
}
    