#
#  Dangerfile
#

# Configuration
project_scheme = 'NgNetworkModule-Package'
project= './NgNetworkModule.xcodeproj'

# Ensure there is a summary for a PR
if defined?(github)
  warn "Please provide a summary in the Pull Request description" if github.pr_body.length < 5
end

# Generate report
report = xcov.produce_report(
  scheme: project_scheme,
  project: project,
  skip_slack: true,
  only_project_targets: true,
)
xcov.output_report(report)

# Run SwiftFormat
swiftformat.check_format

# Run SwiftLint
swiftlint.lint_files

# Check for print and NSLog statements in modified files
ios_logs.check

changedFiles = (git.added_files + git.modified_files).select{ |file| file.end_with?('.swift') }
changedFiles.each do |changed_file|
  addedLines = git.diff_for_file(changed_file).patch.lines.select{ |line| line.start_with?('+') }

  # Check for TODOs in modified files
  warn "There are TODOs inside modified files!" if addedLines.map(&:downcase).select{ |line| line.include?('//') & line.include?('todo') }.count != 0

  # Check if new header files contains '//  Created by ' line
  fail "`//  Created by ` lines in header files should be removed" if addedLines.select{ |line| line.include?('//  Created by ') }.count != 0
end

# Check commits - warn if they are not nice
commit_lint.check warn: :all