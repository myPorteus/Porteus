// Discarded CLASS_DECL on line 19 'QAbstractItemModel' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'QModelIndex' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'QItemSelection' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'KModelIndexProxyMapperPrivate' (by default forward declaration handling)
class KModelIndexProxyMapper: QObject
{
%TypeHeaderCode
#include <kmodelindexproxymapper.h>
%End
    // Discarded VAR_DECL on line 76 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 76 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 76 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 76 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 76 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 76 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    // Modified PARM_DECL on line 88 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KModelIndexProxyMapper(const QAbstractItemModel*  leftModel, const QAbstractItemModel*  rightModel, QObject*  parent /TransferThis/ = nullptr);
    virtual ~KModelIndexProxyMapper();
    QModelIndex mapLeftToRight(const QModelIndex & index) const;
    QModelIndex mapRightToLeft(const QModelIndex & index) const;
    QItemSelection mapSelectionLeftToRight(const QItemSelection & selection) const;
    QItemSelection mapSelectionRightToLeft(const QItemSelection & selection) const;
    bool isConnected() const;
Q_SIGNALS:
    void isConnectedChanged();
private:
    private:
        KModelIndexProxyMapper(const KModelIndexProxyMapper &); // Generated
};
