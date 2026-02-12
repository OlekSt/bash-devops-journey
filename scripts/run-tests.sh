#!/usr/bin/env bash
#
# run-tests.sh - Test suite runner
#
# Usage: ./scripts/run-tests.sh [sentinel|cerberus|all]

set -euo pipefail

PROJECT="${1:-all}"

run_project_tests() {
    local project=$1
    echo "🧪 Running $project tests..."
    
    if [[ -d "$project/tests" ]]; then
        local test_count=0
        local pass_count=0
        
        # Find all test files
        while IFS= read -r test_file; do
            ((test_count++))
            echo "  Testing: $(basename "$test_file")"
            if bash "$test_file"; then
                ((pass_count++))
            fi
        done < <(find "$project/tests" -name "test-*.sh" -type f)
        
        echo "  Results: $pass_count/$test_count passed"
        return $((test_count - pass_count))
    else
        echo "  No tests found for $project"
        return 0
    fi
}

case $PROJECT in
    sentinel|cerberus)
        run_project_tests "$PROJECT"
        ;;
    all)
        failed=0
        run_project_tests "sentinel" || ((failed++))
        run_project_tests "cerberus" || ((failed++))
        
        if ((failed == 0)); then
            echo "✅ All tests passed!"
        else
            echo "❌ Some tests failed"
            exit 1
        fi
        ;;
    *)
        echo "Usage: $0 [sentinel|cerberus|all]"
        exit 1
        ;;
esac
