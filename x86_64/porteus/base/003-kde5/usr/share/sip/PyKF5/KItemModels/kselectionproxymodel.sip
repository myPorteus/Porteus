// Discarded CLASS_DECL on line 17 'KSelectionProxyModelPrivate' (by default forward declaration handling)
class KSelectionProxyModel: QAbstractProxyModel
{
%TypeHeaderCode
#include <kselectionproxymodel.h>
%End
    // Discarded VAR_DECL on line 78 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 78 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 78 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 78 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 78 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 78 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 88 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KSelectionProxyModel(QItemSelectionModel*  selectionModel, QObject*  parent /TransferThis/ = nullptr);
    KSelectionProxyModel();
    virtual ~KSelectionProxyModel();
    virtual void setSourceModel(QAbstractItemModel*  sourceModel);
    QItemSelectionModel * selectionModel() const;
    void setSelectionModel(QItemSelectionModel*  selectionModel);
    enum FilterBehavior {
        SubTrees,
        SubTreeRoots,
        SubTreesWithoutRoots,
        ExactSelection,
        ChildrenOfExactSelection,
        InvalidBehavior
    };
    void setFilterBehavior(KSelectionProxyModel::FilterBehavior behavior);
    KSelectionProxyModel::FilterBehavior filterBehavior() const;
    virtual QModelIndex mapFromSource(const QModelIndex & sourceIndex) const;
    virtual QModelIndex mapToSource(const QModelIndex & proxyIndex) const;
    virtual QItemSelection mapSelectionFromSource(const QItemSelection & selection) const;
    virtual QItemSelection mapSelectionToSource(const QItemSelection & selection) const;
    virtual Qt::ItemFlags flags(const QModelIndex & index) const;
    virtual QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    virtual int rowCount(const QModelIndex & parent = QModelIndex()) const;
    virtual QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    virtual QMimeData * mimeData(const QList<QModelIndex> & indexes) const;
    virtual QStringList mimeTypes() const;
    virtual Qt::DropActions supportedDropActions() const;
    virtual bool dropMimeData(const QMimeData*  data, Qt::DropAction action, int row, int column, const QModelIndex & parent);
    virtual bool hasChildren(const QModelIndex & parent = QModelIndex()) const;
    virtual QModelIndex index(int __0, int __1, const QModelIndex & __2 = QModelIndex()) const;
    virtual QModelIndex parent(const QModelIndex & __0) const;
    virtual int columnCount(const QModelIndex & __0 = QModelIndex()) const;
    virtual QModelIndexList match(const QModelIndex & start, int role, const QVariant & value, int hits = 1, QFlags<Qt::MatchFlag> flags = Qt::MatchFlags(Qt::MatchStartsWith|Qt::MatchWrap)) const;
Q_SIGNALS:
    // Discarded CXX_METHOD on line 273 'rootIndexAboutToBeRemoved' (by Qt5Ruleset.py:FunctionRuleDb[2],function_discard)
    // Discarded CXX_METHOD on line 281 'rootIndexAdded' (by Qt5Ruleset.py:FunctionRuleDb[2],function_discard)
    // Discarded CXX_METHOD on line 288 'rootSelectionAboutToBeRemoved' (by Qt5Ruleset.py:FunctionRuleDb[2],function_discard)
    // Discarded CXX_METHOD on line 295 'rootSelectionAdded' (by Qt5Ruleset.py:FunctionRuleDb[2],function_discard)
    // Discarded CXX_METHOD on line 297 'selectionModelChanged' (by Qt5Ruleset.py:FunctionRuleDb[2],function_discard)
    // Discarded CXX_METHOD on line 298 'filterBehaviorChanged' (by Qt5Ruleset.py:FunctionRuleDb[2],function_discard)
protected:
    QList<QPersistentModelIndex> sourceRootIndexes() const;
private:
    private:
        KSelectionProxyModel(const KSelectionProxyModel &); // Generated
};
