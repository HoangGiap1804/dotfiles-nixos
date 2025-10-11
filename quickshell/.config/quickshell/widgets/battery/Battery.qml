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


  id: button
  // onClicked: {
  //   // node.audio.muted = !node.audio.muted
  //   console.log('hello')
  //   AudioPanelSingleton.toggle()
  // }

  background: Rectangle {
    implicitWidth: 70
    implicitHeight: 30
    color: button.down ? colorButtonDown : colorButtonUp
    border.color: colorBorder
    border.width: 2
    radius: 10

    RowLayout {
      anchors.centerIn: parent
      Text {
        text: "󰂀"
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
        console.log("Pin trạng thái: " + UPower.state)
      }
    }
  }
}
