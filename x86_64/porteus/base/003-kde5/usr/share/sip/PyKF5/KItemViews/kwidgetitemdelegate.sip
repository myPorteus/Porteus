// Discarded CLASS_DECL on line 20 'QObject' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'QPainter' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'QStyleOption' (by default forward declaration handling)
// Discarded CLASS_DECL on line 23 'QStyleOptionViewItem' (by default forward declaration handling)
// Discarded CLASS_DECL on line 24 'QAbstractItemView' (by default forward declaration handling)
// Discarded CLASS_DECL on line 25 'QItemSelection' (by default forward declaration handling)
// Discarded CLASS_DECL on line 27 'KWidgetItemDelegatePrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 28 'KWidgetItemDelegatePool' (by default forward declaration handling)
class KWidgetItemDelegate: QAbstractItemDelegate
{
%TypeHeaderCode
#include <kwidgetitemdelegate.h>
%End
    // Discarded VAR_DECL on line 41 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 41 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 41 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 41 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 41 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 41 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 50 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KWidgetItemDelegate(QAbstractItemView*  itemView, QObject*  parent /TransferThis/ = nullptr);
    virtual ~KWidgetItemDelegate();
    QAbstractItemView * itemView() const;
    QPersistentModelIndex focusedIndex() const;
    void resetModel();
protected:
    virtual QList<QWidget *> createItemWidgets(const QModelIndex & index) const = 0;
    virtual void updateItemWidgets(const QList<QWidget *> widgets, const QStyleOptionViewItem & option, const QPersistentModelIndex & index) const = 0;
    void paintWidgets(QPainter*  painter, const QStyleOptionViewItem & option, const QPersistentModelIndex & index) const;
    void setBlockedEventTypes(QWidget*  widget, QList<QEvent::Type> types) const;
    QList<QEvent::Type> blockedEventTypes(QWidget*  widget) const;
private:
    private:
        KWidgetItemDelegate(const KWidgetItemDelegate &); // Generated
};
