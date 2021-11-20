// Discarded CLASS_DECL on line 18 'QAbstractItemView' (by default forward declaration handling)
// Discarded CLASS_DECL on line 19 'QItemSelectionModel' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'QAbstractItemModel' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'QAbstractScrollArea' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'QModelIndex' (by default forward declaration handling)
// Discarded CLASS_DECL on line 24 'KViewStateSerializerPrivate' (by default forward declaration handling)
class KViewStateSerializer: QObject
{
%TypeHeaderCode
#include <kviewstateserializer.h>
%End
    // Discarded VAR_DECL on line 170 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 170 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 170 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 170 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 170 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 170 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 175 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KViewStateSerializer(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KViewStateSerializer();
    QAbstractItemView * view() const;
    void setView(QAbstractItemView*  view);
    QItemSelectionModel * selectionModel() const;
    void setSelectionModel(QItemSelectionModel*  selectionModel);
    QStringList selectionKeys() const;
    QStringList expansionKeys() const;
    QString currentIndexKey() const;
    // Discarded CXX_METHOD on line 220 'scrollState' (by rules_PyKF5.py:FunctionRuleDb[16],function_discard)
    void restoreSelection(const QStringList & indexStrings);
    void restoreCurrentItem(const QString & indexString);
    void restoreExpanded(const QStringList & indexStrings);
    void restoreScrollState(int verticalScoll, int horizontalScroll);
protected:
    virtual QModelIndex indexFromConfigString(const QAbstractItemModel*  model, const QString & key) const = 0;
    virtual QString indexToConfigString(const QModelIndex & index) const = 0;
    void restoreState();
private:
    private:
        KViewStateSerializer(const KViewStateSerializer &); // Generated
};
