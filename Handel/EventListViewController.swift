//
//  GoingViewController.swift
//  Handel
//
//  Created by gridstone on 4/7/18.
//  Copyright © 2018 gridstone. All rights reserved.
//

import UIKit

fileprivate let eventFilePath = "Events.json"

class EventListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NewEventViewControllerDelegate {
    
    var eventsConfirmed = [Event]()
    
    // eventsGoing[0] = "Laser Tag"
    
    var eventsPending = [Event]()
    
    let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Events"
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openNewEventScreen))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settingsCog"), style: .plain, target: nil, action: nil)
        
        loadEvents()
        
        constructTableView()
    }
    
    func constructTableView() {
        view.addSubview(tableView)
        
        //We can now tell the table view whero to sit
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table View functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return eventsConfirmed.count
        } else if section == 1 {
            return eventsPending.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Confirmed"
        } else if section == 1 {
            return "Pending"
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
        let section = indexPath.section
        let row = indexPath.row
        
        cell?.imageView?.image = #imageLiteral(resourceName: "circleOutline")
        
        var event: Event
        
        if section == 0 {
            event = eventsConfirmed[row]
            cell?.imageView?.tintColor = #colorLiteral(red: 0, green: 0.82123667, blue: 0.3384956121, alpha: 1)
        } else if section == 1 {
            event = eventsPending[row]
            cell?.imageView?.tintColor = #colorLiteral(red: 0.9131045938, green: 0.5476151705, blue: 0.0495691821, alpha: 1)
        } else {
            event = Event(titleToSet: "Undefined", locationToSet: "Undefined", creatorToSet: "", eventDescriptionToSet: "")
        }
        
        cell?.textLabel?.text = event.title
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        cell?.detailTextLabel?.numberOfLines = 0
        cell?.detailTextLabel?.text = event.location + "\n" + "Created by " + event.creator
        
        cell?.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        var event: Event!
        
        if section == 0 {
            event = eventsConfirmed[row]
        } else if section == 1 {
            event = eventsPending[row]
        }
        
        let viewController = EventInfoViewController(event: event)
        navigationController?.pushViewController(viewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            
            let alertController = UIAlertController(title: "Delete event?", message: "Are you sure you want to delete this event?", preferredStyle: .actionSheet)
            
            let confirmDeletionAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (alert) in
                if indexPath.section == 0 {
                    self.eventsConfirmed.remove(at: indexPath.row)
                } else if indexPath.section == 1 {
                    self.eventsPending.remove(at: indexPath.row)
                }
                
                tableView.deleteRows(at: [indexPath], with: .right)
                
                tableView.reloadData()
                
                self.saveEvents()
            })
            
            let cancelDeletionAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(cancelDeletionAction)
            alertController.addAction(confirmDeletionAction)
            
            self.navigationController?.present(alertController, animated: true, completion: nil)
        }
        
        let moveToPending = UITableViewRowAction(style: .normal, title: "Move to Pending") { (action, indexPath) in
            let event = self.eventsConfirmed.remove(at: indexPath.row)
            self.eventsPending.append(event)
            self.tableView.reloadData()
            self.saveEvents()
        }
        
        moveToPending.backgroundColor = #colorLiteral(red: 0.9131045938, green: 0.5476151705, blue: 0.0495691821, alpha: 1)
        
        let moveToConfirmed = UITableViewRowAction(style: .normal, title: "Move to Confirmed") { (action, indexPath) in
            let event = self.eventsPending.remove(at: indexPath.row)
            self.eventsConfirmed.append(event)
            self.tableView.reloadData()
            self.saveEvents()
        }
        
        moveToConfirmed.backgroundColor = #colorLiteral(red: 0, green: 0.82123667, blue: 0.3384956121, alpha: 1)
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            let section = indexPath.section
            let row = indexPath.row
            var eventToEdit: Event?
            
            // are we in confirmed or pending?
            
            if section == 0 {
                eventToEdit = self.eventsConfirmed[row]
            } else if section == 1 {
                eventToEdit = self.eventsPending[row]
            }
            
            if eventToEdit != nil {
                self.openEditEventScreen(eventToEdit: eventToEdit!)
            }
        }
        
        if indexPath.section == 0 {
            return [deleteAction, editAction, moveToPending]
        } else if indexPath.section == 1 {
            return [deleteAction, editAction, moveToConfirmed]
        }
        
        return []
    }

    
   @objc func openNewEventScreen() {
        let viewController = NewEventViewController()
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openEditEventScreen(eventToEdit: Event) {
        let viewController = NewEventViewController(eventToEdit: eventToEdit)
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func addEvent(viewController: NewEventViewController, event: Event) {
        eventsPending.append(event)
        tableView.reloadData()
        saveEvents()
    }
    
    func didUpdateEvent(viewController: NewEventViewController) {
        saveEvents()
        tableView.reloadData()
    }
    
    func saveEvents() {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent(eventFilePath)
        
        let lists = EventLists(confirmed: eventsConfirmed, pending: eventsPending)
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(lists)
            try data.write(to: fileUrl, options: [])
        } catch {
            print(error)
        }
    }
    
    func loadEvents() {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent(eventFilePath)
        
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            let lists = try decoder.decode(EventLists.self, from: data)
            eventsConfirmed = lists.eventsConfirmed
            eventsPending = lists.eventsPending
        } catch {
            print(error)
        }
    }
}
