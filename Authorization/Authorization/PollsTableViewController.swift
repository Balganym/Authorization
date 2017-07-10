//
//  PollsTableViewController.swift
//  Authorization
//
//  Created by mac on 07.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

// MARK: - constants
private struct Constants {
    static let pollCellIdentifier = "Poll Cell"
    static let userInfoSegue = "User Info"
}

class PollsTableViewController: UITableViewController, NVActivityIndicatorViewable {

    // MARK: - variables
    var polls: [Polls] = []
    
    // относительно контента сетим размеры ячеек
    private func configureTableView() {
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
    }
    
    // сколько строк в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stopAnimating()
        return polls.count
    }
    
    // какой опрос в какую строчку
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.pollCellIdentifier, for: indexPath) as! PollTableViewCell
        cell.poll = polls[indexPath.row]
        
        return cell
    }
    
    // Получаем опросы
    private func getPolls() {
        
        Polls.getPolls() { results, message in
            
            if let message = message {
                self.showAlert("Oшибка", message)
            } else {
                self.polls = results!
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - actions
    @IBAction func showUserInfo(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.userInfoSegue, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        startAnimating()
        getPolls()
    }
}
