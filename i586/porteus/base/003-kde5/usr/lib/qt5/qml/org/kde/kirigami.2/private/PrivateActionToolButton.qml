/*
 *  SPDX-FileCopyrightText: 2016 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.7
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.4 as Controls
import org.kde.kirigami 2.14

Controls.ToolButton {
    id: control

    signal menuAboutToShow

    Icon {
        id: kirigamiIcon
        visible: false
        source: control.icon.name
    }

    hoverEnabled: true

    display: Controls.ToolButton.TextBesideIcon

    property bool showMenuArrow: !DisplayHint.displayHintSet(action, DisplayHint.HideChildIndicator)

    property var menuActions: {
        if (action && action.hasOwnProperty("children")) {
            return Array.prototype.map.call(action.children, (i) => i)
        }
        return []
    }

    property Component menuComponent: ActionsMenu {
        submenuComponent: ActionsMenu { }
    }

    property QtObject menu: null

    // We create the menu instance only when there are any actual menu items.
    // This also happens in the background, avoiding slowdowns due to menu item
    // creation on the main thread.
    onMenuActionsChanged: {
        if (menuComponent && menuActions.length > 0) {
            if (!menu) {
                var setupIncubatedMenu = function(incubatedMenu) {
                    menu = incubatedMenu
                    // Important: We handle the press on parent in the parent, so ignore it here.
                    menu.closePolicy = Controls.Popup.CloseOnEscape | Controls.Popup.CloseOnPressOutsideParent
                    menu.closed.connect(() => control.checked = false)
                    menu.actions = control.menuActions
                }
                let incubator = menuComponent.incubateObject(control, {"actions": menuActions})
                if (incubator.status != Component.Ready) {
                    incubator.onStatusChanged = function(status) {
                        if (status == Component.Ready) {
                            setupIncubatedMenu(incubator.object)
                        }
                    }
                } else {
                    setupIncubatedMenu(incubator.object);
                }
            } else {
                menu.actions = menuActions
            }
        }
    }

    visible: (action && action.hasOwnProperty("visible")) ? action.visible : true

    // Workaround for QTBUG-85941
    Binding {
        target: control
        property: "checkable"
        value: (control.action && control.action.checkable) || (control.menuActions && control.menuActions.length > 0)
    }

    onToggled: {
        if (menuActions.length > 0 && menu) {
            if (checked) {
                control.menuAboutToShow();
                menu.popup(control, 0, control.height)
            } else {
                menu.dismiss()
            }
        }
    }

    Controls.ToolTip.visible: control.hovered && Controls.ToolTip.text.length > 0 && !(menu && menu.visible) && !control.pressed
    Controls.ToolTip.text: action ? (action.tooltip && action.tooltip.length ? action.tooltip : action.text) : ""
    Controls.ToolTip.delay: Units.toolTipDelay
    Controls.ToolTip.timeout: 5000

    // This is slightly ugly but saves us from needing to recreate the entire
    // contents of the toolbutton. When using QQC2-desktop-style, the background
    // will be an item that renders the entire control. We can simply set a
    // property on it to get a menu arrow.
    // TODO: Support other styles
    Component.onCompleted: {
        if (background.hasOwnProperty("showMenuArrow")) {
            background.showMenuArrow = Qt.binding(() => { return control.showMenuArrow && control.menuActions.length > 0 })
        }
    }
}
