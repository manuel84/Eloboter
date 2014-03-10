Teacup::Stylesheet.new :matchday_table_view do

  style :logo1,
        frame: [[35, 7], [50, 50]]

  style :logo2,
        frame: [[225, 7], [50, 50]]

  style :result,
        font: UIFont.fontWithName('Arvo', size: 50),
        textAlignment: UITextAlignmentCenter,
        textColor: "#595959".uicolor,
        frame: [[100, 7], [120, 70]]

  style :team1,
        frame: [[10, 57], [100, 30]],
        font: UIFont.fontWithName('HelveticaNeue-Medium', size: 12),
        textAlignment: UITextAlignmentCenter

  style :team2,
        frame: [[200, 57], [100, 30]],
        font: UIFont.fontWithName('HelveticaNeue-Medium', size: 12),
        textAlignment: UITextAlignmentCenter


end
