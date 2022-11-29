import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import Common 1.0

QQC2.Popup {
    id: root

    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    parent: QQC2.Overlay.overlay
    modal: true
    focus: true
    closePolicy: QQC2.Popup.NoAutoClose

    ColumnLayout {
        id: mainPopupAboutLayout
        anchors.fill: parent
        spacing: 2 * DevicePixelRatio

        component InfoLablel: QQC2.Label {
            Layout.fillWidth: true

            font {
                family: AppSingleton.aboutFont.name
                pointSize: AppSingleton.largeFontSize
                bold: true
            }
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        InfoLablel {
            id: dlgTitle
            Layout.preferredHeight: 40 * DevicePixelRatio
            text: qsTr("About")
        }

        QQC2.Frame {
            id: spacerFrame
            visible: true
            Layout.fillWidth: true
            Layout.preferredHeight: 2 * DevicePixelRatio
        }

        InfoLablel {
            id: dlgBody
            Layout.preferredHeight: 120 * DevicePixelRatio
            font.pointSize: AppSingleton.smallFontSize
            //TODO add android intents !!! url and email link
            text: qsTr(
                      "<p align=\"center\"><b>FreeJeweled</b> is a free Bejeweled2 inspired game</p>"
                      + "<p align=\"center\"><b>Game Authors:</b></p>"
                      + "<p align=\"center\">Boris Kuchin, elricbk@gmail.com</p>"
                      + "<p align=\"center\">ZanyXDev, zanyxdev@gmail.com</p>"
                      + "<p align=\"center\"><b>Gem Images</b></p>"
                      + "<p align=\"center\">Sebastien Delestaing, Gweled creator"
                      + "<p align=\"center\"><b>Background Images</b></p>"
                      + "<p align=\"center\">Cosmos Packages by #resurgere on devianArt.com"
                      + "<p align=\"center\"><b>Fonts</b></p>"
                      + "<p align=\"center\">Pirulen, MailRays, RedCircle, ForgottenFuturist fonts from 1001freefonts.com")
        }
        RowLayout {
            id: btnLayout
            spacing: 2 * DevicePixelRatio
            Layout.fillWidth: true
            Item {
                Layout.fillWidth: true
            }
            QQC2.Button {
                id: okBtn
                text: qsTr("Close")
                onClicked: {
                    root.close()
                }
            }
            Item {
                Layout.fillWidth: true
            }
        }
    }
}
