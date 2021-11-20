// Discarded CLASS_DECL on line 29 'QFont' (by default forward declaration handling)
// Discarded CLASS_DECL on line 31 'KFontChooserDialogPrivate' (by default forward declaration handling)
class KFontChooserDialog: QDialog
{
%TypeHeaderCode
#include <kfontchooserdialog.h>
%End
    // Discarded VAR_DECL on line 91 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 91 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 91 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 91 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 91 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 91 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 100 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KFontChooserDialog(const QFlags<KFontChooser::DisplayFlag> & flags = KFontChooser::NoDisplayFlags, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KFontChooserDialog();
    void setFont(const QFont & font, bool onlyFixed = false);
    QFont font() const;
    static int // Modified PARM_DECL on line 127 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    getFont(QFont & theFont, const QFlags<KFontChooser::DisplayFlag> & flags = KFontChooser::NoDisplayFlags, QWidget*  parent /Transfer/ = nullptr);
    static int // Modified PARM_DECL on line 158 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    getFontDiff(QFont & theFont, QFlags<KFontChooser::FontDiff> & diffFlags, const QFlags<KFontChooser::DisplayFlag> & flags = KFontChooser::NoDisplayFlags, QWidget*  parent /Transfer/ = nullptr);
Q_SIGNALS:
    void fontSelected(const QFont & font);
private:
    KFontChooserDialog(const KFontChooserDialog & __0);
};
