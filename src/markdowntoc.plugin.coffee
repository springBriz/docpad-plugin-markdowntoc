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
			config = @config
			{inExtension,outExtension} = opts

			# Requires
			toc = require 'markdown-toc'
			
			if inExtension is 'md' and outExtension is 'html'

				if config.allowKorean
					slugify = (str) ->
						return str.toLowerCase().replace(/[^\w|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]+/g, '-')
				else
					slugify = true

				# Render synchronously
				opts.content = opts.content.replace(/<!-- toc -->/, toc(opts.content, {slugify: slugify}).content)

			# Done
			return
