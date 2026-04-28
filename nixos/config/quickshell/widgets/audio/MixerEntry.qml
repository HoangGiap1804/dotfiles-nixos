import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Quickshell.Services.Pipewire
import "../../colors"

ColumnLayout {
    required property PwNode node
    spacing: 8
    Layout.fillWidth: true

    // bind the node so we can read its properties
    PwObjectTracker { objects: [ node ] }

    RowLayout {
        spacing: 12
        Layout.fillWidth: true
        
        Rectangle {
            id: muteButton
            width: 36
            height: 36
            radius: 18
            color: (node && node.audio && node.audio.muted) ? WalColors.color1 : WalColors.color4
            
            Text {
                anchors.centerIn: parent
                text: (node && node.audio && node.audio.muted) ? " " : " "
                color: WalColors.background
                font.pixelSize: 16
            }

            MouseArea {
                anchors.fill: parent
                onClicked: if (node && node.audio) node.audio.muted = !node.audio.muted
                cursorShape: Qt.PointingHandCursor
            }
            
            Behavior on color { ColorAnimation { duration: 200 } }
        }

        ColumnLayout {
            spacing: 0
            Layout.fillWidth: true
            
            Label {
                text: {
                    if (!node || !node.properties) return "";
                    const app = node.properties["application.name"] ?? (node.description != "" ? node.description : node.name);
                    return app;
                }
                font.bold: true
                font.pixelSize: 13
                color: WalColors.foreground
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
            
            Label {
                text: (node && node.properties) ? (node.properties["media.name"] ?? "") : ""
                visible: text !== ""
                font.pixelSize: 10
                color: WalColors.foreground
                opacity: 0.6
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }
        
        Label {
            text: (node && node.audio) ? `${Math.floor(node.audio.volume * 100)}%` : "0%"
            font.bold: true
            font.pixelSize: 12
            color: WalColors.foreground
            opacity: 0.8
        }
    }

    Slider {
        id: volumeSlider
        Layout.fillWidth: true
        value: (node && node.audio) ? node.audio.volume : 0
        onMoved: if (node && node.audio) node.audio.volume = value
        
        background: Rectangle {
            x: volumeSlider.leftPadding
            y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 4
            width: volumeSlider.availableWidth
            height: implicitHeight
            radius: 2
            color: WalColors.color8
            opacity: 0.2

            Rectangle {
                width: volumeSlider.visualPosition * parent.width
                height: parent.height
                color: WalColors.color4
                radius: 2
            }
        }

        handle: Rectangle {
            x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
            y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
            implicitWidth: 14
            implicitHeight: 14
            radius: 7
            color: WalColors.color4
            border.color: WalColors.foreground
            border.width: 1
            
            Behavior on x {
                enabled: !volumeSlider.pressed
                NumberAnimation { duration: 100 }
            }
        }
    }
}
