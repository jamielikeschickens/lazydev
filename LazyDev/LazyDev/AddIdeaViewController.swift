//
//  AddIdeaViewController.swift
//  
//
//  Created by Jamie Maddocks on 28/07/2015.
//
//

import UIKit
import Alamofire

protocol AddIdeaViewControllerDelegate {
    func addIdeaViewControllerDidFinish()
}

class AddIdeaViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!
    private let addIdeaEndpoint = "http://api.rusic.com/buckets/" + Credentials().bucketID + "/ideas"
    var delegate: AddIdeaViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePressed() {
        let token = NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
        
        let headers = ["X-API-Key": Credentials().apiKey, "Accept": "application/vnd.rusic.v1+json",
            "X-Rusic-Participant-Token": token]
        let params = ["idea[title]": titleTextField.text, "idea[content]": contentTextField.text]
        
        Alamofire.request(.POST, addIdeaEndpoint, parameters: params, encoding: .URL, headers: headers).responseJSON {(_, _, json, _) in
            self.delegate!.addIdeaViewControllerDidFinish()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
