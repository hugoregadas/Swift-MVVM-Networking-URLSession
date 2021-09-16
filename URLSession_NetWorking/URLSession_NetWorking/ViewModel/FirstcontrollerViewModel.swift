//
//  FirstcontrollerViewModel.swift
//  URLSession_NetWorking
//
//  Created by Hugo Regadas on 11/09/2021.
//

import Foundation


protocol FirstcontrollerViewModelDelegate: NSObject {
    func updateTableView()
}

class FirstcontrollerViewModel {
    let networker = Service.shared
    var items =  [Item]()
    var selectedItem: Item?
    
    weak var delegate: FirstcontrollerViewModelDelegate?
    var titleBook: String?
    var author : String?
    var description: String?
    
    func getDataService(){
        networker.getDataFromService { objList, error in
            DispatchQueue.main.sync {
                self.items = objList!.items
                self.delegate?.updateTableView()
            }
        }
    }
    
    func configInfoTableViewTo(indexPath: IndexPath){
        let obj = items[indexPath.row]
        titleBook = obj.title
        author = obj.author
        description = obj.summary
    }
    
    func selectedItem(withIndexPath index: IndexPath){
        selectedItem = items[index.row]
    }
}
