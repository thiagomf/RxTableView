//
//  ViewController.swift
//  RxTableView
//
//  Created by Thiago M Faria on 26/03/20.
//  Copyright © 2020 Thiago M Faria. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       bindTableView()
    }

    func bindTableView() {
        
        let cities = Observable.of(["Lisboa", "São Paulo", "Londres"])
        
        cities.bind(to: tableView.rx.items) {
            (tableView: UITableView, index: Int, element: String) in
            
            let cell = UITableViewCell(style: .default, reuseIdentifier:  "cell")
            cell.textLabel?.text = element
            return cell
            }
        .disposed(by: dispose)
        
        tableView.rx.modelSelected(String.self)
            .subscribe(onNext: { model in
                print("\(model) was selected")
            })
        .disposed(by: dispose)
    }
}

