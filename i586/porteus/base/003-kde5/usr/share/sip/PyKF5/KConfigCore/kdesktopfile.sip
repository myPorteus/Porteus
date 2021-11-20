// Discarded CLASS_DECL on line 12 'KConfigGroup' (by default forward declaration handling)
// Discarded CLASS_DECL on line 13 'KDesktopFilePrivate' (by default forward declaration handling)
class KDesktopFile: KConfig
{
%TypeHeaderCode
#include <kdesktopfile.h>
%End
public:
    KDesktopFile(QStandardPaths::StandardLocation resourceType, const QString & fileName);
    KDesktopFile(const QString & fileName);
    virtual ~KDesktopFile();
    static bool isDesktopFile(const QString & path);
    static bool isAuthorizedDesktopFile(const QString & path);
    static QString locateLocal(const QString & path);
    KConfigGroup desktopGroup() const;
    QString readType() const;
    QString readIcon() const;
    QString readName() const;
    QString readComment() const;
    QString readGenericName() const;
    QString readPath() const;
    QString readDevice() const;
    QString readUrl() const;
    QStringList readActions() const;
    QStringList readMimeTypes() const;
    KConfigGroup actionGroup(const QString & group);
    // Discarded CXX_METHOD on line 168 'actionGroup' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
    bool hasActionGroup(const QString & group) const;
    bool hasLinkType() const;
    bool hasApplicationType() const;
    bool hasDeviceType() const;
    bool tryExec() const;
    QString readDocPath() const;
    QStringList sortOrder() const;
    bool noDisplay() const;
    KDesktopFile * copyTo(const QString & file) const;
    QString fileName() const;
    QStandardPaths::StandardLocation resource() const;
protected:
private:
    KDesktopFile(const KDesktopFile & __0);
};
