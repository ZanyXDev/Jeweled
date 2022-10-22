import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

Item {
    id: dlgAbout
    property int cellSize: 40

    anchors.fill: parent

    FontLoader {
        id: aboutFont
        source: "qrc:/res/fonts/forgotte.ttf"
    }

    Rectangle {
        anchors.fill: dlgAbout
        color: "black"
        opacity: 0.3
    }

    Text {
        id: dlgTitle
        anchors {
            horizontalCenter: dlgAbout.horizontalCenter
            top: dlgAbout.top
            margins: 10 * cellSize / 40
        }
        text: "About"
        color: "white"
        font.bold: true
        font.pointSize: 36 * cellSize / 40
        font.family: aboutFont.name
    }

    Text {
        anchors {
            horizontalCenter: dlgAbout.horizontalCenter
            margins: 5 * cellSize / 40
            top: dlgTitle.bottom
        }
        width: dlgAbout.width - 2 * anchors.margins
        font.pointSize: 16 * cellSize / 40
        font.family: aboutFont.name
        color: "white"
        wrapMode: Text.WordWrap
        text: "<p align=\"center\"><b>FreeJeweled</b> is a free Bejeweled2 inspired game</p>"
              + "<p align=\"center\"><b>Game Authors</b></p>"
              + "<p align=\"center\">Boris Kuchin, elricbk@gmail.com</p>"
              + "<p align=\"center\">ZanyXDev, zanyxdev@gmail.com</p>"
              + "<p align=\"center\"><b>Gem Images</b></p>"
              + "<p align=\"center\">Sebastien Delestaing, Gweled creator"
              + "<p align=\"center\"><b>Background Images</b></p>"
              + "<p align=\"center\">Cosmos Packages by #resurgere on devianArt.com"
              + "<p align=\"center\"><b>Fonts</b></p>"
              + "<p align=\"center\">Pirulen, MailRays, RedCircle, ForgottenFuturist fonts from 1001freefonts.com"
    }
}
