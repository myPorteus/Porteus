class KAnimatedButton: QToolButton
{
%TypeHeaderCode
#include <kanimatedbutton.h>
%End
    // Discarded VAR_DECL on line 30 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 30 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 30 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 30 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 30 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 30 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 39 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KAnimatedButton(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KAnimatedButton();
    QString animationPath() const;
    void setAnimationPath(const QString & path);
public Q_SLOTS:
    void start();
    void stop();
private:
    // Discarded CLASS_DECL on line 70 'KAnimatedButtonPrivate' (by default forward declaration handling)
    KAnimatedButton(const KAnimatedButton & __0);
};
