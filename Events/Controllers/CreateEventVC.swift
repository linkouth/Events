//
//  CreateEventVC.swift
//  Events
//
//  Created by User on 25/08/2019.
//  Copyright © 2019 Timur LLC. All rights reserved.
//

import UIKit

class CreateEventVC: UIViewController {
    // MARK: properties
    @IBOutlet weak var hallSelectTableView: UITableView! {
        didSet {
            hallSelectTableView.delegate = self
            hallSelectTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hallSelectTableView.register(UINib(nibName: HallTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: HallTableViewCell.reuseId)
    }
}

extension CreateEventVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Data Source Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = hallSelectTableView.dequeueReusableCell(withIdentifier: HallTableViewCell.reuseId, for: indexPath) as? HallTableViewCell {
            return cell
        }
        
        return UITableViewCell()
    }
}
