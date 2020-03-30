//
//  MultipleViewController.swift
//  RxTableView
//
//  Created by Thiago M Faria on 26/03/20.
//  Copyright © 2020 Thiago M Faria. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum MyModel {
    case text(String)
    case pairofImages(UIImage, UIImage)
}

class MultipleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "titleCell")

        tableView.register(UINib(nibName: "ImagesCell", bundle: nil), forCellReuseIdentifier: "pairOfImage")

        tableView.estimatedRowHeight = 50
        
        let observable = Observable<[MyModel]>.just([
            .text("Paris"),
            .pairofImages(UIImage(named: "1")!, UIImage(named: "2")!),
            .text("São Paulo"),
            .pairofImages(UIImage(named: "3")!, UIImage(named: "4")!)
        ])
        
        observable.bind(to: tableView.rx.items) {
            (tableView: UITableView, index: Int, element: MyModel) in
            let indexPath = IndexPath(item: index, section: 0)
            switch element {
            case .text(let title):
                let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! TextCell
                cell.titleLabel.text = title
                return cell
            case .pairofImages(let firstImage, let secondImage):
                let cell = tableView.dequeueReusableCell(withIdentifier: "pairOfImage", for: indexPath) as! ImagesCell
                cell.leftImage.image = firstImage
                cell.rightImage.image = secondImage
                return cell
            }
        }.disposed(by: dispose)
    }
    

}
