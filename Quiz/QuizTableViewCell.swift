//
//  QuizTableViewCell.swift
//  Quiz
//
//  Created by Andreas Kullberg on 2019-03-22.
//  Copyright © 2019 Andreas Kullberg. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {

    @IBOutlet weak var quizNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
