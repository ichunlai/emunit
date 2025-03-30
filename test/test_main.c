#include <unity.h>

void setUp(void) {
    // Set up test environment
}

void tearDown(void) {
    // Clean up test environment
}

void test_dummy(void) {
    TEST_ASSERT_EQUAL(1, 1);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_dummy);
    return UNITY_END();
}