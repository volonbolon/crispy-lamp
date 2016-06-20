//
//  ContainerViewController.swift
//  CrispyLamp
//
//  Created by Ariel Rodriguez on 6/20/16.
//  Copyright © 2016 Ariel Rodriguez. All rights reserved.
//

import UIKit

struct Identifier: Hashable {
    let humanReadable:String
    let unique:String
    
    var hashValue: Int {
        get {
            return self.unique.hashValue
        }
    }
}

func ==(lhs: Identifier, rhs: Identifier) -> Bool {
    return lhs.unique == rhs.unique
}

protocol IdentifiedViewController {
    var identifier:Identifier { get }
}

class ContainerViewController: UIViewController {
    private var transitionInProgress = false
    
    private var archivedViewControllers:[[Identifier:IdentifiedViewController]] {
        get {
            var values:[[Identifier:IdentifiedViewController]] = []
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let animalsVC = storyboard.instantiateViewControllerWithIdentifier(Constants.StoryboardIdentifier.AnimalsTableViewController) as? IdentifiedViewController {
                let v = [
                    animalsVC.identifier:animalsVC
                ]
                values.append(v)
            }
            
            if let colorsVC = storyboard.instantiateViewControllerWithIdentifier(Constants.StoryboardIdentifier.ColorsTableViewController) as? IdentifiedViewController {
                let v = [
                    colorsVC.identifier:colorsVC
                ]
                values.append(v)
            }
            
            return values
        }
    }
    
    var childrenNames:[String] {
        get {
            var names:[String] = []
            for cvc in self.archivedViewControllers {
                if let i = cvc.keys.first {
                    names.append(i.humanReadable)
                }
            }
            return names
        }
    }
    
    var presentingIdentifier:Identifier!
    
    enum SegueIdentifier:String {
        case Colors = "colorsSegue"
        case Animals = "animalsSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.performSegueWithIdentifier(SegueIdentifier.Animals.rawValue, sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        guard let segueIdentifier = segue.identifier else { return }
//        if let sid = SegueIdentifier(rawValue: segueIdentifier) {
//            switch sid {
//            case .Colors:
//                print("colors")
//            case .Animals:
//                let dvc =
//            }
//        }
        let dvc = segue.destinationViewController
        if dvc is IdentifiedViewController {
            let identifier = (dvc as! IdentifiedViewController).identifier
            guard identifier != self.presentingIdentifier else { return }
            self.presentingIdentifier = identifier
            
            if let fvc = self.childViewControllers.first {
                self.swap(fvc, toViewController: dvc)
            } else {
                self.addChildViewController(dvc)
                let dv = dvc.view
                dv.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
                self.view.addSubview(dv)
                dvc.didMoveToParentViewController(self)
            }
        }
        
        
        
//        if self.childrenViewController[identifier] == nil {
//            self.childrenViewController[identifier] = dvc
//        }
//        let tvc = self.childrenViewController[identifier]
        
     }
    
    func swap(fromViewController:UIViewController, toViewController:UIViewController) {
        
    }

    
//    func selectedIdentifierChanged(Int:) {
//        
//    }

}
