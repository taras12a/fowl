import UIKit

class FowlFortuneMainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFowlFortuneTabBarAppearance()
        setupFowlFortuneViewControllers()
    }
    
    private func setupFowlFortuneTabBarAppearance() {
        tabBar.tintColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        tabBar.unselectedItemTintColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 0.6)
        tabBar.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        
        if #available(iOS 15.0, *) {
            let FowlFortuneAppearance = UITabBarAppearance()
            FowlFortuneAppearance.configureWithOpaqueBackground()
            FowlFortuneAppearance.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
            tabBar.standardAppearance = FowlFortuneAppearance
            tabBar.scrollEdgeAppearance = FowlFortuneAppearance
        }
    }
    
    private func setupFowlFortuneViewControllers() {
        let FowlFortuneFarmVC = FowlFortuneFarmViewController()
        let FowlFortuneFarmNav = UINavigationController(rootViewController: FowlFortuneFarmVC)
        FowlFortuneFarmNav.tabBarItem = UITabBarItem(title: "Farm", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let FowlFortuneAchievementsVC = FowlFortuneAchievementsViewController()
        let FowlFortuneAchievementsNav = UINavigationController(rootViewController: FowlFortuneAchievementsVC)
        FowlFortuneAchievementsNav.tabBarItem = UITabBarItem(title: "Achievements", image: UIImage(systemName: "trophy"), selectedImage: UIImage(systemName: "trophy.fill"))
        
        let FowlFortuneBuildingVC = FowlFortuneBuildingViewController()
        let FowlFortuneBuildingNav = UINavigationController(rootViewController: FowlFortuneBuildingVC)
        FowlFortuneBuildingNav.tabBarItem = UITabBarItem(title: "Building", image: UIImage(systemName: "hammer"), selectedImage: UIImage(systemName: "hammer.fill"))
        
        let FowlFortuneFactsVC = FowlFortuneFactsViewController()
        let FowlFortuneFactsNav = UINavigationController(rootViewController: FowlFortuneFactsVC)
        FowlFortuneFactsNav.tabBarItem = UITabBarItem(title: "Facts", image: UIImage(systemName: "book"), selectedImage: UIImage(systemName: "book.fill"))
        
        let FowlFortuneSettingsVC = FowlFortuneSettingsViewController()
        let FowlFortuneSettingsNav = UINavigationController(rootViewController: FowlFortuneSettingsVC)
        FowlFortuneSettingsNav.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        viewControllers = [FowlFortuneFarmNav, FowlFortuneAchievementsNav, FowlFortuneBuildingNav, FowlFortuneFactsNav, FowlFortuneSettingsNav]
    }
}
