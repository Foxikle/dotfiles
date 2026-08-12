// Foxgrove — LoginForm.qml

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
import SddmComponents 2.0 as SDDM

Item {
    id: formContainer
    SDDM.TextConstants { id: textConstants }

    property alias systemButtonVisibility: systemButtons.visible
    property bool virtualKeyboardActive
    property var exposeSession: input.exposeSession

    // Fixed height — avoids implicitHeight binding loop
    height: root.height * 0.42
    width: parent ? parent.width : root.width * 0.36

    // ── Frosted glass card ────────────────────────────────────────
    Rectangle {
        id: card
        anchors.fill: parent
        color: Qt.rgba(0.05, 0.11, 0.18, 0.62)
        radius: 20
        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 0.10)

        // Top edge highlight
        Rectangle {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.6
            height: 1
            color: root.palette.highlight
            opacity: 0.35
            radius: 1
        }

        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 12
            radius: 32
            samples: 65
            color: Qt.rgba(0, 0, 0, 0.55)
            cached: true
        }

        ColumnLayout {
            id: cardColumn
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: root.font.pointSize * 1.8
                leftMargin: root.font.pointSize * 1.8
                rightMargin: root.font.pointSize * 1.8
            }
            spacing: root.font.pointSize * 0.6

            // Subtitle
            Label {
                Layout.alignment: Qt.AlignHCenter
                text: "Welcome to the Grove"
                font.family: root.font.family
                font.pointSize: root.font.pointSize * 0.85
                font.letterSpacing: root.font.pointSize * 0.55
                color: root.palette.highlight
                opacity: 0.90
                renderType: Text.QtRendering
            }

            // Separator
            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Qt.rgba(1, 1, 1, 0.08)
                Layout.topMargin: root.font.pointSize * 0.2
                Layout.bottomMargin: root.font.pointSize * 0.4
            }

            // Input fields
            Input {
                id: input
                Layout.fillWidth: true
                Layout.topMargin: root.font.pointSize * 0.2
            }

            // System buttons
            SystemButtons {
                id: systemButtons
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: root.font.pointSize * 0.4
                Layout.bottomMargin: root.font.pointSize * 0.6
                exposedSession: input.exposeSession
            }
        }
    }
}
