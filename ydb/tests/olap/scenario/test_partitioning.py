from conftest import BaseTestSet
from ydb.tests.olap.scenario.helpers import (
    ScenarioTestHelper,
    TestContext,
    CreateTable,
    CreateTableStore,
    AlterObject,
    AlterSharding
)
from ydb import PrimitiveType, StatusCode
import ydb.tests.olap.scenario.helpers.data_generators as dg
import time


class TestPartitioning(BaseTestSet):
    schema1 = (
        ScenarioTestHelper.Schema()
        .with_column(name='id', type=PrimitiveType.Int32, not_null=True)
        .with_column(name='level', type=PrimitiveType.Uint32)
        .with_key_columns('id')
    )

    def _test_table(self, ctx: TestContext, table_name: str):
        sth = ScenarioTestHelper(ctx)
        sth.execute_scheme_query(CreateTable(table_name).with_schema(self.schema1).with_partitions_count(2))

        sth.bulk_upsert(table_name, dg.DataGeneratorPerColumn(self.schema1, 100), comment="100 sequetial ids")

        sth.execute_scheme_query(AlterObject(table_name).action(AlterSharding("SPLIT")))

        # sth.bulk_upsert(table_name, dg.DataGeneratorPerColumn(self.schema1, 100), comment="100 sequetial ids")

        time.sleep(240)

        sth.bulk_upsert(table_name, dg.DataGeneratorPerColumn(self.schema1, 100), comment="100 sequetial ids")

        sth.execute_scheme_query(AlterObject(table_name).action(AlterSharding("SPLIT")))

        # sth.bulk_upsert(table_name, dg.DataGeneratorPerColumn(self.schema1, 100), comment="100 sequetial ids")

        time.sleep(240)

        sth.bulk_upsert(table_name, dg.DataGeneratorPerColumn(self.schema1, 100), comment="100 sequetial ids")

        sth.execute_scheme_query(AlterObject(table_name).action(AlterSharding("MERGE")))

        # sth.bulk_upsert(table_name, dg.DataGeneratorPerColumn(self.schema1, 100), comment="100 sequetial ids")

        # gen = dg.DataGeneratorPerColumn(self.schema1, 100, dg.ColumnValueGeneratorDefault(init_value=200))
        # sth.bulk_upsert(table_name, gen, comment="100 sequetial ids")


    def scenario_table(self, ctx: TestContext):
        tablestore_name = "testStore5"
        sth = ScenarioTestHelper(ctx)
        sth.execute_scheme_query(CreateTableStore(tablestore_name).with_schema(self.schema1))
        self._test_table(ctx, tablestore_name + '/testTable')