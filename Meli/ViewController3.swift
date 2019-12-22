//
//  ViewController3.swift
//  Meli
//
//  Created by Gilmer Marcano on 12/16/19.
//  Copyright © 2019 Gilmer Marcano. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class ViewController3: UIViewController,  UITableViewDelegate, UITableViewDataSource{
    
    var banks:[String] = [String]()
    var imageBanks:[String] = [String]()
    var idNumbers:[String] = [String]()


    @IBOutlet weak var banksView: UITableView!
    @IBOutlet weak var moneyIn2: UILabel!
    
    var valorRecibido2: String?
    var idName: String?
   
   
    override func viewDidLoad() {
        super.viewDidLoad()

        moneyIn2.text = valorRecibido2
        banksView.dataSource = self
        banksView.delegate = self
        
        let cellViewStr: String = String(describing: CellView.self)
        let nibCell = UINib.init(nibName: cellViewStr, bundle: nil)
        banksView.register(nibCell, forCellReuseIdentifier: "identifierCell")
    
        getBanks()
    }
    
    func getBanks() {
        let str:String = "https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=444a9ef5-8a6b-429f-abdf-587639155d88&payment_method_id=\(idName!)"
        
        let objUrl:URL? = URL(string: str)

        let tarea:URLSessionDataTask = URLSession.shared.dataTask(with: objUrl!){ (datos: Data?, respuesta: URLResponse?, error: Error?) in
           
                  if error != nil{
                      print(error!)
                  } else {
                      do {
                          let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]

                          for object in json {
                              if let name = object["name"] as? String {
                                  self.banks.append(name)
                              }
                              if let image = object["secure_thumbnail"] as? String{
                                  self.imageBanks.append(image)
                              }
                              if let id = object["id"] as? String{
                                self.idNumbers.append(id)
                            }
                          }
                          DispatchQueue.main.async {
                              self.banksView.reloadData()
                          }
                      } catch let error {
                          print(error.localizedDescription)
                      }
                  }
                  
            }
            tarea.resume()
        
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return banks.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
    let cell: UITableViewCell = banksView.dequeueReusableCell(withIdentifier: "identifierCell", for: indexPath)
          
    cell.textLabel?.text = banks[indexPath.row]
    
    if let img: String = imageBanks[indexPath.row], !img.isEmpty {
        Alamofire.request(img).responseImage { (response) in
            if let image:UIImage = response.result.value {
                cell.imageView?.image = image.resize()
            }
        }
    }
    return cell
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idSelected2: String = self.idNumbers[indexPath.row]
        self.performSegue(withIdentifier: "segue3", sender: idSelected2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue3"{
            let viewController4: ViewController4 = segue.destination as! ViewController4
            viewController4.idName2 = idName!
            viewController4.idSelected3 = sender as! String
            viewController4.valorRecibido3 = valorRecibido2!
    }
}
}

extension UIImage {
    func resize() -> UIImage {
        let size = CGSize(width: 20.0, height: 10.0)
        let scaledImage = self.af_imageScaled(to: size)
        return scaledImage
    }
    
}
