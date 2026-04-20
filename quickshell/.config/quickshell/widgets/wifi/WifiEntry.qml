import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import "../../colors"

Rectangle {
    id: root
    property string ssid: ""
    property string signal: ""
    property string security: ""
    property bool active: false
    
    signal clicked()

    width: parent.width
    height: 45
    color: active ? WalColors.color4 : (mouseArea.containsMouse ? WalColors.color8 : "transparent")
    radius: 8
    opacity: active ? 1 : 0.8
    
    Behavior on color { ColorAnimation { duration: 150 } }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 12

        Text {
            text: active ? "󰖩" : "󰖪"
            font.pixelSize: 18
            color: root.active ? WalColors.background : WalColors.foreground
        }

        ColumnLayout {
            spacing: 0
            Layout.fillWidth: true
            Text {
                text: ssid === "" ? "<Hidden SSID>" : ssid
                font.bold: true
                font.pixelSize: 13
                color: root.active ? WalColors.background : WalColors.foreground
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
            Text {
                text: security
                font.pixelSize: 10
                color: root.active ? WalColors.background : WalColors.foreground
                opacity: 0.7
            }
        }

        Text {
            text: signal + "%"
            font.pixelSize: 11
            color: root.active ? WalColors.background : WalColors.foreground
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
        cursorShape: Qt.PointingHandCursor
    }
}
