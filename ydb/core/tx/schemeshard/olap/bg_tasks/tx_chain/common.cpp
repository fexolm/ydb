#include "common.h"

#include <ydb/library/services/services.pb.h>
#include <ydb/library/actors/core/log.h>

namespace NKikimr::NSchemeShard::NOlap::NBackground {

TConclusionStatus TTxChainData::DeserializeFromProto(const TProtoStorage& proto) {
    TablePath = proto.GetTablePath();
    for (auto&& i : proto.GetModification()) {
        Transactions.emplace_back(i.GetTransaction());
    }
    return TConclusionStatus::Success();
}

TTxChainData::TProtoStorage TTxChainData::SerializeToProto() const {
    TProtoStorage result;
    result.SetTablePath(TablePath);
    for (auto&& i : Transactions) {
        *result.AddModification()->MutableTransaction() = i;
    }
    
    AFL_NOTICE(NKikimrServices::FLAT_TX_SCHEMESHARD)("SerializeToProto", result.DebugString());
    return result;
}

}