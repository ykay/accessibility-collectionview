//
//  ViewController.swift
//  collectionview test
//
//  Created by Yuichi Kuroda on 8/6/16.
//
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.pagingEnabled = true
        
        nextButton.addTarget(self, action: #selector(onNextButtonTapped), forControlEvents: .TouchUpInside)
        nextButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(CollectionTableViewCell.self, forCellReuseIdentifier: "CollectionTableViewCell")
    }
    
    func onNextButtonTapped() {
        currentIndex += 1
        let nextIndexPath = NSIndexPath(forRow: currentIndex, inSection: 0)
        collectionView.scrollToItemAtIndexPath(nextIndexPath, atScrollPosition: .CenteredHorizontally, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CollectionTableViewCell") as! CollectionTableViewCell
        cell.isAccessibilityElement = false
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250.0
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UICollectionViewCell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.cyanColor()
        
        for v in cell.contentView.subviews {
            v.removeFromSuperview()
        }
        
        let label = UILabel()
        label.frame = cell.bounds
        label.text = "      I'm label \(indexPath.row)"
        cell.contentView.addSubview(label)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let collectionViewSize = collectionView.bounds.size
        return CGSizeMake(collectionViewSize.width, collectionViewSize.height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
}

