func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
#if targetEnvironment(simulator)
        enterTheApplication()
        return true
#else
        if UIDevice.current.isJailBroken || UIDevice.current.isUsingSuspiciousLibraries{
            let alert = UIAlertController(
                title: "Uyarı",
                message: "Bu uygulama JailBreak yapılmış cihazlarda kullanılamaz.",
                preferredStyle: UIAlertController.Style.alert)
            let exitAction = UIAlertAction(title: "Çıkış Yap", style: UIAlertAction.Style.default) {
                UIAlertAction in
                exit(0)
            }
            alert.addAction(exitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else{
            enterTheApplication()
            return true
        }
#endif
    }