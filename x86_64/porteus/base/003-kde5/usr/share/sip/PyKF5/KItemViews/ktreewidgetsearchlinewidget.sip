// Discarded CLASS_DECL on line 17 'QModelIndex' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QTreeWidget' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'KTreeWidgetSearchLine' (by default forward declaration handling)
class KTreeWidgetSearchLineWidget: QWidget
{
%TypeHeaderCode
#include <ktreewidgetsearchlinewidget.h>
%End
    // Discarded VAR_DECL on line 29 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 29 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 29 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 29 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 29 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 29 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 36 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KTreeWidgetSearchLineWidget(QWidget*  parent /TransferThis/ = nullptr, QTreeWidget*  treeWidget = nullptr);
    virtual ~KTreeWidgetSearchLineWidget();
    KTreeWidgetSearchLine * searchLine() const;
protected Q_SLOTS:
    virtual void createWidgets();
protected:
    virtual KTreeWidgetSearchLine * createSearchLine(QTreeWidget*  treeWidget) const;
private:
    // Discarded CLASS_DECL on line 68 'KTreeWidgetSearchLineWidgetPrivate' (by default forward declaration handling)
    private:
        KTreeWidgetSearchLineWidget(const KTreeWidgetSearchLineWidget &); // Generated
};
