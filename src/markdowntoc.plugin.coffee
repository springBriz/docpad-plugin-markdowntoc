# Export Plugin
module.exports = (BasePlugin) ->
	# Define Plugin
	class MarkdownTocPlugin extends BasePlugin
		# Plugin name
		name: 'markdowntoc'

		# Plugin configuration
		config:
			allowKorean: false
		
		# Plugin priority : MUST BE higher than markdown parser plugin (docpad-plugin-marked)
		priority: 700
		
		#
		generateToc: (content) ->
			# Prepare
			config = @config

			# Requires
			toc = require 'markdown-toc'

			if config.allowKorean is true
				slugify = (str) ->
					return str.toLowerCase().replace(/[^\w|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]+/g, '-')
			else
				slugify = true

			return content.replace(/<!-- toc -->/, toc(content, {slugify: slugify}).content)
			
		# Render : for .html.md
		render: (opts) ->
			if opts.inExtension in ['md','markdown']
				opts.content = @generateToc(opts.content)

		# Render document : for .md
		renderDocument: (opts) ->
			if opts.templateData.document.extension in ['md','markdown'] and opts.templateData.document.outExtension in ['md','markdown']
				opts.content = opts.content = @generateToc(opts.content)
