//
//  ViewController.swift
//  CrispyLamp
//
//  Created by Ariel Rodriguez on 6/20/16.
//  Copyright © 2016 Ariel Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var containerViewController:ContainerViewController?
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    func setupSegmentedControl() {
        guard let cvc = self.containerViewController else { return }
        
        self.segmentedControl.addTarget(self.containerViewController, action: #selector(ContainerViewController.selectedIdentifierChanged), forControlEvents: UIControlEvents.ValueChanged)
        
        let names = cvc.childrenNames
        self.segmentedControl.removeAllSegments()
        for (i, n) in names.enumerate() {
            self.segmentedControl.insertSegmentWithTitle(n, atIndex: i, animated: false)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSegmentedControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier
        if identifier == Constants.SegueIdentifier.EmbedContainer {
            self.containerViewController = (segue.destinationViewController as! ContainerViewController)
        }
    }
}

