//
//  EventInfoViewController.swift
//  Handel
//
//  Created by gridstone on 5/7/18.
//  Copyright © 2018 gridstone. All rights reserved.
//

import UIKit

class EventInfoViewController: UIViewController {

    var event: Event
    let imageView = UIImageView()
    let detailsLabel = UILabel()
    let descriptionLabel = UILabel()
    let locationLabel = UILabel()
    let eventLocationLabel = UILabel()
    
    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
        
        title = self.event.title
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Image view
        imageView.image = #imageLiteral(resourceName: "stockPhoto")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        //imageView.setContentHuggingPriority(.required, for: .vertical)
        
        // details text label
        detailsLabel.text = "Details"
        detailsLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        
        // description label text field
        descriptionLabel.text = event.eventDescription
        descriptionLabel.numberOfLines = 4
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        
        // location label heading
        locationLabel.text = "Location"
        locationLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        locationLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        // event location label
        eventLocationLabel.text = event.location
        eventLocationLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        eventLocationLabel.numberOfLines = 2
        
        setUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        eventLocationLabel.textColor = navigationController?.navigationBar.barTintColor
    }
    
    func setUpView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        eventLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        view.addSubview(imageView)
        view.addSubview(detailsLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(locationLabel)
        view.addSubview(eventLocationLabel)
        
        NSLayoutConstraint.activate([
            // Image View
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 220),
            
            // Details Label
            detailsLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            //Description Label
            descriptionLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: detailsLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Location label heading
            locationLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            locationLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            
            // event location label
            eventLocationLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            eventLocationLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            
            
            
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
