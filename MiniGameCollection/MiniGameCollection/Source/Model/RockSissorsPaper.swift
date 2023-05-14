//
//  RockSissorsPaper.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/05/05.
//

struct RockSissorsPaper: Playable {

    let name: String = "묵찌빠"
    let imageName: String = "hand.wave"
    let description: String = """
                              사용자는 가위, 바위, 보 중에 한 가지를 선택하고, 컴퓨터의 선택과 비교해 승자를 가려내는 게임입니다.

                              다음은 세부 규칙입니다.

                              가위는 보를 이깁니다.
                              바위는 가위를 이깁니다.
                              보는 바위를 이깁니다.
                              같은 선택지는 비깁니다.

                              가위바위보에는 묵찌빠라는 확장판이 존재합니다.
                              묵찌빠는 가위바위보로 승부가 가려졌을 때 이어서 진행하는 게임입니다.

                              다음은 세부 규칙입니다.

                              처음에는 가위바위보를 이긴 사람이 공격권을 갖습니다.
                              같은 선택지를 내면 공격권을 가진 사람이 이깁니다.
                              서로 다른 선택지를 냈을 경우 가위바위보 규칙을 기준으로 이기는 사람이 공격권을 갖습니다.
                              """
}

extension RockSissorsPaper {

    enum HandShape: CustomStringConvertible {

        case rock
        case sissors
        case paper

        var description: String {
            switch self {
            case .rock:
                return "✊"
            case .sissors:
                return "✌️"
            case .paper:
                return "🖐️"
            }
        }
    }
}
