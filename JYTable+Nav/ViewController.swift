//
//  ViewController.swift
//  JYTable+Nav
//
//  Created by atom on 2017/2/20.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, ParallaxHeaderViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.setMyBackgroundColor(color: UIColor(red: 0/255.0, green: 130/255.0, blue: 210/255.0, alpha: 0))
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 100))
        
        imageView.image = UIImage(named: "ba1ec0437cc8d5367a516ff69b01ea89")
        imageView.contentMode = .scaleToFill
        
        let headerViewSize = CGSize(width: self.tableView.bounds.width, height: 100)
        
        let header = ParallHeaderView(style: .Thumb, subView: imageView, headerViewSize: headerViewSize, maxOffsetY: -120, delegate: self)
        
        self.tableView.tableHeaderView = header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "test\(indexPath.row)"
        return cell!
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! ParallHeaderView
        headerView.layoutHeaderViewWhenScroll(offset: scrollView.contentOffset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

