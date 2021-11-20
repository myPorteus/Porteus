class KMimeTypeChooser: QWidget
{
%TypeHeaderCode
#include <kmimetypechooser.h>
%End
    // Discarded VAR_DECL on line 32 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 32 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 32 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 32 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 32 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 32 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum Visuals {
        Comments,
        Patterns,
        EditButton
    };
    // Modified PARM_DECL on line 64 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KMimeTypeChooser(const QString & text = QString(), const QStringList & selectedMimeTypes = QStringList(), const QString & defaultGroup = QString(), const QStringList & groupsToShow = QStringList(), int visuals = Comments|Patterns|EditButton, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KMimeTypeChooser();
    QStringList mimeTypes() const;
    QStringList patterns() const;
private:
    // Discarded CLASS_DECL on line 77 'KMimeTypeChooserPrivate' (by default forward declaration handling)
    private:
        KMimeTypeChooser(const KMimeTypeChooser &); // Generated
};
class KMimeTypeChooserDialog: QDialog
{
%TypeHeaderCode
#include <kmimetypechooser.h>
%End
    // Discarded VAR_DECL on line 113 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 113 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 113 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 113 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 113 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 113 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 138 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KMimeTypeChooserDialog(const QString & title = QString(), const QString & text = QString(), const QStringList & selectedMimeTypes = QStringList(), const QString & defaultGroup = QString(), const QStringList & groupsToShow = QStringList(), int visuals = KMimeTypeChooser::Comments|KMimeTypeChooser::Patterns|KMimeTypeChooser::EditButton, QWidget*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 147 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KMimeTypeChooserDialog(const QString & title, const QString & text, const QStringList & selectedMimeTypes, const QString & defaultGroup, QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KMimeTypeChooserDialog();
    KMimeTypeChooser * chooser();
    virtual QSize sizeHint() const;
private:
    // Discarded CLASS_DECL on line 159 'KMimeTypeChooserDialogPrivate' (by default forward declaration handling)
    private:
        KMimeTypeChooserDialog(const KMimeTypeChooserDialog &); // Generated
};
