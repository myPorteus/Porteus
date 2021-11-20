class KColorCombo: QComboBox
{
%TypeHeaderCode
#include <kcolorcombo.h>
%End
    // Discarded VAR_DECL on line 36 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 36 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 36 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 44 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KColorCombo(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KColorCombo();
    void setColor(const QColor & col);
    QColor color() const;
    bool isCustomColor() const;
    void setColors(const QList<QColor> & colors);
    QList<QColor> colors() const;
    void showEmptyList();
Q_SIGNALS:
    void activated(const QColor & col);
    void highlighted(const QColor & col);
protected:
    virtual void paintEvent(QPaintEvent*  event);
private:
    // Discarded CLASS_DECL on line 97 'KColorComboPrivate' (by default forward declaration handling)
    KColorCombo(const KColorCombo & __0);
};
