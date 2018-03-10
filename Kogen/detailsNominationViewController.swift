//
//  detailsNominationViewController.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 7/13/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit
import Alamofire

class detailsNominationViewController: UIViewController {

    var nominationId = ""
    
    var privateListId           = [String]()
    var privateListName         = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        parseMembers()
    }

    func parseMembers()
    {
        let nominationURL = "http://ksinfo1000.com/backend.php/connect/nomination?nomination_id="+self.nominationId
        print(nominationURL)
        self.privateListId = []
        self.privateListName = []
        Alamofire.request(nominationURL).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let items = value["nomination"] as? [[String: AnyObject]]
                {
                    for item in items
                    {
                        if var id = item["id"] {
                            self.privateListId.append(id as! String)
                        }
                        if var name = item["name"] {
                            self.privateListName.append(name as! String)
                        }
                        //self.contestTable.reloadData()
                    }
                }
            }
        }
    }
    
}
