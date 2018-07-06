//
//  NewEventViewController.swift
//  Handel
//
//  Created by gridstone on 5/7/18.
//  Copyright © 2018 gridstone. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView(frame: .zero, style: .grouped)
    var eventToEdit: Event?
    var delegate: NewEventViewControllerDelegate?
    
    init(eventToEdit: Event? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.eventToEdit = eventToEdit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        title = eventToEdit != nil ? "Edit Event" : "Create Event"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(createEvent))
        
        constructTableView()
    }
    
    func constructTableView() {
        tableView.register(TextInputTableViewCell.self, forCellReuseIdentifier: "cell")
        
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TextInputTableViewCell
        
        let section = indexPath.section
        let row = indexPath.row
        
        switch (row, section) {
        case (0, 0):
            cell.textField.placeholder = "Title"
            cell.textField.text = eventToEdit?.title
        case (1, 0):
            cell.textField.placeholder = "Location"
            cell.textField.text = eventToEdit?.location
        case (0, 1):
            cell.textField.placeholder = "Creator"
            cell.textField.text = eventToEdit?.creator
        case (0, 2):
            cell.textField.placeholder = "Description"
            cell.textField.text = eventToEdit?.eventDescription
        default:
            print("Invalid Section")
        }
        
        return cell
    }
    
    @objc func createEvent() {
        let title: String
        let location: String
        let creator: String
        let description: String
        
        title = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextInputTableViewCell).textField.text!
        location = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextInputTableViewCell).textField.text!
        creator = (tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! TextInputTableViewCell).textField.text!
        description = (tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! TextInputTableViewCell).textField.text!

        let event = Event(titleToSet: title, locationToSet: location, creatorToSet: creator, eventDescriptionToSet: description)
        
        if let eventToEdit = eventToEdit {
            eventToEdit.title = title
            eventToEdit.location = location
            eventToEdit.creator = creator
            eventToEdit.eventDescription = description
            delegate?.didUpdateEvent(viewController: self)
        } else {
            delegate?.addEvent(viewController: self, event: event)
        }
        navigationController?.popViewController(animated: true)
    }
    
}

protocol NewEventViewControllerDelegate {
    func addEvent(viewController: NewEventViewController, event: Event)
    func didUpdateEvent(viewController: NewEventViewController)
}
