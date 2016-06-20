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
    private var animationDirection = UIViewAnimationOptions.TransitionFlipFromRight
    
    private var archivedViewControllers:[IdentifiedViewController] {
        get {
            var values:[IdentifiedViewController] = []
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let animalsVC = storyboard.instantiateViewControllerWithIdentifier(Constants.StoryboardIdentifier.AnimalsTableViewController) as? IdentifiedViewController {
                values.append(animalsVC)
            }
            
            if let colorsVC = storyboard.instantiateViewControllerWithIdentifier(Constants.StoryboardIdentifier.ColorsTableViewController) as? IdentifiedViewController {
                values.append(colorsVC)
            }
            
            return values
        }
    }
    
    var childrenNames:[String] {
        get {
            var names:[String] = []
            for cvc in self.archivedViewControllers {
                let i = cvc.identifier
                names.append(i.humanReadable)
            }
            return names
        }
    }
    
    var presentingIdentifier:Identifier!
    
    enum SegueIdentifier:String {
        case Colors = "colorsSegue"
        case Animals = "animalsSegue"
        
        init?(identifier:Identifier) {
            if identifier.unique == "Colors" {
                self = .Colors
            } else if identifier.unique == "Animals" {
                self = .Animals
            } else {
                return nil
            }
        }
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
        guard let segueIdentifier = segue.identifier else { return }
        if let sid = SegueIdentifier(rawValue: segueIdentifier) {
            let dvc = segue.destinationViewController
            if dvc is IdentifiedViewController {
                self.animationDirection = UIViewAnimationOptions.TransitionFlipFromLeft
                switch sid {
                case .Colors:
                    self.swap(self.childViewControllers.first!, toViewController: dvc)
                case .Animals:
                    self.animationDirection = UIViewAnimationOptions.TransitionFlipFromRight
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
            }
        }
    }
    
    func swap(fromViewController:UIViewController, toViewController:UIViewController) {
        guard self.transitionInProgress == false else { return }
        self.transitionInProgress = true
        
        toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        fromViewController.willMoveToParentViewController(nil)
        self.addChildViewController(toViewController)
        self.transitionFromViewController(fromViewController, toViewController: toViewController, duration: 0.5, options:[self.animationDirection, UIViewAnimationOptions.CurveEaseOut], animations:nil) { (finished:Bool) -> Void in
            fromViewController.removeFromParentViewController()
            toViewController.didMoveToParentViewController(self)
            self.transitionInProgress = false
        }
    }

    // We are going to change the selector
    func selectedIdentifierChanged(selector:AnimatedSegmentedControl) {
        let i = self.archivedViewControllers[selector.selectedSegmentIndex]
        self.presentingIdentifier = i.identifier
        if let si = SegueIdentifier(identifier: i.identifier) {
            self.performSegueWithIdentifier(si.rawValue, sender: nil)
        }
    }
}
