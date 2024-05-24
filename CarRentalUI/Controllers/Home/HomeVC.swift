//
//  HomeVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 17/07/23.
//
// MARK: - Navigation


import UIKit
import SideMenu

class HomeVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var MenuBtn: UIButton!
    @IBOutlet weak var calendarBtn: UIButton!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var effect: UIVisualEffect!
    
    private var categoryImages: [String] = ["ic_restaurant", "ic_car", "ic_ship", "ic_suitcase"]
    private var categoryNames: [String] = ["RESTAURANT", "CARS", "YACHTS", "TOURS"]
    
    var sideMenu: SideMenuNavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewNibRegister()
        sideMenuConfig()
    }
    
    private func sideMenuConfig() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let sideMenuVC = storyBoard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        
        sideMenu = .init(rootViewController: sideMenuVC)
        sideMenu.leftSide = true
        sideMenu.statusBarEndAlpha = 0
        sideMenu.isNavigationBarHidden = true
        sideMenu.menuWidth = view.bounds.width * 0.7
        sideMenu.presentationStyle = .menuSlideIn
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view, forMenu: .left)
        sideMenu.delegate = self
    }
    
    private func collectionViewNibRegister() {
        let nibFile: UINib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        categoryCollectionView.register(nibFile, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func menuBtnTapped(_ sender: UIButton) {
        self.present(sideMenu, animated: true)
    }
    
    @IBAction func calendarBtnTapped(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CalenderVC") as! CalenderVC
        navigationController?.pushViewController(vc, animated: true);
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCollectionViewCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryImgView.image = UIImage(named: "\(categoryImages[indexPath.row])")
        cell.categoryNameLbl.text = "\(categoryNames[indexPath.row])"
        return cell
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing: CGFloat = 8
        let totalSpacing: CGFloat = (2 * spacing)
        let cellWidth = (collectionViewWidth - totalSpacing) / 3
        let cellHeight: CGFloat = 130
        return CGSize(width: (categoryCollectionView.frame.width/2)-16, height: (categoryCollectionView.frame.height/2)-16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FindYourCarVC") as! FindYourCarVC
        navigationController?.pushViewController(vc, animated: true);
    }
}

extension HomeVC: SideMenuNavigationControllerDelegate {
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        effect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = view.bounds
        view.addSubview(blurView)
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        effect = nil
        for view in view.subviews {
            if let blurView = view as? UIVisualEffectView {
                blurView.removeFromSuperview()
            }
        }
    }
}
