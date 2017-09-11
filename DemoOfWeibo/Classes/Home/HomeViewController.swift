//
//  HomeViewController.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/10.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: BaseViewController {
    
    fileprivate lazy var titleBtn: TitleButton = TitleButton()
    
    fileprivate lazy var statuses: [Status] = [Status]()
    
    fileprivate lazy var modelView: [StatusViewModel] = [StatusViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        visitor.rotationImg.isHidden = false
        visitor.loadRotationImg()
        
        if !isLogin {
            return
        }
        
        setNavBarItems()
        loadStatuses()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeDirection), name: Notification.Name(rawValue: "changeArrowDirection"), object: nil)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        tableView.separatorStyle = .none
    }
}

extension HomeViewController {
    func setNavBarItems() {

        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        titleBtn.setTitle("iWelsie", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClicked), for: .touchUpInside)
        
        navigationItem.titleView = titleBtn
        
    }
    
    func changeDirection() {
        titleBtn.isSelected = !titleBtn.isSelected
        
    }
}

extension HomeViewController {
    func titleBtnClicked() {
        
        titleBtn.isSelected = !titleBtn.isSelected
        
        let popoverVC = PopoverViewController()
        
        popoverVC.modalPresentationStyle = .custom                                                                                          //设置modal样式
        
        popoverVC.transitioningDelegate = self
        
        present(popoverVC, animated: true, completion: nil)
        
        
    }
    
    func coverViewDidClicked() {
        titleBtn.isSelected = !titleBtn.isSelected
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {                                                                       //遵循Transitioning协议
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PopoverPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension HomeViewController {
    fileprivate func loadStatuses() {
        NetworkTools.shareInstance.loadStatuses { (result, error) in
            if error != nil {
                print(error ?? "homeViewController loadStatuses error")
                return
            }
            
            guard let resultArray = result else {
                return
            }
            
            for resultItems in resultArray {
                let status = Status(dict: resultItems)
                let viewModel = StatusViewModel(status: status)
                self.modelView.append(viewModel)
            }
            
            self.cacheImages(self.modelView)
            
        }
    }
    
    fileprivate func cacheImages(_ viewModels: [StatusViewModel]) {
        let group = DispatchGroup()
        
        for viewModel in viewModels {
            for picURL in viewModel.picURLs {
                group.enter()
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: picURL, options: [], progress: nil, completed: { (_, _, _, _) in
                    group.leave()
                })
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.tableView.reloadData()
        }
        
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelView.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeViewCell
        
        cell.viewModel = modelView[indexPath.row]
        
        return cell
    }
    
}
