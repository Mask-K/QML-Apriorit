#include "ImageParser.h"



ImageParser::ImageParser(){
    connect(this, &ImageParser::onParseImages, this, &ImageParser::parseImages);
    connect(this, &ImageParser::view, this, &ImageParser::onView);
}

void ImageParser::parseImages(const QUrl &path){
    QDir dir(path.toLocalFile());

    images = dir.entryList(QStringList() << "*.jpg" << "*.JPG" << "*.png" << "*.PNG" << "*.bmp" << "*.BMP"
                           << "*.gif" << "*.GIF" << "*.jpeg" << "*.JPEG" << "*.svg" << "*.SVG", QDir::Files);
    for(QString& img : images) {
        img.prepend(path.toString() + "/");
    }
    emit view();
}

void ImageParser::onView(){}
