//
//  ViewController2.swift
//  Meli
//
//  Created by Gilmer Marcano on 11/25/19
//  Copyright © 2019 Gilmer Marcano. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var nameArray1:[String] = [String]()
    var imageArray1:[String] = [String]()
    var idArray1:[String] = [String]()
    
    @IBOutlet weak var moneyIn: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var valorRecibido: String?
    
    override func viewDidLoad() {
      
        super.viewDidLoad()

        moneyIn.text = valorRecibido
        tableView.dataSource = self
        tableView.delegate = self
             
        let cellViewStr: String = String(describing: CellView.self)
        let nibCell = UINib.init(nibName: cellViewStr, bundle: nil)
        
        tableView.register(nibCell, forCellReuseIdentifier: "identifierCell")
        
        self.getCards()
    }

    func getCards(){
        let str:String = "https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88"
            
        // str lo convertimos a un Objeto url
        let objUrl: URL? = URL(string:str)

        let tarea:URLSessionDataTask = URLSession.shared.dataTask(with: objUrl!){ (datos: Data?, respuesta: URLResponse?, error: Error?) in
     
            // Evaluamos si existe algun error en la peticion que hicimos
            if error != nil{
                print(error!)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]

                    for object in json {
                        if let name = object["name"] as? String {
                            self.nameArray1.append(name)
                        }
                        if let image = object["secure_thumbnail"] as? String{
                            self.imageArray1.append(image)
                        }
                        if let id = object["id"] as? String{
                            self.idArray1.append(id)
                        }
                    }
                    
                    //self.nameArray1 = nameArray
                    //self.imageArray1 = imageArray
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            
        }
        
        tarea.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("tableView numero de elementos")
        return nameArray1.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "identifierCell", for: indexPath)
           
        cell.textLabel?.text = nameArray1[indexPath.row]
        
        if let img: String = imageArray1[indexPath.row], !img.isEmpty {
            Alamofire.request(img)
                .responseImage { (response) in
                    if let image: UIImage = response.result.value {
                        let size = CGSize(width: 30.0, height: 20.0)
                        let scaledImage = image.af_imageScaled(to: size)
                        cell.imageView?.image = scaledImage
                    }
            }
        }
        
        return cell
           // esta funcion lo que espera de return es una celda. una celda que vaya a mostrar
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let idSelected: String = self.idArray1[indexPath.row]

        self.performSegue(withIdentifier: "segue2", sender: idSelected)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue2"{
            let viewController3: ViewController3 = segue.destination as! ViewController3
                
            
            viewController3.valorRecibido2 = self.valorRecibido!
            viewController3.idName = sender as? String
        }
    }
       
}

