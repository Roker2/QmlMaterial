import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Templates as T
import QtQuick.Window

import Qcm.Material as MD

T.Menu {
    id: control

    property alias mdState: item_state

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, contentHeight + topPadding + bottomPadding)

    margins: 0
    verticalPadding: 8

    transformOrigin: !cascade ? Item.Top : (mirrored ? Item.TopRight : Item.TopLeft)

    delegate: MD.MenuItem {}

    property var model: contentModel

    enter: Transition {
        // grow_fade_in
        NumberAnimation {
            property: "scale"
            from: 0.9
            to: 1.0
            easing.type: Easing.OutQuint
            duration: 220
        }
        NumberAnimation {
            property: "opacity"
            from: 0.0
            to: 1.0
            easing.type: Easing.OutCubic
            duration: 150
        }
    }

    exit: Transition {
        // shrink_fade_out
        NumberAnimation {
            property: "scale"
            from: 1.0
            to: 0.9
            easing.type: Easing.OutQuint
            duration: 220
        }
        NumberAnimation {
            property: "opacity"
            from: 1.0
            to: 0.0
            easing.type: Easing.OutCubic
            duration: 150
        }
    }

    contentItem: ListView {
        implicitHeight: contentHeight

        model: control.model
        interactive: Window.window ? contentHeight + control.topPadding + control.bottomPadding > Window.window.height : false
        currentIndex: control.currentIndex

        ScrollIndicator.vertical: ScrollIndicator {}
    }

    background: MD.ElevationRectangle {
        implicitWidth: 200
        implicitHeight: 48
        radius: MD.Token.shape.corner.extra_small
        color: control.mdState.backgroundColor
        elevation: control.mdState.elevation
    }

    T.Overlay.modal: Rectangle {
        color: MD.Util.transparent(MD.Token.color.scrim, 0.32)
        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }
        }
    }

    T.Overlay.modeless: Rectangle {
        color: MD.Util.transparent(MD.Token.color.scrim, 0.32)
        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }
        }
    }

    MD.State {
        id: item_state
        visible: false

        elevation: MD.Token.elevation.level2
        textColor: MD.Token.color.on_surface
        backgroundColor: MD.Token.color.surface_container
        supportTextColor: MD.Token.color.on_surface_variant
    }
}
