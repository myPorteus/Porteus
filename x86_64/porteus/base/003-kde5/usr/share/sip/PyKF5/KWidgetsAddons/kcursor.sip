// Discarded CLASS_DECL on line 14 'QEvent' (by default forward declaration handling)
// Discarded CLASS_DECL on line 15 'QObject' (by default forward declaration handling)
// Discarded CLASS_DECL on line 16 'QWidget' (by default forward declaration handling)
class KCursor
{
%TypeHeaderCode
#include <kcursor.h>
%End
public:
    static void setAutoHideCursor(QWidget*  w, bool enable, bool customEventFilter = false);
    static void setHideCursorDelay(int ms);
    static int hideCursorDelay();
    static void autoHideEventFilter(QObject*  __0, QEvent*  __1);
private:
    KCursor();
};
