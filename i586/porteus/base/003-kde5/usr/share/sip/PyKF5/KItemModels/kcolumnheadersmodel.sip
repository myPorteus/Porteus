// Discarded CLASS_DECL on line 16 'KColumnHeadersModelPrivate' (by default forward declaration handling)
class KColumnHeadersModel: QAbstractListModel
{
%TypeHeaderCode
#include <kcolumnheadersmodel.h>
%End
    // Discarded VAR_DECL on line 32 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 32 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 32 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 32 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 32 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 32 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 36 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KColumnHeadersModel(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KColumnHeadersModel();
    virtual int rowCount(const QModelIndex & parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex & index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;
    QAbstractItemModel * sourceModel() const;
    void setSourceModel(QAbstractItemModel*  newSourceModel);
Q_SIGNALS:
    void sourceModelChanged();
private:
    private:
        KColumnHeadersModel(const KColumnHeadersModel &); // Generated
};
