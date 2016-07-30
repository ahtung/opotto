# look up the build artifacts for circle ci, these should be posted to the PR
if @SDM_DANGER_REPORT_CIRCLE_CI_ARTIFACTS
	username = ENV['CIRCLE_PROJECT_USERNAME']
	project_name = ENV['CIRCLE_PROJECT_REPONAME']
	build_number = ENV['CIRCLE_BUILD_NUM']
	node_index = ENV['CIRCLE_NODE_INDEX']
	should_display_message = username && project_name && build_number && node_index
	if should_display_message

		# build the path to where the circle CI artifacts will be uploaded to
		circle_ci_artifact_path  = 'https://circleci.com/api/v1/project/'
		circle_ci_artifact_path += username
		circle_ci_artifact_path += '/'
		circle_ci_artifact_path += project_name
		circle_ci_artifact_path += '/'
		circle_ci_artifact_path += build_number
		circle_ci_artifact_path += '/artifacts/'
		circle_ci_artifact_path += node_index
		circle_ci_artifact_path += '/$CIRCLE_ARTIFACTS/'

		message_string = ''
		@SDM_DANGER_REPORT_CIRCLE_CI_ARTIFACTS.each do |artifact|
			# create a markdown link that uses the message text and the artifact path
			message_string += '['+artifact['message']+']'
			message_string += '('+circle_ci_artifact_path+artifact['path']+')'

			# if this isn't the last artifact then append the " & " string to make this one line
			message_string += ' & ' if @SDM_DANGER_REPORT_CIRCLE_CI_ARTIFACTS.last != artifact
		end
		message(message_string)
	end
end

# put labels on PRs, this will autofail all PRs without contributor intervention (this is intentional to force someone to look at and categorize each PR before merging)
fail('PR needs labels', sticky: true) if github.pr_labels.empty?

# Sometimes its a README fix, or something like that - which isn't relevant for
# including in a CHANGELOG for example
has_app_changes = !git.modified_files.grep(/lib/).empty?
has_test_changes = !git.modified_files.grep(/spec/).empty?

if has_app_changes && !has_test_changes
  warn "Tests were not updated"
end

# Mainly to encourage writing up some reasoning about the PR, rather than
# just leaving a title
if github.pr_body.length < 5
  fail "Please provide a summary in the Pull Request description"
end

