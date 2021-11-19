/*
 *   Copyright 2018 Aleix Pol Gonzalez <aleixpol@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Library General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.3
import QtQuick.Controls 2.3 as Controls

Controls.MenuItem {
    id: menuItem

    property QtObject ourAction

    text: ourAction.text
    visible: ourAction.visible !== undefined ? ourAction.visible : true
    enabled: ourAction.enabled
    checkable: ourAction.checkable
    checked: ourAction.checked
    height: visible ? implicitHeight : 0
    icon.name: ourAction.icon.name
    autoExclusive: ourAction.Controls.ActionGroup && ourAction.Controls.ActionGroup.group && ourAction.Controls.ActionGroup.group.exclusive
    onTriggered: {
        ourAction.trigger()
    }
}
