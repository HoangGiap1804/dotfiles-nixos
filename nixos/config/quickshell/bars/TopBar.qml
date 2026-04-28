import Quickshell
import Quickshell.Widgets
import QtQuick.Controls
import QtQuick.Effects
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

import "../widgets"
import "../colors"
import "../widgets/audio"
import "../widgets/battery"
import "../widgets/wifi"


PanelWindow {
  id: toplevel
  anchors {
    top: true
    left: true
    right: true
  }
  aboveWindows: false
  height: 30
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
        height: parent.height
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 20
        spacing: 10
        Text{
          anchors.verticalCenter: parent.verticalCenter
          font.pixelSize: parent.height * 0.6
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
        height: Math.min(parent.height * 0.8, clockText.height + 10)
        width: clockText.width + 15
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
          color: "#000000" 
        }
      }
    }
    Rectangle {
      color: 'transparent'
      Layout.fillWidth: true
      Layout.minimumWidth: 100
      Layout.preferredWidth: 200

      Layout.preferredHeight: parent.height

      RowLayout{
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 10
        spacing: 8

        SystemStats { id: stats }

        CustomeButton{
          text: "  " + stats.cpuUsage
          colorButtonUp: WalColors.color4
          colorButtonDown: WalColors.color7
          colorBorder: "transparent"
          colorText: WalColors.foreground
        }
        CustomeButton{
          text: "  " + stats.ramUsage
          colorButtonUp: WalColors.color3
          colorButtonDown: WalColors.color7
          colorBorder: "transparent"
          colorText: WalColors.foreground
        }
        CustomeButton{
          text: "󰢮  " + stats.gpuUsage
          colorButtonUp: WalColors.color2
          colorButtonDown: WalColors.color7
          colorBorder: "transparent"
          colorText: WalColors.foreground
        }
        CustomeButton{
          text: "   " + stats.wifiName
          colorButtonUp: WalColors.color5
          colorButtonDown: WalColors.color7
          colorBorder: "transparent"
          colorText: WalColors.foreground
          onClicked: WifiPanelSingleton.toggle()
        }
        Audio{
          colorButtonUp: WalColors.color6
          colorButtonDown: WalColors.color7
          colorBorder: "transparent"
          colorText: WalColors.foreground
        }
        Battery{
          colorButtonUp: WalColors.color7
          colorButtonDown: WalColors.color8
          colorBorder: "transparent"
          colorText: WalColors.foreground
        }
      }
    }
  }
}
