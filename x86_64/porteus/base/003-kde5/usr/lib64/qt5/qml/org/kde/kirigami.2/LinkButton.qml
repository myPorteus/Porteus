/*
 *  SPDX-FileCopyrightText: 2018 Aleix Pol Gonzalez <aleixpol@blue-systems.com>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.2
import org.kde.kirigami 2.14
import QtQuick.Controls 2.1 as QQC2

/**
 * Shows a Button that looks like a link
 *
 * Uses the link color settings and allows to trigger an action when clicked.
 *
 * Maps to the Command Link in the HIG:
 * https://hig.kde.org/components/navigation/commandlink.html
 *
 * @since 5.52
 * @since org.kde.kirigami 2.6
 * @inherit QtQuick.Controls.Label
 */
QQC2.Label {
    id: control

    property Action action: null
    /**
     * @var Qt::MouseButtons acceptedButtons
     * This property holds the mouse buttons that the mouse area reacts to.
     * See <a href="https://doc.qt.io/qt-5/qml-qtquick-mousearea.html#acceptedButtons-prop">Qt documentation</a>.
     */
    property alias acceptedButtons: area.acceptedButtons
    /**
     * @var MouseArea ara
     * Mouse area element covering the button.
     */
    property alias mouseArea: area
    Accessible.role: Accessible.Button
    Accessible.name: text
    Accessible.onPressAction: control.clicked(null)

    text: action ? action.text : ""
    enabled: !action || action.enabled
    onClicked: if (action) action.trigger()

    font.underline: control.enabled && area.containsMouse
    color: enabled ? Theme.linkColor : Theme.textColor
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight

    signal pressed(QtObject mouse)
    signal clicked(QtObject mouse)
    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: control.clicked(mouse)
        onPressed: control.pressed(mouse)
    }
}
