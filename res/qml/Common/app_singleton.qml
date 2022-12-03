pragma Singleton

import QtQuick 2.15

QtObject {
    id: root
    readonly property int largeFontSize: 36
    readonly property int middleFontSize: 24
    readonly property int smallFontSize: 12
    readonly property int tinyFontSize: 10

    property FontLoader gameFont: FontLoader {
        id: gameFont
        source: "qrc:/res/fonts/mailrays.ttf"
    }

    property FontLoader buttonFont: FontLoader {
        id: buttonFont
        source: "qrc:/res/fonts/pirulen.ttf"
    }
    property FontLoader aboutFont: FontLoader {
        id: aboutFont
        source: "qrc:/res/fonts/forgotte.ttf"
    }

    readonly property int smallCellSize: 37 * DevicePixelRatio /// TODO Remove   DevicePixelRatio!!! and move other place
    readonly property int bigSellSize: smallCellSize * 2
    readonly property int defaultRowCount: 8
    readonly property int defaultColumnCount: 8
    readonly property int cellCount: defaultRowCount * defaultColumnCount

    /* This is msecs. Half of second is enough for smooth animation. */
    readonly property int timer200: 200
    readonly property int timer500: 500
    readonly property int timer800: 800
    readonly property int timer1000: 1000
    readonly property int timer2000: 2000
    readonly property int timerInterval: 500
    readonly property int enoughTimeToDie: 1000 // достаточноеВремяДляСмерти

    readonly property int animationStopTreshhold: 3
    readonly property int levelCapMultiplayer: 60

    readonly property int huperCubeMultiplayer: 2
    readonly property double difficultyMultiplayer: 1.07

    function toLog(tag, msg) {
        console.trace()
        console.log(`TAG [${tag}] ${msg}`)
    }
}
