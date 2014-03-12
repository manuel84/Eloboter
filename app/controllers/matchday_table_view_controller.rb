TITLE_TAG = 2
TEAM1_TAG = 3
TEAM2_TAG = 4
LOGO1_TAG = 5
LOGO2_TAG = 6

class MatchdayTableViewController < UITableViewController
  WEEKDAYS = %w(Montag Dienstag Mittwoch Donnerstag Freitag Samstag Sonntag)

  stylesheet :matchday_table_view

  def show_info
    NSLog "show info"
    self.navigationController.pushViewController(InfoViewController.alloc.init, animated: true)
  end

  def layoutDidLoad
    super
    self.title = 'Spieltag'
    @images_cache = NSCache.alloc.init
    @table = UITableView.alloc.initWithFrame UIScreen.mainScreen.applicationFrame, style: UITableViewStylePlain, setSeparatorInset: UIEdgeInsetsMake(0, 0, 0, 0)
    self.view = @table
    @table.dataSource = self
    @table.delegate = self
    right_info_image = UIBarButtonItem.alloc.initWithImage(
        'navbar_info_iphone@2x.png'.uiimage.scale_to([21, 21]),
        style: UIBarButtonItemStyleBordered,
        target: self,
        action: "show_info")

    self.navigationItem.rightBarButtonItem = right_info_image

    @indicator = UIActivityIndicatorView.large
    @indicator.center = view.center
    view.addSubview(@indicator)
    @indicator.hidesWhenStopped = true
    @indicator.startAnimating

    load_data
  end

  def load_data
    @data ||= []
    Guess.all do |response|
      @data = response
      @indicator.stopAnimating
      if @data
        @table.reloadData
        self.title = "#{@data.first['meta']['matchday']}. Spieltag"
      else
        self.title = "Keine Internetverbindung"
      end

    end
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    88
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier)

    if not cell
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault,
                                                 reuseIdentifier: cell_identifier)
      cell.selectionStyle = UITableViewCellSelectionStyleNone

      layout(cell.contentView, :cell) do
        result_view = subview(UILabel, :result, tag: TITLE_TAG)
        team1_view = subview(UILabel, :team1, tag: TEAM1_TAG)
        team2_view = subview(UILabel, :team2, tag: TEAM2_TAG)
        logo1_view = subview(UIImageView, :logo1, tag: LOGO1_TAG)
        logo2_view = subview(UIImageView, :logo2, tag: LOGO2_TAG)
      end
    else # the cell *did* exist
      result_view = cell.viewWithTag(TITLE_TAG)
      team1_view = cell.viewWithTag(TEAM1_TAG)
      team2_view = cell.viewWithTag(TEAM2_TAG)
      logo1_view = cell.viewWithTag(LOGO1_TAG)
      logo2_view = cell.viewWithTag(LOGO2_TAG)
    end

    guess = @data[indexPath[0]]['matches'][indexPath[1]]

    result_view.text = guess['result']
    team1_view.text = guess['hostName']
    team2_view.text = guess['guestName']

    team_logo_views = [logo1_view, logo2_view]
    team_icon_urls =[guess['hostIconUrl'], guess['guestIconUrl']]

    team_icon_urls.each_with_index do |team_icon_url, index|
      if cached_image = @images_cache.objectForKey(team_icon_url)
        team_logo_views[index].image = UIImage.alloc.initWithData(cached_image)
      else
        BW::HTTP.get(team_icon_url) do |response|
          if response.ok?
            team_logo_views[index].image = UIImage.alloc.initWithData(response.body)
            @images_cache.setObject(response.body, forKey: team_icon_url)
          else
            NSLog team_icon_url
          end
        end
      end
    end

    return cell
  end

  def cell_identifier
    @@cell_identifier ||= 'Cell'
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data[section]['matches'].count
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: false)
  end

  def numberOfSectionsInTableView tableView
    @data.count
  end

  def tableView(tableView, titleForHeaderInSection: section)
    @date_formatter ||= NSDateFormatter.alloc.init
    @date_formatter.dateFormat = "yyyy-MM-dd"
    date = @date_formatter.dateFromString @data[section]['meta']['date']
    "#{WEEKDAYS[date.wday]}, #{date.mday}. #{date.month}."
  end

end