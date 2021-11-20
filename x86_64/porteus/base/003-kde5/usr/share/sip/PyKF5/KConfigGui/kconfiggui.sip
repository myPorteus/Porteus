// Discarded CLASS_DECL on line 15 'KConfig' (by default forward declaration handling)
namespace KConfigGui
{
%TypeHeaderCode
#include <kconfiggui.h>
%End
    KConfig * sessionConfig();
    void setSessionConfig(const QString & id, const QString & key);
    bool hasSessionConfig();
    QString sessionConfigName();
};
