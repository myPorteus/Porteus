class KCommandBar: QMenu
{
%TypeHeaderCode
#include <kcommandbar.h>
%End
    // Discarded VAR_DECL on line 49 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 49 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 49 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 49 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 49 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 49 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    struct ActionGroup
    {
%TypeHeaderCode
#include <kcommandbar.h>
%End
        QString name;
        QList<QAction *> actions;
    };
    // Modified PARM_DECL on line 68 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCommandBar(QWidget*  parent /TransferThis/);
    virtual ~KCommandBar();
    void setActions(const QVector<KCommandBar::ActionGroup> & actions);
protected:
    virtual bool eventFilter(QObject*  obj, QEvent*  event);
private:
    // Discarded CLASS_DECL on line 82 'KCommandBarPrivate' (by default forward declaration handling)
    private:
        KCommandBar(const KCommandBar &); // Generated
};
