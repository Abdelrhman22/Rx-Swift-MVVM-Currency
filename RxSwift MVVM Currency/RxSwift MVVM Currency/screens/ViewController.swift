//
//  ViewController.swift
//  RxSwift MVVM Currency
//
//  Created by Esraa Hassan on 5/28/19.
//  Copyright © 2019 Abd elrhman. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxAlamofire
class ViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    let disposeBag = DisposeBag()
    var viewModelObj : viewModel?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewModelObj = viewModel()
        viewModelObj?.dataObservable?.bind(to: self.mainCollectionView.rx.items(cellIdentifier: "textCell", cellType: MyCollectionViewCell.self))
        {
            (row , data , cell) in
            cell.currencyLabel.text = data.key
            cell.rateLabel.text = String(data.value)
            
         }.disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

