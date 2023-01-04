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
            break;
        case 1:
            list.visible = false;
            break;
        case 2:
            list.visible = false;
            break

        }
    }



    Connections{
        target: myModel
        function view(){
            console.log("xuietaaaaaaaaaaaaaaaa");
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
                //anchors.top: parent.top
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


        ListModel{
            id: lmodel
//            ListElement{
//                path: "file:///E:/imgs/Cat03.jpg"
//            }

//            ListElement{
//                path: "file:///E:/imgs/ScreenShot_1.png"
//            }

//            ListElement{
//                path: "file:///E:/imgs/svg.svg"
//            }

//            ListElement{
//                path: "file:///E:/imgs/tinypng-magento-image_1.jpg"
//            }
//            ListElement{
//                path: "file:///E:/imgs/ded.jpeg"
//            }
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





    }

}





