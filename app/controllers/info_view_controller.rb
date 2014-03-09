class InfoViewController < UIViewController

  stylesheet :info_view

  def layoutDidLoad
    super
    self.title = 'Info'
    @text_view = UITextView.alloc.initWithFrame [[0, 0], [320, 586]], style: UITableViewStylePlain
    @text_view.text = "Du bist sehr sehr geil!"
    view.addSubview(@text_view)
  end
end