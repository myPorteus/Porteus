// Discarded CLASS_DECL on line 20 'KAutoSaveFilePrivate' (by default forward declaration handling)
class KAutoSaveFile: QFile
{
%TypeHeaderCode
#include <kautosavefile.h>
%End
    // Discarded VAR_DECL on line 122 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 122 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 122 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 122 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 122 'tr' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
    // Discarded CXX_METHOD on line 122 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[9],function_discard)
public:
    // Modified PARM_DECL on line 133 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KAutoSaveFile(const QUrl & filename, QObject*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 142 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KAutoSaveFile(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KAutoSaveFile();
    QUrl managedFile() const;
    void setManagedFile(const QUrl & filename);
    virtual void releaseLock();
    virtual bool open(QFlags<QIODevice::OpenModeFlag> openmode);
    static QList<KAutoSaveFile *> staleFiles(const QUrl & url, const QString & applicationName = QString());
    static QList<KAutoSaveFile *> allStaleFiles(const QString & applicationName = QString());
private:
    KAutoSaveFile(const KAutoSaveFile & __0);
};
