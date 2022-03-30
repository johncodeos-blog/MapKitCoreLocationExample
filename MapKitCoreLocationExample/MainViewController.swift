import Foundation
import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    func configureView() {
        // Navigation Bar
        UIHelper().setCustomNavigationTitle(title: "MapKitCoreLocationExample", navItem: navigationItem)
        UIHelper().setNavigationBar(tintColor: .white, navController: navigationController, navItem: self.navigationItem)
    }
}
