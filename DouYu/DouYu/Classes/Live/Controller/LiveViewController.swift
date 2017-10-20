//
//  LiveViewController.swift
//  DouYu
//
//  Created by iOS_Tian on 2017/10/18.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController {

    @IBOutlet weak var tableVIew: UITableView!
    // MARK: 懒加载ViewModel对象
    fileprivate lazy var happyVM : HappyViewModel = HappyViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "直播列表"
        happyVM.loadFunnyData {
            self.tableVIew.reloadData()
        }
    }
}


//MARK:
extension LiveViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return happyVM.anchorGroups.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return happyVM.anchorGroups[section].anchors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let model = happyVM.anchorGroups[indexPath.section].anchors[indexPath.row]
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.textLabel?.text = model.room_name
            cell?.accessoryType = .disclosureIndicator
        }
        if #available(iOS 9.0, *) {
            if traitCollection.forceTouchCapability == .available {
                //支持3D Touch
                //注册Peek & Pop功能
                registerForPreviewing(with: self, sourceView: cell!)
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let username = ShowRoomViewController()
        username.hidesBottomBarWhenPushed = true
        present(username, animated: true, completion: nil)
    }
}


//MARK: UIViewControllerPreviewingDelegate
extension LiveViewController: UIViewControllerPreviewingDelegate{
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        //1. 获取按压的cell所在的行
        guard let cell = previewingContext.sourceView as? UITableViewCell else { return UIViewController() }
        let indexPath = tableVIew.indexPath(for: cell) ?? IndexPath(row: 0, section: 0)
        
        //2. 设定预览界面
        let vc = ShowRoomViewController()
        // 预览区域大小(可不设置), 0为默认尺寸
        vc.preferredContentSize = CGSize(width: 0, height: 0)
        vc.showStr =  "我是第\(indexPath.row)行用力按压进来的"
        
        //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
        let rect = CGRect(x: 0, y: 0, width: kScreenWidth, height: 44)
        //设置触发操作的视图的不被虚化的区域
        previewingContext.sourceRect = rect
        
        //返回预览界面
        return vc
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        viewControllerToCommit.hidesBottomBarWhenPushed = true
        show(viewControllerToCommit, sender: self)
    }
}

extension LiveViewController {
    //重写previewActionItems的get方法
    override var previewActionItems: [UIPreviewActionItem] {
        let action1 = UIPreviewAction(title: "跳转", style: .default) { (action, previewViewController) in
            let showVC = ShowRoomViewController()
            showVC.hidesBottomBarWhenPushed = true
            previewViewController.navigationController?.pushViewController(showVC, animated: true)
        }
        
        let action3 = UIPreviewAction(title: "取消", style: .destructive) { (action, previewViewController) in
            print("我是取消按钮")
        }
        
        ////该按钮可以是一个组，点击该组时，跳到组里面的按钮。
        let subAction1 = UIPreviewAction(title: "测试1", style: .selected) { (action, previewViewController) in
            print("我是测试按钮1")
        }
        let subAction2 = UIPreviewAction(title: "测试2", style: .selected) { (action, previewViewController) in
            print("我是测试按钮2")
        }
        let subAction3 = UIPreviewAction(title: "测试3", style: .selected) { (action, previewViewController) in
            print("我是测试按钮3")
        }
        let groupAction = UIPreviewActionGroup(title: "更多", style: .default, actions: [subAction1, subAction2, subAction3])
        
        return [action1, action3, groupAction]
    }
}

//MARK: 获取touch重力
extension LiveViewController {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first ?? UITouch()
        //获取重按力度
        print("平均触摸的力--\(touch.force)")
        print("触摸的最大可能力--\(touch.maximumPossibleForce)")
    }
    
}
