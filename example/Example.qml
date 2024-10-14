import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qcm.Material as MD

MD.Page {
    padding: 8

    MD.MatProp.page: m_page_ctx

    MD.PageContext {
        id: m_page_ctx
        showHeader: false
    }

    contentItem: ColumnLayout {
        id: content
        spacing: 0

        MD.TabBar {
            id: bar_test
            Layout.fillWidth: true
            spacing: 0
            clip: true

            MD.TabButton {
                action: Action {
                    text: 'components'
                    onTriggered: {
                        bar_test.currentIndex = 0;
                        view_container.replace(view_container.currentItem, 'qrc:/Qcm/Material/Example/Components.qml', {});
                    }
                }

                Component.onCompleted: {
                    action.trigger();
                }
            }

            MD.TabButton {
                action: Action {
                    text: 'color'
                    onTriggered: {
                        bar_test.currentIndex = 1;
                        view_container.replace(view_container.currentItem, 'qrc:/Qcm/Material/Example/Color.qml', {});
                    }
                }
            }
            MD.TabButton {
                action: Action {
                    text: 'shape'
                    onTriggered: {
                        bar_test.currentIndex = 2;
                        view_container.replace(view_container.currentItem, 'qrc:/Qcm/Material/Example/Shape.qml', {});
                    }
                }
            }
            MD.TabButton {
                action: Action {
                    text: 'elevation'
                    onTriggered: {
                        bar_test.currentIndex = 3;
                        view_container.replace(view_container.currentItem, 'qrc:/Qcm/Material/Example/Elevation.qml', {});
                    }
                }
            }
            MD.TabButton {
                action: Action {
                    text: 'typography'
                    onTriggered: {
                        bar_test.currentIndex = 4;
                        view_container.replace(view_container.currentItem, 'qrc:/Qcm/Material/Example/Typography.qml', {});
                    }
                }
            }
        }

        MD.Pane {
            Layout.fillHeight: true
            Layout.fillWidth: true
            padding: 0

            MD.StackView {
                id: view_container
                anchors.fill: parent
                initialItem: Item {}
            }
        }
    }
}
