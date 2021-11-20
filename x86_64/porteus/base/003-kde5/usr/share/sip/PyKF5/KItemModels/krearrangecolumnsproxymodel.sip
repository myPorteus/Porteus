// Discarded CLASS_DECL on line 17 'KRearrangeColumnsProxyModelPrivate' (by default forward declaration handling)
class KRearrangeColumnsProxyModel: QIdentityProxyModel
{
%TypeHeaderCode
#include <krearrangecolumnsproxymodel.h>
%End
    // Discarded VAR_DECL on line 35 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 35 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 35 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 35 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 35 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 35 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 41 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KRearrangeColumnsProxyModel(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KRearrangeColumnsProxyModel();
    void setSourceColumns(const QVector<int> & columns);
    virtual int columnCount(const QModelIndex & parent = QModelIndex()) const;
    virtual int rowCount(const QModelIndex & parent = QModelIndex()) const;
    virtual QModelIndex index(int row, int column, const QModelIndex & parent = QModelIndex()) const;
    virtual QModelIndex parent(const QModelIndex & child) const;
    virtual QModelIndex mapFromSource(const QModelIndex & sourceIndex) const;
    virtual QModelIndex mapToSource(const QModelIndex & proxyIndex) const;
    virtual QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    virtual bool hasChildren(const QModelIndex & parent = QModelIndex()) const;
    virtual QModelIndex sibling(int row, int column, const QModelIndex & idx) const;
    int proxyColumnForSourceColumn(int sourceColumn) const;
    int sourceColumnForProxyColumn(int proxyColumn) const;
private:
    private:
        KRearrangeColumnsProxyModel(const KRearrangeColumnsProxyModel &); // Generated
};
