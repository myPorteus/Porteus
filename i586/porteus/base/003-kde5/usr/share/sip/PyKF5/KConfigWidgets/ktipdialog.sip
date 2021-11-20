class KTipDatabase
{
%TypeHeaderCode
#include <ktipdialog.h>
%End
public:
    KTipDatabase(const QString & tipFile = QString());
    KTipDatabase(const QStringList & tipFiles);
    ~KTipDatabase();
    QString tip() const;
    void nextTip();
    void prevTip();
private:
    // Discarded CLASS_DECL on line 82 'KTipDatabasePrivate' (by default forward declaration handling)
    KTipDatabase(const KTipDatabase & __0);
};
class KTipDialog: QDialog
{
%TypeHeaderCode
#include <ktipdialog.h>
%End
    // Discarded VAR_DECL on line 101 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 101 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 101 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 101 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 101 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 101 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 112 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KTipDialog(KTipDatabase*  database, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KTipDialog();
    static void // Modified PARM_DECL on line 136 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    showTip(QWidget*  parent /Transfer/, const QString & tipFile = QString(), bool force = false);
    static void // Modified PARM_DECL on line 151 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    showMultiTip(QWidget*  parent /Transfer/, const QStringList & tipFiles, bool force = false);
    static void showTip(const QString & tipFile = QString(), bool force = false);
    static void setShowOnStart(bool show);
protected:
    virtual bool eventFilter(QObject*  __0, QEvent*  __1);
private:
    // Discarded CLASS_DECL on line 177 'KTipDialogPrivate' (by default forward declaration handling)
    KTipDialog(const KTipDialog & __0);
};
