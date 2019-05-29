//
//  myViewModel.swift
//  RxSwift MVVM Currency
//
//  Created by JETS Mobile Lab - 9 on 5/29/19.
//  Copyright © 2019 Abd elrhman. All rights reserved.
//
import RxAlamofire
import RxCocoa
import RxSwift
import RxAlamofire

class  myViewModel {
    
    let apiCall = APIClient()
    
    let disposableBag = DisposeBag()
    private var dataSubject = PublishSubject<Dictionary<String,Double>>()
    public var dataObservable : Observable<Dictionary<String,Double>>?
    init()
    {
        dataObservable = dataSubject.asObservable()
        self.fetchJson()
    }
    
    func fetchJson()
    {
        apiCall.executejsonAPICall(urlString: "https://api.exchangeratesapi.io/latest",
        httpMethod: HTTpServerMethod.get, paramates: nil, header: nil, sucessHandler: {
        [weak self] (responseData) in
        // code for sucess
        print("Sucess fetchJson ..... ")
            if let dict = responseData as?[String:Any]
            {
                if let dictValue = dict["rates"] as? Dictionary<String,Double>
                {
                    self?.dataSubject.onNext(dictValue)
                }
            }
        })
        { [weak self] (error) in
            // code for error
            print(error)
        }
    }
    //***************************************************************************************
    func fetchData()
    {
        apiCall.executeDataAPICall(urlString: "https://api.exchangeratesapi.io/latest",
                                   httpMethod: HTTpServerMethod.get, paramates: nil, header: nil, sucessHandler: {
                                    [weak self] (responseData) in
                                    // code for sucess
                                    print("Sucess fetchData ..... ")
        }){ [weak self] (error) in
            // code for error
            print(error)
        }
    }
}
