Teacup::Appearance.new do

  # UINavigationBar.appearance.setBarTintColor(UIColor.blackColor)
  style UINavigationBar,
        barTintColor: UIColor.colorWithRed(0/255.0, green:150/255.0, blue:5/255.0, alpha: 0.5),
        titleTextAttributes: {
            #UITextAttributeTextShadowColor => UIColor.colorWithWhite(0.0, alpha:0.4),
            UITextAttributeTextColor => UIColor.whiteColor
        }

  # UINavigationBar.appearanceWhenContainedIn(UINavigationBar, nil).setColor(UIColor.blackColor)
  style UIBarButtonItem, when_contained_in: UINavigationBar,
        tintColor: UIColor.blackColor

  # UINavigationBar.appearanceWhenContainedIn(UIToolbar, UIPopoverController, nil).setColor(UIColor.blackColor)
  style UIBarButtonItem, when_contained_in: [UIToolbar, UIPopoverController],
        tintColor: UIColor.whiteColor

end