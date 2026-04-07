import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    anchors {
        bottom: true
        left: true
        right: true
    }

    implicitHeight: 36

    // Catppuccin Mocha palette
    readonly property color base:     "#1e1e2e"
    readonly property color mantle:   "#181825"
    readonly property color surface0: "#313244"
    readonly property color surface1: "#45475a"
    readonly property color overlay0: "#6c7086"
    readonly property color textColor:"#cdd6f4"
    readonly property color subtext1: "#bac2de"
    readonly property color teal:     "#94e2d5"
    readonly property color lavender: "#b4befe"
    readonly property color blue:     "#89b4fa"
    readonly property color mauve:    "#cba6f7"
    readonly property color peach:    "#fab387"
    readonly property color green:    "#a6e3a1"
    readonly property color red:      "#f38ba8"

    readonly property string monoFont: "JetBrainsMono Nerd Font"

    color: base

    // Clock ticker
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    // --- Clock (absolutely centered) ---
    Text {
        anchors.centerIn: parent
        text: Qt.formatDateTime(clock.date, "ddd, MMM d  hh:mm")
        font.pixelSize: 14
        font.family: monoFont
        color: textColor
    }

    // --- Workspaces (left) ---
    RowLayout {
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        Repeater {
            model: Hyprland.workspaces

            delegate: Rectangle {
                required property var modelData

                implicitWidth: 28
                implicitHeight: 28
                radius: 6

                color: {
                    if (modelData.focused) return teal
                    if (modelData.active)  return surface1
                    return surface0
                }

                Behavior on color {
                    ColorAnimation { duration: 200; easing.type: Easing.OutCubic }
                }

                scale: mouseArea.containsPress ? 0.88 : 1.0
                Behavior on scale {
                    NumberAnimation { duration: 120; easing.type: Easing.OutCubic }
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: modelData.activate()
                    cursorShape: Qt.PointingHandCursor
                }

                Text {
                    anchors.centerIn: parent
                    text: modelData.id > 0 ? modelData.id : modelData.name
                    font.pixelSize: 13
                    font.family: monoFont
                    font.bold: modelData.focused
                    color: modelData.focused ? "#000000" : textColor

                    Behavior on color {
                        ColorAnimation { duration: 200; easing.type: Easing.OutCubic }
                    }
                }
            }
        }
    }
}
