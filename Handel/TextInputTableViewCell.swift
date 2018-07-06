//
//  TextInputTableViewCell.swift
//  Handel
//
//  Created by gridstone on 5/7/18.
//  Copyright © 2018 gridstone. All rights reserved.
//

import UIKit

class TextInputTableViewCell: UITableViewCell {
    
    var textField: UITextField
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        textField = UITextField(frame: .zero)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
