// Discarded CLASS_DECL on line 14 'QWindow' (by default forward declaration handling)
namespace KWindowConfig
{
%TypeHeaderCode
#include <kwindowconfig.h>
%End
    void saveWindowSize(const QWindow*  window, KConfigGroup & config, QFlags<KConfigBase::WriteConfigFlag> options = KConfigBase::Normal);
    void restoreWindowSize(QWindow*  window, const KConfigGroup & config);
    void saveWindowPosition(const QWindow*  window, KConfigGroup & config, QFlags<KConfigBase::WriteConfigFlag> options = KConfigBase::Normal);
    void restoreWindowPosition(QWindow*  window, const KConfigGroup & config);
};
