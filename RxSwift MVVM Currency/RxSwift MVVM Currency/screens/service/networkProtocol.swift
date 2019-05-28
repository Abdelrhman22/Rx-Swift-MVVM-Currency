//
//  networkProtocol.swift
//  RxSwift MVVM Currency
//
//  Created by JETS Mobile Lab - 9 on 5/28/19.
//  Copyright © 2019 Abd elrhman. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire

protocol networkProtocol
{
    func getObservableResponse(apiUrl: String) -> Observable<(HTTPURLResponse,Any)>
}
