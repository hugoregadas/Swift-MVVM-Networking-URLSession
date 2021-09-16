//
//  ViewController.swift
//  URLSession_NetWorking
//
//  Created by Hugo Regadas on 10/09/2021.
//

import UIKit

class InfoCell: UITableViewCell {
    //MARK: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

class ViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    let viewModel = FirstcontrollerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        viewModel.getDataService()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - ViewModel Delegates

extension ViewController : FirstcontrollerViewModelDelegate {
    func updateTableView() {
        tableView.reloadData()
    }
}

//MARK: - TableViewMethods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! InfoCell
        viewModel.configInfoTableViewTo(indexPath: indexPath)
        
        cell.titleLabel.text = viewModel.titleBook
        cell.authorLabel.text = viewModel.author
        cell.descriptionLabel.text = viewModel.description

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedItem(withIndexPath: indexPath)
        performSegue(withIdentifier: "details", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let title = viewModel.selectedItem?.title,
           let author = viewModel.selectedItem?.author,
           let date = viewModel.selectedItem?.publishedDate,
           let details = viewModel.selectedItem?.body,
           let url = viewModel.selectedItem?.hero,
           let idFile = viewModel.selectedItem?.id{
            
            (segue.destination as! DetailsViewController).viewModel.configureViewModel(with : idFile,
                                                                                       title:title,
                                                                                       author: author,
                                                                                       date: date,
                                                                                       details: details,
                                                                                       urlString: url)
            
            (segue.destination as! DetailsViewController).viewModel.delegate = (segue.destination as! DetailsViewModelDelegate)
            segue.destination.modalPresentationStyle = .fullScreen
            
        }
    }
}

