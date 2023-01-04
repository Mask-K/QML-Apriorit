#pragma once
#include "qurl.h"
#include <QObject>
#include <QDir>
#include <QUrl>
#include <QStringList>

class ImageParser : public QObject{
    Q_OBJECT
    //Q_PROPERTY(QStringList images READ images NOTIFY onView)
    Q_PROPERTY(QStringList images MEMBER images NOTIFY onView)

public:
    ImageParser(){
        connect(this, &ImageParser::onParseImages, this, &ImageParser::parseImages);
        connect(this, &ImageParser::onView, this, &ImageParser::view);
    }



public slots:
    void parseImages(const QUrl& path){
        QDir dir(path.toLocalFile());

        images = dir.entryList(QStringList() << "*.jpg" << "*.JPG" << "*.png" << "*.PNG" << "*.bmp" << "*.BMP"
                               << "*.gif" << "*.GIF" << "*.jpeg" << "*.JPEG" << "*.svg" << "*.SVG", QDir::Files);
        for(QString& img : images) {
            img.prepend(path.toString() + "/");
        }
        emit onView();
    }
    void view(){}

signals:
    void onParseImages(const QUrl& path);
    void onView();

private:
    QStringList images;
};
