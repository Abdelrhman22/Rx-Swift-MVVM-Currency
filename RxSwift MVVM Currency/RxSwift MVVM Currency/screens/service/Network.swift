//
//  Network.swift
//  RxSwift MVVM Currency
//
//  Created by JETS Mobile Lab - 9 on 5/28/19.
//  Copyright © 2019 Abd elrhman. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxAlamofire

class Network : networkProtocol
{
    func getObservableResponse(apiUrl: String) -> Observable<(HTTPURLResponse, Any)>
    {
        return RxAlamofire.requestJSON(.get, apiUrl)
    }

}
