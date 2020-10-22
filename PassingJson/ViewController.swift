//
//  ViewController.swift
//  PassingJson
//
//  Created by Mavin on 10/22/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        passingJson()
        
    }
    
    func passingJson(){
        guard let path = Bundle.main.path(forResource: "data", ofType: "json")else{return}
        let url = URL(fileURLWithPath: path)
        
        do{
            
            let jsonData = try Data(contentsOf: url)
            let result = try JSONDecoder().decode([Item].self, from: jsonData)
            
            for item in result {
                items.append(item)
            }
            
            
        }catch(let err){
            print(err)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items[section].items.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.items[section].title
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.items[indexPath.section].items[indexPath.row]
        return cell
    }
    
   
  
    
    
}

