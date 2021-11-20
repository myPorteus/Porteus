// Discarded CLASS_DECL on line 18 'KConcatenateRowsProxyModelPrivate' (by default forward declaration handling)
class KConcatenateRowsProxyModel: QAbstractItemModel
{
%TypeHeaderCode
#include <kconcatenaterowsproxymodel.h>
%End
    // Discarded VAR_DECL on line 55 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 55 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 55 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 55 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 55 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 55 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 63 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KConcatenateRowsProxyModel(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KConcatenateRowsProxyModel();
    void addSourceModel(QAbstractItemModel*  sourceModel);
    void removeSourceModel(QAbstractItemModel*  sourceModel);
    QList<QAbstractItemModel *> sources() const;
    QModelIndex mapFromSource(const QModelIndex & sourceIndex) const;
    QModelIndex mapToSource(const QModelIndex & proxyIndex) const;
    virtual QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    virtual bool setData(const QModelIndex & index, const QVariant & value, int role = Qt::DisplayRole);
    virtual QMap<int, QVariant> itemData(const QModelIndex & proxyIndex) const;
    virtual Qt::ItemFlags flags(const QModelIndex & index) const;
    virtual QModelIndex index(int row, int column, const QModelIndex & parent = QModelIndex()) const;
    virtual QModelIndex parent(const QModelIndex & index) const;
    virtual int rowCount(const QModelIndex & parent = QModelIndex()) const;
    virtual QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    virtual int columnCount(const QModelIndex & parent = QModelIndex()) const;
    virtual QHash<int, QByteArray> roleNames() const;
private:
private:
    private:
        KConcatenateRowsProxyModel(const KConcatenateRowsProxyModel &); // Generated
};
