// Discarded CLASS_DECL on line 15 'QUrl' (by default forward declaration handling)
// Discarded CLASS_DECL on line 16 'QString' (by default forward declaration handling)
namespace KAuthorized
{
%TypeHeaderCode
#include <kauthorized.h>
%End
    bool authorize(const QString & action);
    bool authorizeAction(const QString & action);
    bool authorizeKAction(const QString & action);
    bool authorizeControlModule(const QString & menuId);
    QStringList authorizeControlModules(const QStringList & menuIds);
};
