// Discarded CLASS_DECL on line 19 'KPageDialogPrivate' (by default forward declaration handling)
class KPageDialog: QDialog
{
%TypeHeaderCode
#include <kpagedialog.h>
%End
    // Discarded VAR_DECL on line 79 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 79 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 79 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 79 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 79 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 79 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum FaceType {
        Auto,
        Plain,
        List,
        Tree,
        Tabbed
    };
public:
    // Modified PARM_DECL on line 119 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPageDialog(QWidget*  parent /TransferThis/ = nullptr, QFlags<Qt::WindowType> flags = Qt::WindowFlags());
    virtual ~KPageDialog();
    void setFaceType(KPageDialog::FaceType faceType);
    KPageWidgetItem * addPage(QWidget*  widget, const QString & name);
    void addPage(KPageWidgetItem*  item);
    KPageWidgetItem * insertPage(KPageWidgetItem*  before, QWidget*  widget, const QString & name);
    void insertPage(KPageWidgetItem*  before, KPageWidgetItem*  item);
    KPageWidgetItem * // Modified PARM_DECL on line 179 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    addSubPage(KPageWidgetItem*  parent /TransferThis/, QWidget*  widget, const QString & name);
    void // Modified PARM_DECL on line 188 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    addSubPage(KPageWidgetItem*  parent /TransferThis/, KPageWidgetItem*  item);
    void removePage(KPageWidgetItem*  item);
    void setCurrentPage(KPageWidgetItem*  item);
    KPageWidgetItem * currentPage() const;
    void setStandardButtons(QFlags<QDialogButtonBox::StandardButton> buttons);
    QPushButton * button(QDialogButtonBox::StandardButton which) const;
    void addActionButton(QAbstractButton*  button);
Q_SIGNALS:
    void currentPageChanged(KPageWidgetItem*  current, KPageWidgetItem*  before);
    void pageRemoved(KPageWidgetItem*  page);
protected:
    // Modified PARM_DECL on line 246 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPageDialog(KPageWidget*  widget, QWidget*  parent /TransferThis/, QFlags<Qt::WindowType> flags = Qt::WindowFlags());
    // Discarded CONSTRUCTOR on line 247 'KPageDialog' (by rules_PyKF5.py:FunctionRuleDb[21],function_discard)
    KPageWidget * pageWidget();
    // Discarded CXX_METHOD on line 257 'pageWidget' (by rules_PyKF5.py:FunctionRuleDb[6],function_discard)
    void setPageWidget(KPageWidget*  widget);
    QDialogButtonBox * buttonBox();
    // Discarded CXX_METHOD on line 277 'buttonBox' (by rules_PyKF5.py:FunctionRuleDb[7],function_discard)
    void setButtonBox(QDialogButtonBox*  box);
protected:
    // Discarded FIELD_DECL on line 290 'd_ptr' (by Qt5Ruleset.py:VariableRuleDb[1],variable_discard)
    private:
        KPageDialog(const KPageDialog &); // Generated
};
