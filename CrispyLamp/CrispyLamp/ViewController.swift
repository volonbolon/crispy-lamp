//
//  ViewController.swift
//  CrispyLamp
//
//  Created by Ariel Rodriguez on 6/20/16.
//  Copyright © 2016 Ariel Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var containerViewController:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier
        if identifier == Constants.SegueIdentifier.EmbedContainer {
            self.containerViewController = segue.destinationViewController
        }
    }
}

