import Quickshell
import QtQuick.Effects
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

import "../widgets"
import "../colors"
import "../widgets/audio"
import "../widgets/battery"

PanelWindow {
    id: toplevel
    anchors {
        top: true
        left: true
        right: true
    }
    aboveWindows: false
    implicitHeight:40 
    color: WalColors.background

    RowLayout {
        id: layout
        anchors.fill: parent
        Rectangle {
            color: 'transparent'
            Layout.fillWidth: true
            Layout.minimumWidth: 100
            Layout.preferredWidth: 200
            Layout.preferredHeight: parent.height
            Row{
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 20
                spacing: 10
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 25
                    color: WalColors.foreground
                    text: " "
                }
                WorkSpace{}
            }
        }
        Rectangle {
            color: 'transparent'
            Layout.fillWidth: true
            Layout.minimumWidth: 50
            Layout.maximumWidth: 600
            Layout.preferredWidth: 200
            Layout.preferredHeight: parent.height
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Layout.topMargin: 10
                Layout.bottomMargin: 5
                radius: 5 
                width: clockText.width + 10
                height: clockText.height + 10
                color: WalColors.color4
                SystemClock {
                    id: clock
                    precision: SystemClock.Minutes
                }
                Text {
                    id: clockText
                    text: "    " + clock.date.toLocaleString(Qt.locale(), "hh:mm")
                    font.bold: true
                    anchors.centerIn: parent
                    color: WalColors.background 
                }
            }
        }
        Rectangle {
            color: 'transparent'
            Layout.fillWidth: true
            Layout.minimumWidth: 100
            Layout.preferredWidth: 200
            Layout.minimumHeight: 40
            Layout.preferredHeight: parent.height

            RowLayout{
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10
                CustomeButton{
                    text: "󰻠 34%"
                    colorButtonUp: WalColors.color4
                    colorButtonDown: WalColors.color7
                }
                CustomeButton{
                    text: " "
                    colorButtonUp: WalColors.color5
                    colorButtonDown: WalColors.color7
                }
                Audio{
                    colorButtonUp: WalColors.color6
                    colorButtonDown: WalColors.color7
                }
                Battery{
                    colorButtonUp: WalColors.color7
                    colorButtonDown: WalColors.color8
                }
            }
        }
        }
    }
