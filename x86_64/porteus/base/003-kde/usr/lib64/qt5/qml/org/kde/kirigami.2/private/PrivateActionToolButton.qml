/*
 *   Copyright 2016 Marco Martin <mart@kde.org>
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

import QtQuick 2.6
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0 as Controls
import org.kde.kirigami 2.4

Controls.ToolButton {
    id: control

    signal menuAboutToShow

    implicitWidth: menuArrow.visible || (showText && ( kirigamiAction ? kirigamiAction.text.length > 0 : text.length > 0))
            ? Math.max(layout.implicitWidth + Units.largeSpacing*2, background.implicitWidth)
            : implicitHeight
    implicitHeight: background.implicitHeight

    Theme.colorSet: Theme.Button
    Theme.inherit: kirigamiAction && kirigamiAction.icon.color.a === 0
    Theme.backgroundColor: kirigamiAction && kirigamiAction.icon.color.a ? kirigamiAction.icon.color : undefined
    Theme.textColor: kirigamiAction && !flat && kirigamiAction.icon.color.a ? Theme.highlightedTextColor : undefined

    hoverEnabled: true
    flat: !control.kirigamiAction || !control.kirigamiAction.icon.color.a
    //TODO: replace with upstream action when we depend on Qt 5.10
    property Action kirigamiAction
    property bool showText: true
    property bool showMenuArrow: true
    property alias menu: menu

    //we need our own text delegate
    text: ""
    checkable: kirigamiAction && kirigamiAction.checkable
    checked: (kirigamiAction && kirigamiAction.checked) || menu.visible
    enabled: kirigamiAction && kirigamiAction.enabled
    opacity: enabled ? 1 : 0.4
    visible: kirigamiAction && kirigamiAction.visible
    onClicked: {
        if (kirigamiAction) {
            kirigamiAction.trigger();
        }
        if (kirigamiAction.children.length > 0 && !menu.visible) {
            control.menuAboutToShow();
            menu.popup(control, 0, control.height)
        }
    }

    ActionsMenu {
        id: menu
        y: control.height
        actions: control.kirigamiAction ? control.kirigamiAction.children : null
        submenuComponent: Component {
            ActionsMenu {}
        }
    }

    contentItem: MouseArea {
        hoverEnabled: true
        onPressed: mouse.accepted = false
        Theme.colorSet: checked && (control.kirigamiAction && control.kirigamiAction.icon.color.a) ? Theme.Selection : control.Theme.colorSet
        Theme.inherit: control.kirigamiAction && Theme.colorSet != Theme.Selection && control.kirigamiAction.icon.color.a === 0
        RowLayout {
            id: layout

            anchors.centerIn: parent
            Icon {
                id: mainIcon
                Layout.minimumWidth: Units.iconSizes.smallMedium
                Layout.minimumHeight: Units.iconSizes.smallMedium
                source: control.kirigamiAction ? (control.kirigamiAction.icon ? control.kirigamiAction.icon.name : control.kirigamiAction.iconName) : ""
                visible: control.kirigamiAction && control.kirigamiAction.iconName != ""
                color: control.flat && control.kirigamiAction && control.kirigamiAction.icon && control.kirigamiAction.icon.color.a > 0 ? control.kirigamiAction.icon.color : label.color
            }
            Controls.Label {
                id: label
                MnemonicData.enabled: control.enabled
                MnemonicData.controlType: MnemonicData.ActionElement
                MnemonicData.label: control.kirigamiAction ? control.kirigamiAction.text : ""

                text: MnemonicData.richTextLabel
                visible: control.showText && text.length > 0
            }
            Icon {
                id: menuArrow
                Layout.minimumWidth: Units.iconSizes.small
                Layout.minimumHeight: Units.iconSizes.small
                color: mainIcon.color
                source: "arrow-down"
                visible: showMenuArrow && menu.actions && menu.actions.length > 0
            }
        }
    }
    Controls.ToolTip {
        visible: control.hovered && text.length > 0 && !menu.visible
        text: kirigamiAction ? (kirigamiAction.tooltip.length ? kirigamiAction.tooltip : kirigamiAction.text) : ""
        delay: 1000
        timeout: 5000
        y: control.height
    }
}
