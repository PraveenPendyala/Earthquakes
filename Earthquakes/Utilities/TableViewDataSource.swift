//
//  TableViewDataSource.swift
//  Earthquakes
//
//  Created by Praveen on 8/13/22.
//

import UIKit

class TableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {
    
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    
    
    init(items : [T], configureCell : @escaping (CELL, T) -> ()) {
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL.cellIdentifier, for: indexPath) as! CELL
        
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        return cell
    }
}
