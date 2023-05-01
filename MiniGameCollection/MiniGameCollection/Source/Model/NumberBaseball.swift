//
//  NumberBaseball.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/04/23.
//

struct NumberBaseball: Playable {

    let name: String = "숫자 야구"
    let imageName: String = "baseball"
    let description: String = """
                              사용자는 정답으로 생각하는 숫자를 입력하고, 결과를 확인해 정답을 추리해내는 게임입니다.

                              다음은 세부 규칙입니다.

                              숫자가 정답에 있지만 위치가 틀렸을 경우 볼.
                              숫자가 정확한 위치에 있는 경우 스트라이크.
                              어떤 숫자도 정답에 포함되지 않을 경우 아웃.
                              사용할 수 있는 숫자는 0에서 9까지 서로 중복되지 않는 숫자로 구성합니다.
                              처음 주어진 이닝 내에서 정답을 맞출 경우 승리, 그렇지 못할 경우 패배입니다.
                              """
}
