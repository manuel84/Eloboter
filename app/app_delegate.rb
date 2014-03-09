class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    Teacup::Appearance.apply
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    application.setStatusBarStyle(UIStatusBarStyleDefault)
        #UIStatusBarStyleBlackTranslucent)

    if ipad?
      @main_controller = MatchdayTableViewIpadController.alloc.init
    else
      @main_controller = MatchdayTableViewIphoneController.alloc.init
    end
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(@main_controller)
    true
  end

end

class Kernel

  def ipad?
    UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
  end

end
