/*
 * SPDX-FileCopyrightText: 2020 Andrey Butirsky <butirsky@gmail.com>
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick 2.12
import Qt.labs.platform 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.workspace.components 2.0

KeyboardLayoutSwitcher {
    id: root

    Plasmoid.toolTipSubText: layoutNames.longName

    Plasmoid.status: hasMultipleKeyboardLayouts ? PlasmaCore.Types.ActiveStatus : PlasmaCore.Types.HiddenStatus
    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation

    function iconURL(name) {
        return StandardPaths.locate(StandardPaths.GenericDataLocation,
                    "kf5/locale/countries/" + name + "/flag.png")
    }

    Connections {
        target: keyboardLayout

        function onLayoutsListChanged() {
            plasmoid.clearActions()

            keyboardLayout.layoutsList.forEach(
                function(layout, index) {
                    plasmoid.setAction(
                        index,
                        layout.longName,
                        iconURL(layout.shortName).toString().substring(7) // remove file:// scheme
                    )
                }
            )
        }

        function onLayoutChanged() {
            root.Plasmoid.activated()
        }
    }

    function actionTriggered(selectedLayout) {
        keyboardLayout.layout = selectedLayout
    }


    hoverEnabled: true

    PlasmaCore.IconItem {
        id: icon

        source: iconURL(layoutNames.shortName)
        visible: plasmoid.configuration.showFlag && source
        anchors.fill: parent
        active: containsMouse
    }

    PlasmaComponents3.Label {
        text: layoutNames.displayName || layoutNames.shortName
        visible: !icon.visible
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        fontSizeMode: Text.Fit
        font.pointSize: height
    }
}
