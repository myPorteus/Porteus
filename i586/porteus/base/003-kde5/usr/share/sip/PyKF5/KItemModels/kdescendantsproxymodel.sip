// Discarded CLASS_DECL on line 16 'KDescendantsProxyModelPrivate' (by default forward declaration handling)
class KDescendantsProxyModel: QAbstractProxyModel
{
%TypeHeaderCode
#include <kdescendantsproxymodel.h>
%End
    // Discarded VAR_DECL on line 62 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 62 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 62 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 62 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 62 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 62 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    enum AdditionalRoles {
        LevelRole,
        ExpandableRole,
        ExpandedRole,
        HasSiblingsRole
    };
    // Modified PARM_DECL on line 100 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KDescendantsProxyModel(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KDescendantsProxyModel();
    virtual void setSourceModel(QAbstractItemModel*  model);
    void setRootIndex(const QModelIndex & index);
    void setDisplayAncestorData(bool display);
    bool displayAncestorData() const;
    void setAncestorSeparator(const QString & separator);
    QString ancestorSeparator() const;
    virtual QModelIndex mapFromSource(const QModelIndex & sourceIndex) const;
    virtual QModelIndex mapToSource(const QModelIndex & proxyIndex) const;
    virtual Qt::ItemFlags flags(const QModelIndex & index) const;
    virtual QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    virtual int rowCount(const QModelIndex & parent = QModelIndex()) const;
    virtual QVariant headerData(int section, Qt::Orientation orientation, int role) const;
    virtual QMimeData * mimeData(const QList<QModelIndex> & indexes) const;
    virtual QStringList mimeTypes() const;
    virtual bool hasChildren(const QModelIndex & parent = QModelIndex()) const;
    virtual QModelIndex index(int __0, int __1, const QModelIndex & parent = QModelIndex()) const;
    virtual QModelIndex parent(const QModelIndex & __0) const;
    virtual int columnCount(const QModelIndex & index = QModelIndex()) const;
    virtual QHash<int, QByteArray> roleNames() const;
    void setExpandsByDefault(bool expand);
    bool expandsByDefault() const;
    bool isSourceIndexExpanded(const QModelIndex & sourceIndex) const;
    bool isSourceIndexVisible(const QModelIndex & sourceIndex) const;
    void expandSourceIndex(const QModelIndex & sourceIndex);
    void collapseSourceIndex(const QModelIndex & sourceIndex);
    virtual Qt::DropActions supportedDropActions() const;
    virtual QModelIndexList match(const QModelIndex & start, int role, const QVariant & value, int hits = 1, QFlags<Qt::MatchFlag> flags = Qt::MatchFlags(Qt::MatchStartsWith|Qt::MatchWrap)) const;
Q_SIGNALS:
    void sourceModelChanged();
    void displayAncestorDataChanged();
    void ancestorSeparatorChanged();
    void expandsByDefaultChanged(bool expands);
    void sourceIndexExpanded(const QModelIndex & sourceIndex);
    void sourceIndexCollapsed(const QModelIndex & sourceIndex);
private:
    private:
        KDescendantsProxyModel(const KDescendantsProxyModel &); // Generated
};
