// Discarded CLASS_DECL on line 16 'KCategorizedSortFilterProxyModelPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QItemSelection' (by default forward declaration handling)
class KCategorizedSortFilterProxyModel: QSortFilterProxyModel
{
%TypeHeaderCode
#include <kcategorizedsortfilterproxymodel.h>
%End
public:
    enum AdditionalRoles {
        CategoryDisplayRole,
        CategorySortRole
    };
    // Modified PARM_DECL on line 51 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCategorizedSortFilterProxyModel(QObject*  parent /TransferThis/ = nullptr);
    virtual ~KCategorizedSortFilterProxyModel();
    virtual void sort(int column, Qt::SortOrder order = Qt::AscendingOrder);
    bool isCategorizedModel() const;
    void setCategorizedModel(bool categorizedModel);
    int sortColumn() const;
    Qt::SortOrder sortOrder() const;
    void setSortCategoriesByNaturalComparison(bool sortCategoriesByNaturalComparison);
    bool sortCategoriesByNaturalComparison() const;
    static int naturalCompare(const QString & a, const QString & b);
protected:
    virtual bool lessThan(const QModelIndex & left, const QModelIndex & right) const;
    virtual bool subSortLessThan(const QModelIndex & left, const QModelIndex & right) const;
    virtual int compareCategories(const QModelIndex & left, const QModelIndex & right) const;
private:
    private:
        KCategorizedSortFilterProxyModel(const KCategorizedSortFilterProxyModel &); // Generated
};
