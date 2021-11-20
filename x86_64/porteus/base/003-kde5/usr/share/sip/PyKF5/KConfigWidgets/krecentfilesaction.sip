// Discarded CLASS_DECL on line 23 'KConfigGroup' (by default forward declaration handling)
// Discarded CLASS_DECL on line 24 'KRecentFilesActionPrivate' (by default forward declaration handling)
class KRecentFilesAction: KSelectAction
{
%TypeHeaderCode
#include <krecentfilesaction.h>
%End
    // Discarded VAR_DECL on line 40 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 40 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 40 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 40 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 40 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 40 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 50 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KRecentFilesAction(QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 64 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KRecentFilesAction(const QString & text, QObject*  parent /TransferThis/);
    // Modified PARM_DECL on line 77 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KRecentFilesAction(const QIcon & icon, const QString & text, QObject*  parent /TransferThis/);
    virtual ~KRecentFilesAction();
    void addAction(QAction*  action, const QUrl & url, const QString & name);
    virtual QAction * removeAction(QAction*  action);
public Q_SLOTS:
    virtual void clear();
public:
    int maxItems() const;
    void setMaxItems(int maxItems);
    void loadEntries(const KConfigGroup & config);
    void saveEntries(const KConfigGroup & config);
    void addUrl(const QUrl & url, const QString & name = QString());
    void removeUrl(const QUrl & url);
    QList<QUrl> urls() const;
Q_SIGNALS:
    void urlSelected(const QUrl & url);
    void recentListCleared();
private:
private:
    private:
        KRecentFilesAction(const KRecentFilesAction &); // Generated
};
