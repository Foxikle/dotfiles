// Foxgrove — Clock.qml

import QtQuick 2.15
import QtQuick.Controls 2.15

Column {
    id: clock
    spacing: root.font.pointSize * 0.3
    width: root.width * 0.5

    // ── Time ─────────────────────────────────────────────────────
    Label {
        id: timeLabel
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: root.font.family
        font.pointSize: root.font.pointSize * 5.5
        font.weight: Font.Bold
        color: "#0D1B2A"
        renderType: Text.QtRendering

        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(config.Locale),
                      config.HourFormat == "long" ? Locale.LongFormat :
                      config.HourFormat !== ""     ? config.HourFormat : "HH:mm")
        }
    }

    // ── Aurora divider ────────────────────────────────────────────
    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        width: root.font.pointSize * 18
        height: 2
        opacity: 0.75
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0;  color: "transparent" }
            GradientStop { position: 0.3;  color: root.palette.highlight }
            GradientStop { position: 0.7;  color: root.palette.highlight }
            GradientStop { position: 1.0;  color: "transparent" }
        }
    }

    // ── Date ──────────────────────────────────────────────────────
    Label {
        id: dateLabel
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: root.font.family
        font.pointSize: root.font.pointSize * 1.15
        font.letterSpacing: root.font.pointSize * 0.4
        color: "#0D1B2A"
        opacity: 0.85
        renderType: Text.QtRendering

        function updateTime() {
            text = new Date().toLocaleDateString(Qt.locale(config.Locale),
                      config.DateFormat == "short" ? Locale.ShortFormat :
                      config.DateFormat !== ""      ? config.DateFormat  : Locale.LongFormat).toUpperCase()
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: { dateLabel.updateTime(); timeLabel.updateTime() }
    }

    Component.onCompleted: { dateLabel.updateTime(); timeLabel.updateTime() }
}
