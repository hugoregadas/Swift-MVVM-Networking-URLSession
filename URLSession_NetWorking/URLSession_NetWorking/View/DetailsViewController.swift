//
//  DetailsViewController.swift
//  URLSession_NetWorking
//
//  Created by Hugo Regadas on 15/09/2021.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController, DetailsViewModelDelegate {
    //MARK: - IBOutlets
    @IBOutlet weak var imageViewDetails: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    //MARK: - PROPERTIES
    var viewModel = DetailsViewModel()
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = viewModel.titleLabel
        authorLabel.text = viewModel.authorLabel
        dateLabel.text = viewModel.dateLabel
        descriptionText.text = viewModel.descriptionText
    }
    
    func updateView() {
        imageViewDetails.image = viewModel.imageBook
    }
}
