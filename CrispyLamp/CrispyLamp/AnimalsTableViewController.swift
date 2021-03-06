//
//  AnimalsTableViewController.swift
//  CrispyLamp
//
//  Created by Ariel Rodriguez on 6/20/16.
//  Copyright © 2016 Ariel Rodriguez. All rights reserved.
//

import UIKit

class AnimalsDataSource:NSObject, UITableViewDataSource {
    let names = ["Armadillo", "Baboon", "Bat", "Camel", "Falcon", "Fly", "Panda Bear"]
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifier.AnimalsCellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = names[indexPath.row]
        
        return cell
    }
}

class AnimalsTableViewController: UITableViewController, IdentifiedViewController {
    
    let identifier: Identifier = Identifier(humanReadable:"Animals", unique:"Animals")
    
    @IBOutlet var dataSource: AnimalsDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
