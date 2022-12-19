//
//  TableViewController.swift
//  ToDoList
//
//  Created by Murad Gadzhikurbanov on 12/4/22.
//

import UIKit

class TableViewController: UITableViewController {

    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    
    //add item
    @IBAction func pushAddAcrion(_ sender: Any) {
        let alertController = UIAlertController(title: "Добавить новую задачу", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Название задачи"
        }
        
        let alertAction1 = UIAlertAction(title: "Отмена", style: .default)
        { (alert) in
            
            
        }
        let alertAction2 = UIAlertAction(title: "Создать", style: .cancel)
        { (alert) in
            let newItem = alertController.textFields![0].text
            if newItem != "" {
            addItem(nameItem: newItem!)
            self.tableView.reloadData()
            }
        }
         
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        present(alertController, animated: true, completion: nil)
    }
    
//    
//    @IBAction func onClickSwitch(_ sender: UISwitch) {
//        
//        if #available(iOS 13.0, *) {
//            let appDeligate = UIApplication.shared.windows.first
//            
//            if sender.isOn {
//                appDeligate?.overrideUserInterfaceStyle = .dark
//                return
//            }
//            
//            appDeligate?.overrideUserInterfaceStyle = .light
//            return
//            
//        } else {
//            
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ToDoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        						
        let currentItem = ToDoItems[indexPath.row]
        
        let labels = cell.contentView.subviews.flatMap {$0 as? UILabel}
        
        labels[0].text = String(describing: currentItem["Name"] ?? "no_data" as! String)
        labels[1].text = String(describing: currentItem["dateCreated"] ?? "no_data" as! String)
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        
        tableView.reloadData()
    }
}

//date
