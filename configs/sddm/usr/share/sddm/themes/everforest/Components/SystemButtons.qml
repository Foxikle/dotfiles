// Foxgrove — SystemButtons.qml

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

RowLayout {
    spacing: root.font.pointSize * 2.5

    property var suspend:   ["Suspend",   config.TranslateSuspend   || textConstants.suspend,   sddm.canSuspend]
    property var hibernate: ["Hibernate", config.TranslateHibernate || textConstants.hibernate, sddm.canHibernate]
    property var reboot:    ["Reboot",    config.TranslateReboot    || textConstants.reboot,    sddm.canReboot]
    property var shutdown:  ["Shutdown",  config.TranslateShutdown  || textConstants.shutdown,  sddm.canPowerOff]

    property var exposedSession

    Repeater {
        id: systemButtons
        model: [suspend, hibernate, reboot, shutdown]

        Item {
            visible: config.ForceHideSystemButtons != "true" && modelData[2]
            width: iconBtn.width
            height: iconBtn.height + tipLabel.implicitHeight + 4

            RoundButton {
                id: iconBtn
                hoverEnabled: true
                width: root.font.pointSize * 2.8
                height: root.font.pointSize * 2.8
                display: AbstractButton.IconOnly

                icon.source: modelData ? Qt.resolvedUrl("../Assets/" + modelData[0] + ".svgz") : ""
                icon.width:  root.font.pointSize * 1.5
                icon.height: root.font.pointSize * 1.5
                // Explicitly white so SVGs are always light on the dark card
                icon.color:  iconBtn.hovered || iconBtn.activeFocus
                               ? root.palette.highlight
                               : "#E8DCC8"

                background: Rectangle {
                    radius: width / 2
                    color: iconBtn.hovered || iconBtn.activeFocus
                             ? Qt.rgba(root.palette.highlight.r, root.palette.highlight.g, root.palette.highlight.b, 0.15)
                             : "transparent"
                    border.color: iconBtn.activeFocus ? root.palette.highlight : "transparent"
                    border.width: 1
                    Behavior on color { PropertyAnimation { duration: 150 } }
                }

                Behavior on icon.color { PropertyAnimation { duration: 150 } }

                Keys.onReturnPressed: clicked()
                onClicked: {
                    parent.forceActiveFocus()
                    index == 0 ? sddm.suspend() :
                    index == 1 ? sddm.hibernate() :
                    index == 2 ? sddm.reboot() :
                                 sddm.powerOff()
                }
                KeyNavigation.up: exposedSession
                KeyNavigation.left: parent.parent.children[index > 0 ? index - 1 : 0]
            }

            Label {
                id: tipLabel
                anchors.top: iconBtn.bottom
                anchors.horizontalCenter: iconBtn.horizontalCenter
                anchors.topMargin: 3
                text: modelData[1]
                font.family: root.font.family
                font.pointSize: root.font.pointSize * 0.6
                font.letterSpacing: root.font.pointSize * 0.15
                color: iconBtn.hovered || iconBtn.activeFocus
                         ? root.palette.highlight
                         : "#E8DCC8"
                Behavior on color { PropertyAnimation { duration: 150 } }
            }
        }
    }
}
