# Export Plugin
module.exports = (BasePlugin) ->
	# Define Plugin
	class MarkdownTocPlugin extends BasePlugin
		# Plugin name
		name: 'markdowntoc'

		# Plugin priority : must be higher than marked plugin
		priority: 700
		
		# Render
		# Called per document, for each extension conversion. Used to render one extension to another.
		render: (opts) ->
			# Prepare
			{inExtension,outExtension} = opts

			#
			toc = require 'markdown-toc'
			
			if inExtension is 'md' and outExtension is 'html'

				# Render synchronously
				opts.content = opts.content.replace(/<!-- toc -->/, toc(opts.content).content)

			# Done
			return
