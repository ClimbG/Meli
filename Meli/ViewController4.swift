//
//  ViewController4.swift
//  Meli
//

//  Copyright © 2019 Gilmer Marcano. All rights reserved.
//

import Foundation
import UIKit

class ViewController4: UIViewController{
    
    var message: [Message] = []
    var valorRecibido3:String?
    var idName2:String?
    var idSelected3:String?
    
    @IBOutlet weak var quotaView: UITableView!
    
    override func viewDidLoad() {
        quotaView.dataSource = self
        quotaView.delegate = self
        let cellViewStr: String = String(describing: CellView.self)
        let nibCell = UINib.init(nibName: cellViewStr, bundle: nil)
        quotaView.register(nibCell, forCellReuseIdentifier: "identifierCell")
        
        getQuota()
    }
    
    func getQuota(){
        let str: String = "https://api.mercadopago.com/v1/payment_methods/installments?public_key=444a9ef5-8a6b-429f-abdf-587639155d88&amount=\(valorRecibido3!)&payment_method_id=\(idName2!)&issuer.id=\(idSelected3!)"
        
        let objUrl:URL? = URL(string: str)
        let tarea:URLSessionDataTask = URLSession.shared.dataTask(with: objUrl!){ (datos: Data?, respuesta: URLResponse?, error: Error?) in
            do{
                let costList: [Cost] = try JSONDecoder().decode([Cost].self, from: datos!)
                let costObject = costList.first!
                self.message = costObject.payerCosts
                print("Ok Json Decoder")
                
                DispatchQueue.main.async {
                    self.quotaView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        tarea.resume()
    }

}

extension ViewController4: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = quotaView.dequeueReusableCell(withIdentifier: "identifierCell", for: indexPath)
           
        cell.textLabel?.text = message[indexPath.row].recommendedMessage
        return cell
    }
}

struct Cost: Codable  {
    let payerCosts:[Message]
    
    enum CodingKeys: String, CodingKey {
        case payerCosts = "payer_costs"
    }
}

struct Message: Codable {
    let recommendedMessage: String
    
    enum CodingKeys: String, CodingKey {
        case recommendedMessage = "recommended_message"
    }
}
