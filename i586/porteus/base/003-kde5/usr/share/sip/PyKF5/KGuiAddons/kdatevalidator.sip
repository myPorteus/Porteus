class KDateValidator: QValidator
{
%TypeHeaderCode
#include <kdatevalidator.h>
%End
    // Discarded VAR_DECL on line 24 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 24 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 24 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 24 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 24 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 24 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 26 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KDateValidator(QObject*  parent /TransferThis/ = nullptr);
    virtual QValidator::State validate(QString & text, int & e) const;
    virtual void fixup(QString & input) const;
    QValidator::State date(const QString & text, QDate & date) const;
private:
    // Discarded CLASS_DECL on line 34 'KDateValidatorPrivate' (by default forward declaration handling)
    private:
        KDateValidator(const KDateValidator &); // Generated
};
