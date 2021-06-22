//
//  CP2_Card.swift
//  Study_Stanford
//
//  Created by Kang Minsang on 2021/06/22.
//

import Foundation

struct CP2_Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = CP2_Card.getUniqueIdentifier()
    }
}


// 구조체는 상속성이 없다 (더 간단하다)
// 구조체는 값 타입이고, 클래스는 참조 타입이다
// 값 타입 : 복사된다

//static func : 타입에 관한 정적 메소드
