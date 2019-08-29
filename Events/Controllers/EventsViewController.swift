//
//  EventsViewController.swift
//  Events
//
//  Created by User on 24/08/2019.
//  Copyright © 2019 Timur LLC. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {

    var events: [Event] = [] {
        didSet {
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var eventsTableView: UITableView! {
        didSet {
            eventsTableView.delegate = self
            eventsTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        
        fetchEvents()
    }

    func fetchEvents() {
        let stringURL = "http://gt-schedule.profsoft.online/api/event/"
        guard let url = URL(string: stringURL) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "dataTask error")
                return
            }
            guard let data = data else { return }
            guard let eventsResponse = try? JSONDecoder().decode([Event].self, from: data) else {
                print("JSON parse error")
                return
            }
            self.events = eventsResponse
            print(eventsResponse.count)
        }
        task.resume()
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = eventsTableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell {
            let event = events[indexPath.row]
            switch event.status {
                case 2 :
                    cell.statusImage.image = UIImage(named: "Unchecked CheckBox")
                case 1:
                    cell.statusImage.image = UIImage(named: "Checked CheckBox")
                default:
                    cell.statusImage.image = UIImage(named: "Unconfirmed CheckBox")
            }
            if let startTimestampDate = event.startDate {
                let startDate = Date(timeIntervalSince1970: TimeInterval(startTimestampDate))
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale.init(identifier: "ru_RU")
                dateFormatter.dateFormat = "dd-MM hh:mm"
                cell.startTimeLabel.text = dateFormatter.string(from: startDate)
            }
            cell.nameLabel.text = event.name
            cell.authorNameLabel.text = event.authorName
            cell.authorPhoneLabel.text = event.authorPhone
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventDetailVC = EventDetailVC()
        self.navigationController?.pushViewController(eventDetailVC, animated: true)
    }
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
