// Discarded CLASS_DECL on line 13 'QColor' (by default forward declaration handling)
// Discarded CLASS_DECL on line 14 'QDrag' (by default forward declaration handling)
// Discarded CLASS_DECL on line 15 'QMimeData' (by default forward declaration handling)
// Discarded CLASS_DECL on line 16 'QObject' (by default forward declaration handling)
namespace KColorMimeData
{
%TypeHeaderCode
#include <kcolormimedata.h>
%End
    void populateMimeData(QMimeData*  mimeData, const QColor & color);
    bool canDecode(const QMimeData*  mimeData);
    QColor fromMimeData(const QMimeData*  mimeData);
    QDrag * createDrag(const QColor & color, QObject*  dragsource);
};
