// Discarded CLASS_DECL on line 13 'QWidget' (by default forward declaration handling)
// Discarded CLASS_DECL on line 14 'QWindow' (by default forward declaration handling)
// Discarded CLASS_DECL on line 15 'KJob' (by default forward declaration handling)
namespace KJobWidgets
{
%TypeHeaderCode
#include <kjobwidgets.h>
%End
    void setWindow(KJob*  job, QWidget*  widget);
    QWidget * window(KJob*  job);
    void updateUserTimestamp(KJob*  job, unsigned long time);
    unsigned long userTimestamp(KJob*  job);
};
namespace KJobWindows
{
%TypeHeaderCode
#include <kjobwidgets.h>
%End
    void setWindow(KJob*  job, QWindow*  window);
    QWindow * window(KJob*  job);
};
