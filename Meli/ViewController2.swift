//
//  ViewController2.swift
//  Meli
//
//  Created by Gilmer Marcano on 11/25/19.
//  Copyright © 2019 Gilmer Marcano. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var nameArray1 = ["master","visa","americamexpress"]
    
    @IBOutlet weak var moneyIn: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var valorRecibido: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyIn.text = valorRecibido
        
  
        self.getCards()
        self.setupTableView()
    }
    
    func setupTableView() {
             tableView.dataSource = self
             tableView.delegate = self
             
        let nibCell = UINib.init(nibName: String(describing: tableView.self), bundle: nil)
             tableView.register(nibCell, forCellReuseIdentifier: "Cell")
         }
    
    func getCards(){
        
        let urlCompleto:String = "https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88"
            
            
        let objetoUrl:URL? = URL(string:urlCompleto)
            
        
        let tarea = URLSession.shared.dataTask(with: objetoUrl!){ (datos, respuesta, error) in
        
            if error != nil{
                print(error!)
                
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]
                    
                    // print(json)
                    var nameArray = [String]()
                    
                    for object in json {
                    
                    if let name = object["name"] as? String {
                    // print(name)
                        
                    nameArray.append(name)
                    }
                        
                    self.nameArray1 = nameArray
                        
                    DispatchQueue.main.async {
                    self.tableView.reloadData()
                    }
                   
                }
                    
                }catch{
                     
                    
                }
                
            }
            
        }
        
        tarea.resume()
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print (nameArray1.count)
           
        return nameArray1.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        //let celda = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        let celda = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           
        celda.textLabel? .text = nameArray1 [indexPath.row]
            
        return celda
           // esta funcion lo que espera de return es una celda. una celda que vaya a mostrar
           
           //celda.imageView!.image = UIImage(named:"Libro.jpg")
        }
     
       
}

