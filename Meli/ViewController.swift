//
//  ViewController.swift
//  Meli
//
//  Created by Gilmer Marcano on 11/24/19.
//  Copyright © 2019 Gilmer Marcano. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!

   
    @IBOutlet weak var confButton: UIButton!
    

    var numero:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        confButton.layer.cornerRadius = 7
        
        
       
    }

    @IBAction func buttonContinuar(_ sender: Any) {
        
        numero = textField.text!

      
}
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
        
        if segue.identifier == "segue1"{
        
        
        let numeroPantalla2: ViewController2 = segue.destination as! ViewController2
        
        numeroPantalla2.valorRecibido = numero
    }
     
    }
}
