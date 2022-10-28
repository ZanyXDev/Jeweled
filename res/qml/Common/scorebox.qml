        //    Item {
        //        id: scoreBox

        //        width: parent.width
        //        height: 60 * DevicePixelRatio /* cellSize*1.5, actually */
        //        state: "stateHidden"

        //        anchors.top: parent.top

        //        Text {
        //            id: txtScore
        //            color: "white"
        //            font.family: gameFont.name
        //            font.pointSize: 16 * DevicePixelRatio
        //            font.bold: true
        //            text: gameBoard.score
        //            anchors.bottom: parent.bottom
        //            anchors.leftMargin: 10 * DevicePixelRatio
        //            anchors.bottomMargin: 5 * DevicePixelRatio
        //        }

        //        Text {
        //            id: txtLevel
        //            color: "white"
        //            font.family: gameFont.name
        //            font.pointSize: 16 * DevicePixelRatio
        //            font.bold: true
        //            text: "Level " + gameBoard.level + " "
        //            anchors.bottom: parent.bottom
        //            anchors.rightMargin: 10 * DevicePixelRatio
        //            anchors.bottomMargin: 5 * DevicePixelRatio
        //        }

        //        states: [
        //            State {
        //                name: "stateNormal"
        //                AnchorChanges {
        //                    target: txtScore
        //                    anchors.left: scoreBox.left
        //                }
        //                AnchorChanges {
        //                    target: txtLevel
        //                    anchors.right: scoreBox.right
        //                }
        //            },
        //            State {
        //                name: "stateHidden"
        //                AnchorChanges {
        //                    target: txtScore
        //                    anchors.right: scoreBox.left
        //                }
        //                AnchorChanges {
        //                    target: txtLevel
        //                    anchors.left: scoreBox.right
        //                }
        //            }
        //        ]

        //        transitions: [
        //            Transition {
        //                from: "stateHidden"
        //                to: "stateNormal"
        //                AnchorAnimation {
        //                    duration: 200
        //                    easing.type: Easing.Linear
        //                }
        //            },
        //            Transition {
        //                from: "stateNormal"
        //                to: "stateHidden"
        //                AnchorAnimation {
        //                    duration: 200
        //                    easing.type: Easing.Linear
        //                }
        //            }
        //        ]
        //    }
