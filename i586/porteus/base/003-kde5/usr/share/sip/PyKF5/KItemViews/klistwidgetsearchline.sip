// Discarded CLASS_DECL on line 17 'QListWidget' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QListWidgetItem' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QModelIndex' (by default forward declaration handling)
class KListWidgetSearchLine: QLineEdit
{
%TypeHeaderCode
#include <klistwidgetsearchline.h>
%End
    // Discarded VAR_DECL on line 32 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 32 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 32 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 32 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 32 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 32 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 45 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KListWidgetSearchLine(QWidget*  parent /TransferThis/ = nullptr, QListWidget*  listWidget = nullptr);
    virtual ~KListWidgetSearchLine();
    Qt::CaseSensitivity caseSensitive() const;
    QListWidget * listWidget() const;
    QString clickMessage() const;
    void setClickMessage(const QString & msg);
public Q_SLOTS:
    virtual void updateSearch(const QString & s = QString());
    void setCaseSensitivity(Qt::CaseSensitivity cs);
    void setListWidget(QListWidget*  lv);
    void clear();
protected:
    virtual bool itemMatches(const QListWidgetItem*  item, const QString & s) const;
    virtual bool event(QEvent*  event);
private:
    // Discarded CLASS_DECL on line 133 'KListWidgetSearchLinePrivate' (by default forward declaration handling)
    private:
        KListWidgetSearchLine(const KListWidgetSearchLine &); // Generated
};
