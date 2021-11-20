// Discarded CLASS_DECL on line 17 'KBreadcrumbSelectionModelPrivate' (by default forward declaration handling)
class KBreadcrumbSelectionModel: QItemSelectionModel
{
%TypeHeaderCode
#include <kbreadcrumbselectionmodel.h>
%End
    // Discarded VAR_DECL on line 98 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 98 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 98 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 98 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 98 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 98 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    enum BreadcrumbTarget {
        MakeBreadcrumbSelectionInOther,
        MakeBreadcrumbSelectionInSelf
    };
    // Modified PARM_DECL on line 105 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KBreadcrumbSelectionModel(QItemSelectionModel*  selectionModel, QObject*  parent /TransferThis/ = nullptr);
    // Modified PARM_DECL on line 106 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KBreadcrumbSelectionModel(QItemSelectionModel*  selectionModel, KBreadcrumbSelectionModel::BreadcrumbTarget target, QObject*  parent /TransferThis/ = nullptr);
    virtual ~KBreadcrumbSelectionModel();
    bool isActualSelectionIncluded() const;
    void setActualSelectionIncluded(bool isActualSelectionIncluded);
    int breadcrumbLength() const;
    void setBreadcrumbLength(int breadcrumbLength);
    virtual void select(const QModelIndex & index, QFlags<QItemSelectionModel::SelectionFlag> command);
    virtual void select(const QItemSelection & selection, QFlags<QItemSelectionModel::SelectionFlag> command);
protected:
    // Discarded FIELD_DECL on line 139 'd_ptr' (by Qt5Ruleset.py:VariableRuleDb[1],variable_discard)
private:
    private:
        KBreadcrumbSelectionModel(const KBreadcrumbSelectionModel &); // Generated
};
