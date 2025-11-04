import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.UPower
import Quickshell

Button {
  required property string colorBorder;
  required property string colorButtonUp;
  required property string colorButtonDown;
  required property string colorText;
  property string stateBattery: (UPower.onBattery) ? "󰁹" : "󰂅 " ;
  property UPower power: UPower;

  id: button

  background: Rectangle {
    implicitWidth: 80
    implicitHeight: 30
    color: button.down ? colorButtonDown : colorButtonUp
    border.color: colorBorder
    border.width: 2
    radius: 10

    RowLayout {
      anchors.centerIn: parent
      Text {
        text: stateBattery + " " + power.displayDevice.percentage * 100 + " %"
      }
      Text {
        id: batteryText
      }
    }

    // Connections để lắng nghe sự thay đổi pin
    Connections {
      target: UPower
      onPercentageChanged: {
        batteryText.text = UPower.percentage + "%"
      }
      onStateChanged: {
        stateBattery = (UPower.onBattery) ? "󰂅 " : "󰁹" 
      }
    }
  }
}
