go test -timeout 30s -run ^TestMsgParsing$ > results.txt #run tests in given folder
go test -timeout 30s -run ^TestMsgParsing$ github.com/ai/api/pkg/abc #run tests for given package inside the module

go clean --modcache