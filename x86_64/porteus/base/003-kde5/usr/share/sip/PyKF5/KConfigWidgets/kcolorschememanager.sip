// Discarded CLASS_DECL on line 16 'QAbstractItemModel' (by default forward declaration handling)
// Discarded CLASS_DECL on line 17 'QModelIndex' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QIcon' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'KActionMenu' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'KColorSchemeManagerPrivate' (by default forward declaration handling)
class KColorSchemeManager: QObject
{
%TypeHeaderCode
#include <kcolorschememanager.h>
%End
    // Discarded VAR_DECL on line 57 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 57 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 57 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 57 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 57 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 57 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 59 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KColorSchemeManager(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KColorSchemeManager();
    QAbstractItemModel * model() const;
    QModelIndex indexForScheme(const QString & name) const;
    KActionMenu * // Modified PARM_DECL on line 99 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    createSchemeSelectionMenu(const QIcon & icon, const QString & text, const QString & selectedSchemeName, QObject*  parent /TransferThis/);
    KActionMenu * // Modified PARM_DECL on line 105 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    createSchemeSelectionMenu(const QString & text, const QString & selectedSchemeName, QObject*  parent /TransferThis/);
    KActionMenu * // Modified PARM_DECL on line 111 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    createSchemeSelectionMenu(const QString & selectedSchemeName, QObject*  parent /TransferThis/);
    KActionMenu * // Modified PARM_DECL on line 119 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    createSchemeSelectionMenu(QObject*  parent /TransferThis/);
public Q_SLOTS:
    void activateScheme(const QModelIndex & index);
private:
    private:
        KColorSchemeManager(const KColorSchemeManager &); // Generated
};
