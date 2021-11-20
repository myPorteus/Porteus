// Discarded CLASS_DECL on line 19 'KLinkItemSelectionModelPrivate' (by default forward declaration handling)
class KLinkItemSelectionModel: QItemSelectionModel
{
%TypeHeaderCode
#include <klinkitemselectionmodel.h>
%End
    // Discarded VAR_DECL on line 90 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 90 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 90 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 90 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 90 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 90 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 97 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KLinkItemSelectionModel(QAbstractItemModel*  targetModel, QItemSelectionModel*  linkedItemSelectionModel, QObject*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 99 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KLinkItemSelectionModel(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KLinkItemSelectionModel();
    QItemSelectionModel * linkedItemSelectionModel() const;
    void setLinkedItemSelectionModel(QItemSelectionModel*  selectionModel);
    virtual void select(const QModelIndex & index, QFlags<QItemSelectionModel::SelectionFlag> command);
    virtual void select(const QItemSelection & selection, QFlags<QItemSelectionModel::SelectionFlag> command);
Q_SIGNALS:
    void linkedItemSelectionModelChanged();
protected:
    // Discarded FIELD_DECL on line 113 'd_ptr' (by Qt5Ruleset.py:VariableRuleDb[1],variable_discard)
private:
    private:
        KLinkItemSelectionModel(const KLinkItemSelectionModel &); // Generated
};
