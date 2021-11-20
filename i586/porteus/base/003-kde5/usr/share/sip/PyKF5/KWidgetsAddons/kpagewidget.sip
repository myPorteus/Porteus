// Discarded CLASS_DECL on line 15 'KPageWidgetPrivate' (by default forward declaration handling)
class KPageWidget: KPageView
{
%TypeHeaderCode
#include <kpagewidget.h>
%End
    // Discarded VAR_DECL on line 26 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 26 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 26 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 26 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 26 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 26 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 35 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPageWidget(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KPageWidget();
    KPageWidgetItem * addPage(QWidget*  widget, const QString & name);
    void addPage(KPageWidgetItem*  item);
    KPageWidgetItem * insertPage(KPageWidgetItem*  before, QWidget*  widget, const QString & name);
    void insertPage(KPageWidgetItem*  before, KPageWidgetItem*  item);
    KPageWidgetItem * // Modified PARM_DECL on line 90 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    addSubPage(KPageWidgetItem*  parent /TransferThis/, QWidget*  widget, const QString & name);
    void // Modified PARM_DECL on line 99 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    addSubPage(KPageWidgetItem*  parent /TransferThis/, KPageWidgetItem*  item);
    void removePage(KPageWidgetItem*  item);
    void setCurrentPage(KPageWidgetItem*  item);
    KPageWidgetItem * currentPage() const;
Q_SIGNALS:
    void currentPageChanged(KPageWidgetItem*  current, KPageWidgetItem*  before);
    void pageToggled(KPageWidgetItem*  page, bool checked);
    void pageRemoved(KPageWidgetItem*  page);
protected:
    // Discarded CONSTRUCTOR on line 140 'KPageWidget' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
    private:
        KPageWidget(const KPageWidget &); // Generated
};
