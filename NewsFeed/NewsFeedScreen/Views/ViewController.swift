//
//  ViewController.swift
//  NewsFeed
//
//  Created by JaGgu Sam on 21/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var newsFeedTableView: UITableView!
    @IBOutlet weak var refreshButton: UIButton!
    
    var getNewsRepo: NewsListRepositoryProtocol = NewsListRepository()
    var newData = [NewsFeedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        registerCell()
        if getOffflineData() {
            print("Data available")
        } else {
            getNewsData()
        }
        // Do any additional setup after loading the view.
    }
    
    func configureTableView() {
        newsFeedTableView.rowHeight = UIScreen.main.bounds.height
        newsFeedTableView.estimatedRowHeight = UIScreen.main.bounds.height
        newsFeedTableView.separatorStyle = .none
        newsFeedTableView.isPagingEnabled = true
        newsFeedTableView.bounces = false
        newsFeedTableView.estimatedSectionHeaderHeight = CGFloat.leastNormalMagnitude
        newsFeedTableView.sectionHeaderHeight = CGFloat.leastNormalMagnitude
        newsFeedTableView.estimatedSectionFooterHeight = CGFloat.leastNormalMagnitude
        newsFeedTableView.sectionFooterHeight = CGFloat.leastNormalMagnitude
        newsFeedTableView.contentInsetAdjustmentBehavior = .never
        newsFeedTableView.delegate = self
        newsFeedTableView.dataSource = self
    }
    
    // Register cells
    func registerCell() {
        newsFeedTableView.register(UINib(nibName: "\(NewsCardTableViewCell.self)", bundle: Bundle.main), forCellReuseIdentifier: Constants.TableViewCellIdentifier.newsCardTableViewCell)
    }
    
    func getNewsData() {
        getNewsRepo.getNewsList { [weak self] result, error  in
            guard let weakself = self else { return }
            guard let object = result["articles"] as? [[String:AnyObject]] else { return }
            weakself.newData.removeAll()
            
            for item in object {
                weakself.newData.append(NewsFeedObject(dictionary: item))
            }
            
            DispatchQueue.main.async {
                weakself.newsFeedTableView.reloadData()
            }
            
        }
    }
    
    func getOffflineData() -> Bool {
        guard let data = UserDefaults.standard.value(forKey: Constants.UserDefaultsKeys.newsData) as? Data else {
            return false
        }
        
        do {
            let convertObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            guard let object = convertObject?["articles"] as? [[String:AnyObject]] else { return false }
            
            for item in object {
                self.newData.append(NewsFeedObject(dictionary: item))
            }
            
            DispatchQueue.main.async {
                self.newsFeedTableView.reloadData()
            }
            return true
        } catch {
            return false
        }
    }
    
    @IBAction func onClickRefresh(_ sender: Any) {
        getNewsData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = newsFeedTableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifier.newsCardTableViewCell, for: indexPath) as? NewsCardTableViewCell else { return UITableViewCell() }
        let details =  newData[indexPath.row]
        cell.configureCell(usingViewModel: NewsFeedViewModel.init(using:details))
        cell.buttonTapped = { value in
            guard let url = URL(string: details.url) else { return }
            UIApplication.shared.open(url)
        }
        return cell
    }
    
    
}




