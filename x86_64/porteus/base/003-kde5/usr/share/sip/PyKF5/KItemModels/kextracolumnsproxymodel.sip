// Discarded CLASS_DECL on line 16 'KExtraColumnsProxyModelPrivate' (by default forward declaration handling)
class KExtraColumnsProxyModel: QIdentityProxyModel
{
%TypeHeaderCode
#include <kextracolumnsproxymodel.h>
%End
    // Discarded VAR_DECL on line 41 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 41 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 41 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 41 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 41 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 41 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 47 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KExtraColumnsProxyModel(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KExtraColumnsProxyModel();
    void appendColumn(const QString & header = QString());
    void removeExtraColumn(int idx);
    virtual QVariant extraColumnData(const QModelIndex & parent, int row, int extraColumn, int role = Qt::DisplayRole) const = 0;
    virtual bool setExtraColumnData(const QModelIndex & parent, int row, int extraColumn, const QVariant & data, int role = Qt::EditRole);
    void extraColumnDataChanged(const QModelIndex & parent, int row, int extraColumn, const QVector<int> & roles);
    int extraColumnForProxyColumn(int proxyColumn) const;
    int proxyColumnForExtraColumn(int extraColumn) const;
    virtual void setSourceModel(QAbstractItemModel*  model);
    virtual QModelIndex mapToSource(const QModelIndex & proxyIndex) const;
    virtual QItemSelection mapSelectionToSource(const QItemSelection & selection) const;
    virtual int columnCount(const QModelIndex & parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    virtual bool setData(const QModelIndex & index, const QVariant & value, int role = Qt::EditRole);
    virtual QModelIndex sibling(int row, int column, const QModelIndex & idx) const;
    virtual QModelIndex buddy(const QModelIndex & index) const;
    virtual Qt::ItemFlags flags(const QModelIndex & index) const;
    virtual bool hasChildren(const QModelIndex & index) const;
    virtual QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    virtual QModelIndex index(int row, int column, const QModelIndex & parent = QModelIndex()) const;
    virtual QModelIndex parent(const QModelIndex & child) const;
private:
    private:
        KExtraColumnsProxyModel(const KExtraColumnsProxyModel &); // Generated
};
