// Discarded CLASS_DECL on line 15 'QWidget' (by default forward declaration handling)
// Discarded CLASS_DECL on line 16 'QString' (by default forward declaration handling)
class KAcceleratorManager
{
%TypeHeaderCode
#include <kacceleratormanager.h>
%End
public:
    static void manage(QWidget*  widget, bool programmers_mode = false);
    static void last_manage(QString & added, QString & changed, QString & removed);
    static void setNoAccel(QWidget*  widget);
    static void addStandardActionNames(const QStringList & names);
};
