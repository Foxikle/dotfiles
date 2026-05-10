// Foxgrove SDDM Theme
// Based on SDDM Sugar Candy (C) 2018–2020 Marian Arlt, GPLv3+

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

Pane {
    id: root

    height: config.ScreenHeight || Screen.height
    width: config.ScreenWidth || Screen.width

    LayoutMirroring.enabled: config.ForceRightToLeft == "true" ? true : Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    padding: 0
    palette.button: "transparent"
    palette.highlight: config.AccentColor
    palette.text: config.MainColor
    palette.buttonText: config.MainColor
    palette.window: config.BackgroundColor

    font.family: config.Font
    font.pointSize: config.FontSize !== "" ? config.FontSize : parseInt(height / 80)
    focus: true

    Item {
        id: sizeHelper
        anchors.fill: parent

        // ── Wallpaper ─────────────────────────────────────────────
        Image {
            id: backgroundImage
            anchors.fill: parent
            source: config.background || config.Background
            fillMode: Image.PreserveAspectCrop
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter
            asynchronous: true
            cache: true
            clip: true
            mipmap: true
        }

        // ── Vignette — clear mid, dark at bottom ──────────────────
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0;  color: Qt.rgba(0.05, 0.07, 0.12, 0.15) }
                GradientStop { position: 0.55; color: Qt.rgba(0.05, 0.07, 0.12, 0.05) }
                GradientStop { position: 1.0;  color: Qt.rgba(0.05, 0.07, 0.12, 0.72) }
            }
            z: 1
        }

        MouseArea {
            anchors.fill: parent
            z: 0
            onClicked: sizeHelper.forceActiveFocus()
        }

        // ── Clock — upper center ──────────────────────────────────
        Loader {
            id: clock
            source: "Components/Clock.qml"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: root.height * 0.07
            z: 2
        }

        // ── Login card — lower center ─────────────────────────────
        Loader {
            id: form
            source: "Components/LoginForm.qml"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: root.height * 0.06
            width: Math.max(root.width * 0.28, 600)
            z: 2
        }
    }
}
