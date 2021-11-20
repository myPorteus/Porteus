// Discarded CLASS_DECL on line 17 'KCheckableProxyModelPrivate' (by default forward declaration handling)
class KCheckableProxyModel: QIdentityProxyModel
{
%TypeHeaderCode
#include <kcheckableproxymodel.h>
%End
    // Discarded VAR_DECL on line 58 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 58 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 58 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 58 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 58 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 58 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 60 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCheckableProxyModel(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KCheckableProxyModel();
    void setSelectionModel(QItemSelectionModel*  itemSelectionModel);
    QItemSelectionModel * selectionModel() const;
    virtual Qt::ItemFlags flags(const QModelIndex & index) const;
    virtual QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    virtual bool setData(const QModelIndex & index, const QVariant & value, int role = Qt::EditRole);
    virtual void setSourceModel(QAbstractItemModel*  sourceModel);
    virtual QHash<int, QByteArray> roleNames() const;
protected:
    virtual bool select(const QItemSelection & selection, QFlags<QItemSelectionModel::SelectionFlag> command);
private:
    private:
        KCheckableProxyModel(const KCheckableProxyModel &); // Generated
};
