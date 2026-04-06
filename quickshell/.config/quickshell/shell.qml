import Quickshell // for PanelWindow
import QtQuick // for Text

import Quickshell.Widgets
import QtQuick 2.0

import QtQuick.Layouts 1.1
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io

import "./bars"
import "./colors"
import "./widgets/audio"
import "./widgets/dock"
import "./utils"

ShellRoot{
    id: root

    Component.onCompleted: {
        WalColors.background = "#D9F";   // cập nhật trực tiếp
    }

    FileView {
        id: fileView
        path: "/home/nqim/.cache/wal/colors.json"
        onLoaded:{
            const fileContents = JSON.parse(fileView.text());
            WalColors.background = fileContents.special.background;
            WalColors.foreground = fileContents.special.foreground;
            WalColors.color0 = fileContents.colors.color0;
            WalColors.color1 = fileContents.colors.color1;
            WalColors.color2 = fileContents.colors.color2;
            WalColors.color3 = fileContents.colors.color3;
            WalColors.color4 = fileContents.colors.color4;
            WalColors.color5 = fileContents.colors.color5;
            WalColors.color6 = fileContents.colors.color6;
            WalColors.color7 = fileContents.colors.color7;
            WalColors.color8 = fileContents.colors.color8;
            WalColors.color9 = fileContents.colors.color9;
            WalColors.color10 = fileContents.colors.color10;
            WalColors.color11 = fileContents.colors.color11;
            WalColors.color12 = fileContents.colors.color12;
            WalColors.color13 = fileContents.colors.color13;
        }
    }
    TopBar{}
    // LeftBar{}
    ExtraPanel{}
    BottomLeftCorner{}
    BottomRightCorner{}
    TopLeftCorner{}
    TopRightCorner{}
    // Dock{}
}
