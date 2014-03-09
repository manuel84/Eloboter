Teacup::Stylesheet.new :matchday_table_view do

  style :logo1,
        frame: [[35, 7], [50, 50]]

  style :logo2,
        frame: [[225, 7], [50, 50]]

  style :result,
        font: UIFont.fontWithName('AveriaSansLibre-Bold', size: 42),
        textAlignment: UITextAlignmentCenter,
        textColor: :gray.uicolor,
        frame: [[100, 7], [120, 70]]

  style :team1,
        frame: [[10, 57], [100, 30]],
        font: :system.uifont(10),
        textAlignment: UITextAlignmentCenter

  style :team2,
        frame: [[200, 57], [100, 30]],
        font: :system.uifont(10),
        textAlignment: UITextAlignmentCenter


end
