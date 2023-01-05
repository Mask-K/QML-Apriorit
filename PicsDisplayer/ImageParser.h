#pragma once
#include "qurl.h"
#include <QObject>
#include <QDir>
#include <QUrl>
#include <QStringList>

class ImageParser : public QObject{
    Q_OBJECT

    Q_PROPERTY(QStringList images MEMBER images NOTIFY view)

public:
    ImageParser();



public slots:
    void parseImages(const QUrl& path);
    void onView();;

signals:
    void onParseImages(const QUrl& path);
    void view();

private:
    QStringList images;
};
