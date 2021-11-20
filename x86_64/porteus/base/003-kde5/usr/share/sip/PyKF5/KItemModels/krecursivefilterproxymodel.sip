// Discarded CLASS_DECL on line 17 'KRecursiveFilterProxyModelPrivate' (by default forward declaration handling)
class KRecursiveFilterProxyModel: QSortFilterProxyModel
{
%TypeHeaderCode
#include <krecursivefilterproxymodel.h>
%End
    // Discarded VAR_DECL on line 84 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 84 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 84 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 84 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 84 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 84 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 90 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KRecursiveFilterProxyModel(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KRecursiveFilterProxyModel();
    virtual void setSourceModel(QAbstractItemModel*  model);
    virtual QModelIndexList match(const QModelIndex & start, int role, const QVariant & value, int hits = 1, QFlags<Qt::MatchFlag> flags = Qt::MatchFlags(Qt::MatchStartsWith|Qt::MatchWrap)) const;
protected:
    virtual bool acceptRow(int sourceRow, const QModelIndex & sourceParent) const;
    virtual bool filterAcceptsRow(int sourceRow, const QModelIndex & sourceParent) const;
    // Discarded FIELD_DECL on line 118 'd_ptr' (by Qt5Ruleset.py:VariableRuleDb[1],variable_discard)
private:
    private:
        KRecursiveFilterProxyModel(const KRecursiveFilterProxyModel &); // Generated
};
