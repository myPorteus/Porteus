/*
 *  SPDX-FileCopyrightText: 2016 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.1
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0 as Controls

import org.kde.kirigami 2.4

Controls.ToolButton {
    id: button

    icon.name: (LayoutMirroring.enabled ? "go-next-symbolic-rtl" : "go-next-symbolic")

    enabled: applicationWindow().pageStack.currentIndex < applicationWindow().pageStack.depth-1

    property var showNavButtons: {
        try {
            return globalToolBar.showNavigationButtons
        } catch (_) {
            return false
        }
    }
    // The gridUnit wiggle room is used to not flicker the button visibility during an animated resize for instance due to a sidebar collapse
    visible: applicationWindow().pageStack.layers.depth == 1 && applicationWindow().pageStack.contentItem.contentWidth > applicationWindow().pageStack.width + Units.gridUnit && (showNavButtons === true || (showNavButtons & ApplicationHeaderStyle.ShowForwardButton))

    onClicked: applicationWindow().pageStack.goForward();

    Controls.ToolTip {
        visible: button.hovered
        text: qsTr("Navigate Forward")
        delay: Units.toolTipDelay
        timeout: 5000
        y: button.height
    }
}
