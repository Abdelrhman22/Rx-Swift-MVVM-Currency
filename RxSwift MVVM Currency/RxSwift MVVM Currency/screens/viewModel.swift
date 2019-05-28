//
//  viewModel.swift
//  RxSwift MVVM Currency
//
//  Created by JETS Mobile Lab - 9 on 5/28/19.
//  Copyright © 2019 Abd elrhman. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxAlamofire

class viewModel{
    
    let disposableBag = DisposeBag()
    var view : ViewController?
    let jsonURL :  String = "https://api.exchangeratesapi.io/latest"
    let networkObj: networkProtocol = Network()
    private var dataSubject = PublishSubject<Dictionary<String,Double>>()
    public var dataObservable : Observable<Dictionary<String,Double>>?
    init()
    {
        dataObservable = dataSubject.asObservable()
        self.useObservable()
    }
    
    func useObservable()
    {
        networkObj.getObservableResponse(apiUrl: jsonURL).subscribe(onNext: { [weak self] in
            if let dict=$0.1 as?[String:Any]{
                if let dictValue = dict["rates"] as? Dictionary<String,Double>
                {
                    self?.dataSubject.onNext(dictValue)
                }
            }}).disposed(by: disposableBag)
    }
    
    
    
}
