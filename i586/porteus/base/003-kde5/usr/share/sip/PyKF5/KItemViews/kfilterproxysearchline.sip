// Discarded CLASS_DECL on line 17 'KFilterProxySearchLinePrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QLineEdit' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'QSortFilterProxyModel' (by default forward declaration handling)
class KFilterProxySearchLine: QWidget
{
%TypeHeaderCode
#include <kfilterproxysearchline.h>
%End
    // Discarded VAR_DECL on line 39 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 39 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 39 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 39 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 39 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 39 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 46 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KFilterProxySearchLine(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KFilterProxySearchLine();
    void setProxy(QSortFilterProxyModel*  proxy);
    void setText(const QString & text);
    QLineEdit * lineEdit() const;
private:
    KFilterProxySearchLine(const KFilterProxySearchLine & __0);
};
