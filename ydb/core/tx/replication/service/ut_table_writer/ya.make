UNITTEST_FOR(ydb/core/tx/replication/service)

FORK_SUBTESTS()

SIZE(MEDIUM)

PEERDIR(
    ydb/core/tx/replication/ut_helpers
    library/cpp/string_utils/base64
    library/cpp/testing/unittest
)

SRCS(
    table_writer_ut.cpp
)

YQL_LAST_ABI_VERSION()

END()
