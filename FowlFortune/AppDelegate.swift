import UIKit

@main
class FowlFortuneAppDelegate: UIResponder, UIApplicationDelegate {
    
    var FowlFortuneWindow: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FowlFortuneWindow = UIWindow(frame: UIScreen.main.bounds)
        
        let FowlFortuneLoadingViewController = FowlFortuneLoadingViewController()
        FowlFortuneWindow?.rootViewController = FowlFortuneLoadingViewController
        FowlFortuneWindow?.makeKeyAndVisible()
        
        return true
    }
}

