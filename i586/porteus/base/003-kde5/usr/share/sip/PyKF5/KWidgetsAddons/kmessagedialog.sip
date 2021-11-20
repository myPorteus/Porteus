// Discarded CLASS_DECL on line 20 'QDialogButtonBox' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'KMessageDialogPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 23 'KGuiItem' (by default forward declaration handling)
class KMessageDialog: QDialog
{
%TypeHeaderCode
#include <kmessagedialog.h>
%End
    // Discarded VAR_DECL on line 104 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 104 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 104 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 104 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 104 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 104 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum Type {
        QuestionYesNo,
        QuestionYesNoCancel,
        WarningYesNo,
        WarningYesNoCancel,
        WarningContinueCancel,
        Information,
        Sorry,
        Error
    };
    // Modified PARM_DECL on line 125 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KMessageDialog(KMessageDialog::Type type, const QString & text, QWidget*  parent /TransferThis/ = nullptr);
    KMessageDialog(KMessageDialog::Type type, const QString & text, unsigned int parent_id);
    virtual ~KMessageDialog();
    void setCaption(const QString & caption);
    void setIcon(const QIcon & icon);
    void setListWidgetItems(const QStringList & strlist);
    void setDetails(const QString & details);
    void setDontAskAgainText(const QString & dontAskAgainText);
    void setDontAskAgainChecked(bool isChecked);
    bool isDontAskAgainChecked() const;
    void setOpenExternalLinks(bool isAllowed);
    void setButtons(const KGuiItem & buttonAccept = KStandardGuiItem::yes(), const KGuiItem & buttonNo = KStandardGuiItem::no(), const KGuiItem & buttonCancel = KStandardGuiItem::cancel());
private:
    private:
        KMessageDialog(const KMessageDialog &); // Generated
};
