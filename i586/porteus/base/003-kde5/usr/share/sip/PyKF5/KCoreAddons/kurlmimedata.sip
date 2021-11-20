// Discarded CLASS_DECL on line 16 'QMimeData' (by default forward declaration handling)
namespace KUrlMimeData
{
%TypeHeaderCode
#include <kurlmimedata.h>
%End
    typedef QMap<QString, QString> MetaDataMap;
    void setUrls(const QList<QUrl> & urls, const QList<QUrl> & mostLocalUrls, QMimeData*  mimeData);
    void setMetaData(const QMap<QString, QString> & metaData, QMimeData*  mimeData);
    QStringList mimeDataTypes();
    enum DecodeOptions {
        PreferLocalUrls,
        PreferKdeUrls
    };
    QList<QUrl> urlsFromMimeData(const QMimeData*  mimeData, KUrlMimeData::DecodeOptions decodeOptions = KUrlMimeData::PreferKdeUrls, QMap<QString, QString>*  metaData = nullptr);
};
