import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2

import Common 1.0

Item {
    id: root

    property alias bgrColor: background.color
    property alias folded: background.folded

    property Component inlineContent: ContentItem {}

    component ContentItem: Text {
        text: qsTr("Not defined inline content Item")
        color: "red"
    }
    Rectangle {
        id: background
        anchors.fill: parent
        property bool folded: true
        border.color: "grey"
        border.width: 3
        state: !folded ? "Visible" : "Invisible"
        states: [
            State {
                name: "Visible"
                PropertyChanges {
                    target: background
                    opacity: 1.0
                }
                PropertyChanges {
                    target: background
                    visible: true
                }
            },
            State {
                name: "Invisible"
                PropertyChanges {
                    target: background
                    opacity: 0.0
                }
                PropertyChanges {
                    target: background
                    visible: false
                }
            }
        ]
        transitions: [
            Transition {
                from: "Visible"
                to: "Invisible"

                SequentialAnimation {
                    NumberAnimation {
                        target: background
                        property: "opacity"
                        duration: AppSingleton.timer800
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        target: background
                        property: "visible"
                        duration: 0
                    }
                }
            },
            Transition {
                from: "Invisible"
                to: "Visible"
                SequentialAnimation {
                    NumberAnimation {
                        target: background
                        property: "visible"
                        duration: 0
                    }
                    NumberAnimation {
                        target: background
                        property: "opacity"
                        duration: AppSingleton.timer800
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        ]
        Loader {
            id: loader
            sourceComponent: inlineContent
        }
    }
}
