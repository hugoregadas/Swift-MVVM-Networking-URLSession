//
//  DetailsViewModel.swift
//  URLSession_NetWorking
//
//  Created by Hugo Regadas on 15/09/2021.
//

import UIKit

protocol DetailsViewModelDelegate : NSObject{
    func updateView()
}

class DetailsViewModel {
    let service = Service.shared
    weak var delegate: DetailsViewModelDelegate?
    
    var titleLabel: String?
    var authorLabel: String?
    var dateLabel: String?
    var descriptionText: String?
    var imageBook: UIImage?
    
    
    func configureViewModel(with idFile: String, title: String, author: String, date: String, details: String, urlString: String) {
        titleLabel = title
        authorLabel = author
        dateLabel = date
        descriptionText = details
        
        if let url = URL(string: urlString) {
            service.getImageWith(url: url, idFile: idFile, completion:{ dataInfo, error in
                if let dataInfo = dataInfo {
                    self.imageBook = UIImage(data: dataInfo)
                    DispatchQueue.main.async {
                        self.delegate?.updateView()
                    }
                }
            })
        }
    }
}
