import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts




Column{
    property int event: -1
    function changeVisibility(){
        switch(event){
        case 0:
            list.visible = true;
            pathView.visible = false;
            lazy.visible = false;
            break;
        case 1:
            list.visible = false;
            pathView.visible = false;
            lazy.visible = true;
            break;
        case 2:
            list.visible = false;
            pathView.visible = true;
            lazy.visible = false
            break

        }
    }



    Connections{
        target: myModel
        function onView(){
            for(var i = 0; i < myModel.images.length; ++i){
                lmodel.append({path: myModel.images[i]});
            }
        }
    }




    Rectangle{
        id: props
        color: "lightsteelblue"
        height: 25; width: parent.width

        FolderDialog{

            id: openDirDialog
            title: "Dir explorer"

            onAccepted: {

                //button.text = selectedFolder;
                myModel.parseImages(selectedFolder);
                imageButton.visible = true;
                selectedMode.visible = true;

            }

        }
        RowLayout{
            spacing: 10
            Button {
                id: button
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                text: "Select path for images!"


                onClicked: {
                    openDirDialog.open();
                }
            }
            Button {
                id: imageButton
                text: "How to view images"
                onClicked: menu.open()
                visible: false

                Menu {
                    id: menu
                    y: imageButton.height


                    MenuItem {
                        text: "List"

                        onTriggered: {
                            selectedMode.text = "Viewing by " + text;
                            event = 0;
                            changeVisibility();
                        }
                    }
                    MenuItem {
                        text: "Table"
                        onTriggered: {
                            selectedMode.text = "Viewing by " + text;
                            event = 1;
                            changeVisibility();
                        }
                    }
                    MenuItem {
                        text: "PathView"
                        onTriggered: {
                            selectedMode.text = "Viewing by " + text;
                            event = 2;
                            changeVisibility();
                        }
                    }
                }
            }
            Label{
                visible: false
                id: selectedMode
                text:  "No mode was selected"
                color: "blue"
            }
        }


    }

    Rectangle {

        id: rectCanvas
        height: parent.height - props.height; width: parent.width
        color: "#ffaa80"

        Component{
            id: delegate
            Image{
                height: 200
                width: 200

                anchors.horizontalCenter: parent == null ? undefined : parent.horizontalCenter
                smooth: true
                source: path
                MouseArea{
                    anchors.fill: parent
                    property bool flag: false
                    acceptedButtons: Qt.AllButtons
                    onClicked:{
                        if(!flag){
                            parent.width = parent.width*3;
                            parent.height = parent.height*1.5;
                            flag = true
                        }
                        else{
                            parent.width = 200;
                            parent.height = 200;
                            flag = false
                        }

                    }
                }
            }
        }
        Component{
                id: delegate2
                Column {
                    id: wrapper
                    opacity: PathView.isCurrentItem ? 1 : 0.3
                    Image {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 100; height: 100
                        smooth: true
                        source: path
                        MouseArea{
                            anchors.fill: parent
                            property bool flag: false
                            acceptedButtons: Qt.AllButtons
                            onClicked:{

                                if(!flag){
                                    parent.width = parent.width*3;
                                    parent.height = parent.height*1.5;
                                    flag = true
                                }
                                else{
                                    parent.width = 100;
                                    parent.height = 100;
                                    flag = false
                                }


                            }
                        }
                    }

                }
            }


        ListModel{
            id: lmodel
        }
        ListView{
            visible: false
            model: lmodel
            id: list
            clip: true
            anchors.fill: parent
            delegate: delegate
            ScrollBar.vertical: ScrollBar{}
        }
        PathView {
                id: pathView
                visible: false
                anchors{
                    fill: parent
                    horizontalCenter: parent.horizontalCenter
                }
                Layout.alignment: Qt.AlignHCenter
                model: lmodel
                delegate: delegate2
                path: Path {
                    startX: parent.width/2; startY: parent.height/2
                    PathQuad { x: parent.width/2; y: parent.height/2 - 150; controlX: parent.width/2 + 200; controlY: parent.height/2 - 50 } // y - 150; x + 200, y - 50
                    PathQuad { x: parent.width/2; y: parent.height/2; controlX: parent.width/2 - 175; controlY: parent.height/2 - 50 } // nothing; x - 175, y - 50
                }
            }

        Column{
            id: lazy
            visible: false
            anchors.fill: parent
            Image {
                height: 300
                width: 300
                anchors.horizontalCenter: parent.horizontalCenter
                source: "tiredCat.jpg"

            }
            Label{
                text: "Haven't done this task =`("
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }


    }

}




