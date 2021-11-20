/*
 *  SPDX-FileCopyrightText: 2018 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.5
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.5

AbstractApplicationHeader {
    id: root
   // anchors.fill: parent
    property Item container
    property bool current

    minimumHeight: pageRow ? pageRow.globalToolBar.minimumHeight : Units.iconSizes.medium + Units.smallSpacing * 2
    maximumHeight: pageRow ? pageRow.globalToolBar.maximumHeight : minimumHeight
    preferredHeight: pageRow ? pageRow.globalToolBar.preferredHeight : minimumHeight

    separatorVisible: pageRow ? pageRow.globalToolBar.separatorVisible : true

    Theme.colorSet: pageRow ? pageRow.globalToolBar.colorSet : Theme.Header

    leftPadding: pageRow ? (Math.min(Qt.application.layoutDirection == Qt.LeftToRight
                            ? Math.max(page.title.length > 0 ? Units.gridUnit : 0, pageRow.ScenePosition.x - page.ScenePosition.x + pageRow.globalToolBar.leftReservedSpace + Units.smallSpacing)
                            : Math.max(page.title.length > 0 ? Units.gridUnit : 0, -pageRow.width + pageRow.ScenePosition.x + page.ScenePosition.x + page.width + pageRow.globalToolBar.leftReservedSpace),
                        root.width/2))
                         :  Units.smallSpacing

    rightPadding: pageRow ? (Qt.application.layoutDirection == Qt.LeftToRight
                            ? Math.max(0, -pageRow.width - pageRow.ScenePosition.x + page.ScenePosition.x + page.width + pageRow.globalToolBar.rightReservedSpace)
                            : Math.max(0, pageRow.ScenePosition.x - page.ScenePosition.x + pageRow.globalToolBar.rightReservedSpace))
                          : 0
}
