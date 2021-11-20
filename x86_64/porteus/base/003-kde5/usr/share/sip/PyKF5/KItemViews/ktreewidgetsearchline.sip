// Discarded CLASS_DECL on line 17 'QModelIndex' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QTreeWidget' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QTreeWidgetItem' (by default forward declaration handling)
class KTreeWidgetSearchLine: QLineEdit
{
%TypeHeaderCode
#include <ktreewidgetsearchline.h>
%End
    // Discarded VAR_DECL on line 33 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 33 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 33 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 33 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 33 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 33 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 49 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KTreeWidgetSearchLine(QWidget*  parent /TransferThis/ = nullptr, QTreeWidget*  treeWidget = nullptr);
    // Modified PARM_DECL on line 58 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KTreeWidgetSearchLine(QWidget*  parent /TransferThis/, const QList<QTreeWidget *> & treeWidgets);
    virtual ~KTreeWidgetSearchLine();
    Qt::CaseSensitivity caseSensitivity() const;
    QList<int> searchColumns() const;
    bool keepParentsVisible() const;
    QTreeWidget * treeWidget() const;
    QList<QTreeWidget *> treeWidgets() const;
    QString clickMessage() const;
    void setClickMessage(const QString & msg);
Q_SIGNALS:
    void hiddenChanged(QTreeWidgetItem*  __0, bool __1);
    void searchUpdated(const QString & searchString);
public Q_SLOTS:
    void addTreeWidget(QTreeWidget*  treeWidget);
    void removeTreeWidget(QTreeWidget*  treeWidget);
    virtual void updateSearch(const QString & pattern = QString());
    void setCaseSensitivity(Qt::CaseSensitivity caseSensitivity);
    void setKeepParentsVisible(bool value);
    void setSearchColumns(const QList<int> & columns);
    void setTreeWidget(QTreeWidget*  treeWidget);
    void setTreeWidgets(const QList<QTreeWidget *> & treeWidgets);
protected:
    virtual bool itemMatches(const QTreeWidgetItem*  item, const QString & pattern) const;
    virtual void contextMenuEvent(QContextMenuEvent*  __0);
    virtual void updateSearch(QTreeWidget*  treeWidget);
    virtual void connectTreeWidget(QTreeWidget*  __0);
    virtual void disconnectTreeWidget(QTreeWidget*  __0);
    virtual bool canChooseColumnsCheck();
    virtual bool event(QEvent*  event);
private:
    // Discarded CLASS_DECL on line 274 'KTreeWidgetSearchLinePrivate' (by default forward declaration handling)
    private:
        KTreeWidgetSearchLine(const KTreeWidgetSearchLine &); // Generated
};
