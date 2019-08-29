//
//  EventDetailVC.swift
//  Events
//
//  Created by User on 24/08/2019.
//  Copyright © 2019 Timur LLC. All rights reserved.
//

import UIKit

class EventDetailVC: UIViewController {

    // MARK: Properties
    var eventId: Int?
    var event: Event? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    // Mark: Outlets
    @IBOutlet weak var timeView: UIView!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorPhoneLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEvent()
    }

    func fetchEvent() {
        guard let eventId = eventId else { return }
        
        let stringURL = "http://gt-schedule.profsoft.online/api/event/\(eventId)"
        guard let url = URL(string: stringURL) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "dataTask error")
                return
            }
            guard let data = data else { return }
            guard let eventResponse = try? JSONDecoder().decode(Event.self, from: data) else {
                print("JSON parse error")
                return
            }
            self.event = eventResponse
            print(eventResponse.description)
        }
        task.resume()
    }
    
    func updateView() {
        guard let event = event, let startTime = event.startDate, let endTime = event.endDate else { return }
        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime))
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd-MM hh:mm"
        
        let duration = (endTime - startTime) / 1000
        let minutes = Int(duration / 60) % 60
        let hours = (duration / 3600)
        
        durationLabel.text  = String(format: "%0.2d:%0.2d", hours, minutes)
        startTimeLabel.text = dateFormatter.string(from: startDate)
        endTimeLabel.text   = dateFormatter.string(from: endDate)
        authorNameLabel.text  = event.authorName
        authorPhoneLabel.text = event.authorPhone
        descriptionLabel.text = event.description
        dateLabel.text = dateFormatter.string(from: startDate)
        roomNameLabel.text = event.room
        statusLabel.text   = event.statusString
        
    }
}
