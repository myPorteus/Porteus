// Discarded CLASS_DECL on line 17 'QAbstractItemView' (by default forward declaration handling)
class KExtendableItemDelegate: QStyledItemDelegate
{
%TypeHeaderCode
#include <kextendableitemdelegate.h>
%End
    // Discarded VAR_DECL on line 42 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 42 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 42 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 42 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 42 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 42 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    enum auxDataRoles {
        ShowExtensionIndicatorRole
    };
    // Modified PARM_DECL on line 54 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KExtendableItemDelegate(QAbstractItemView*  parent /TransferThis/);
    virtual ~KExtendableItemDelegate();
    virtual QSize sizeHint(const QStyleOptionViewItem & option, const QModelIndex & index) const;
    virtual void paint(QPainter*  painter, const QStyleOptionViewItem & option, const QModelIndex & index) const;
    void extendItem(QWidget*  extender, const QModelIndex & index);
    void contractItem(const QModelIndex & index);
    void contractAll();
    bool isExtended(const QModelIndex & index) const;
    virtual void updateExtenderGeometry(QWidget*  extender, const QStyleOptionViewItem & option, const QModelIndex & index) const;
Q_SIGNALS:
    void extenderCreated(QWidget*  extender, const QModelIndex & index);
    void extenderDestroyed(QWidget*  extender, const QModelIndex & index);
protected:
    QRect extenderRect(QWidget*  extender, const QStyleOptionViewItem & option, const QModelIndex & index) const;
    void setExtendPixmap(const QPixmap & pixmap);
    void setContractPixmap(const QPixmap & pixmap);
    QPixmap extendPixmap();
    QPixmap contractPixmap();
private:
    // Discarded CLASS_DECL on line 139 'KExtendableItemDelegatePrivate' (by default forward declaration handling)
    private:
        KExtendableItemDelegate(const KExtendableItemDelegate &); // Generated
};
