//
//  TableViewController.swift
//  
//
//  Created by Jamie Maddocks on 28/07/2015.
//
//

import UIKit
import Alamofire

class TableViewController: UITableViewController, AddIdeaViewControllerDelegate {
    private var ideas = Array<Dictionary<String, AnyObject>>()
    private let ideaListEndpoint = "http://api.rusic.com/buckets/" + Credentials().bucketID + "/ideas"
    private let participantToken = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Alamofire.request(.GET, )
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadIdeaData", name: "participantTokenRecieved", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "spaceTitleRecieved", name: "spaceTitleRecieved", object: nil)
        
    }
    
    func spaceTitleRecieved() {
        let d = NSUserDefaults.standardUserDefaults()
        navigationItem.title = d.objectForKey("space_title") as! String
    }
    
    func reloadIdeaData() {
        let token = NSUserDefaults.standardUserDefaults().objectForKey("token") as! String
        
        let headers = ["X-API-Key": Credentials().apiKey, "Accept": "application/vnd.rusic.v1+json",
            "X-Rusic-Participant-Token": token]
        Alamofire.request(.GET, ideaListEndpoint, parameters: nil, encoding: ParameterEncoding.URL, headers: headers).responseJSON { _, _, json, _ in
            self.ideas = (json!) as! Array<Dictionary<String, AnyObject>>
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
            })

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addIdeaViewControllerDidFinish() {
        reloadIdeaData()
        self.navigationController!.popViewControllerAnimated(true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return ideas.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        let idea = ideas[indexPath.row] as Dictionary<String, AnyObject>
        
        
        let title = idea["title"] as! String!
        let likes = (idea["likes_count"] as! NSNumber).stringValue
        let comments = (idea["comments_count"] as! NSNumber!).stringValue
        cell.textLabel!.text = title + " - Likes: (" + likes + ") Comments: (" + comments + ")"
        cell.detailTextLabel!.text = (idea["content"]!) as! String

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "add_idea" {
            let dvc = segue.destinationViewController as! AddIdeaViewController
            dvc.delegate = self
        }
    }

}
