// Discarded CLASS_DECL on line 15 'KPixmapSequence' (by default forward declaration handling)
class KPixmapSequenceWidget: QWidget
{
%TypeHeaderCode
#include <kpixmapsequencewidget.h>
%End
    // Discarded VAR_DECL on line 33 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 33 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 33 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 33 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 33 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 33 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 40 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPixmapSequenceWidget(QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 41 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPixmapSequenceWidget(const KPixmapSequence & seq, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KPixmapSequenceWidget();
    KPixmapSequence sequence() const;
    int interval() const;
    virtual QSize sizeHint() const;
public Q_SLOTS:
    void setSequence(const KPixmapSequence & seq);
    void setInterval(int msecs);
private:
    // Discarded CLASS_DECL on line 80 'KPixmapSequenceWidgetPrivate' (by default forward declaration handling)
    private:
        KPixmapSequenceWidget(const KPixmapSequenceWidget &); // Generated
};
