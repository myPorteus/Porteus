// Discarded CLASS_DECL on line 17 'QLabel' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QPushButton' (by default forward declaration handling)
class KFontRequester: QWidget
{
%TypeHeaderCode
#include <kfontrequester.h>
%End
    // Discarded VAR_DECL on line 35 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 35 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 35 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 35 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 35 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 35 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 49 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KFontRequester(QWidget*  parent /TransferThis/ = nullptr, bool onlyFixed = false);
    virtual ~KFontRequester();
    QFont font() const;
    bool isFixedOnly() const;
    QString sampleText() const;
    QString title() const;
    QLabel * label() const;
    QPushButton * button() const;
    virtual void setFont(const QFont & font, bool onlyFixed = false);
    virtual void setSampleText(const QString & text);
    virtual void setTitle(const QString & title);
Q_SIGNALS:
    void fontSelected(const QFont & font);
private:
    // Discarded CLASS_DECL on line 121 'KFontRequesterPrivate' (by default forward declaration handling)
    KFontRequester(const KFontRequester & __0);
};
