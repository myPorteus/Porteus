namespace KIconUtils
{
%TypeHeaderCode
#include <kiconutils.h>
%End
    QIcon addOverlay(const QIcon & icon, const QIcon & overlay, Qt::Corner position);
    QIcon addOverlays(const QIcon & icon, const QHash<Qt::Corner, QIcon> & overlays);
    QIcon addOverlays(const QString & iconName, const QStringList & overlays);
};
