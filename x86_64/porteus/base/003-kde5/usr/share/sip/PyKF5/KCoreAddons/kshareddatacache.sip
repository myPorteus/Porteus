// Discarded CLASS_DECL on line 14 'QString' (by default forward declaration handling)
// Discarded CLASS_DECL on line 15 'QByteArray' (by default forward declaration handling)
class KSharedDataCache
{
%TypeHeaderCode
#include <kshareddatacache.h>
%End
public:
    KSharedDataCache(const QString & cacheName, unsigned int defaultCacheSize, unsigned int expectedItemSize = 0);
    ~KSharedDataCache();
    // Discarded CXX_METHOD on line 73 'operator=' (by rules_PyKF5.py:FunctionRuleDb[10],function_discard)
    enum EvictionPolicy {
        NoEvictionPreference,
        EvictLeastRecentlyUsed,
        EvictLeastOftenUsed,
        EvictOldest
    };
    KSharedDataCache::EvictionPolicy evictionPolicy() const;
    void setEvictionPolicy(KSharedDataCache::EvictionPolicy newPolicy);
    bool insert(const QString & key, const QByteArray & data);
    bool find(const QString & key, QByteArray*  destination) const;
    void clear();
    static void deleteCache(const QString & cacheName);
    bool contains(const QString & key) const;
    unsigned int totalSize() const;
    unsigned int freeSize() const;
    unsigned int timestamp() const;
    void setTimestamp(unsigned int newTimestamp);
private:
    private:
        KSharedDataCache(const KSharedDataCache &); // Generated
};
