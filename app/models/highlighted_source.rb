class HighlightedSource
  def initialize(filename, source)
    @filename = filename
    @source = source
  end

  def lexer

    # TODO: spec
    # TODO: binary
    begin
      Pygments.lexer_name_for(filename: @filename)
    rescue MentosError => e
      Rails.logger.warn("Couldn't find lexer for #@filename: #{e.message}")

      :text
    end
  end

  def highlight
    wrap_lines(pygments)
  end
  alias_method :call, :highlight

  def to_highlighted_html
    highlight.join('')
  end

  def to_formatted_html
    src = highlight

    lns = line_numbers(src.size - 2).join("\n")
    code = src.join('')

    html = <<-HTML.strip_heredoc
      <table cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <th>
              <pre>#{lns}</pre>
            </th>
            <td width="100%">
              #{code}
            </td>
          </tr>
        </tbody>
      </table>
    HTML
  end

  private

  def line_numbers(count)
    t = %Q[<span id="LID%d" rel="#L%d">%d</span>]
    liner = ->(ln){t % [ln, ln, ln]}
    1.upto(count).map(&liner)
  end

  def wrap_lines(pygments_html)
    from = pygments_html.index('<pre>') + 5
    to = "</pre></div>".size

    pre = pygments_html[0...from]
    post = pygments_html[-to..-1]
    lines = pygments_html[from...-to].split("\n")

    wrapper = ->(line) { %Q[<div class="line"> %s </div>] % line }

    wrapped_lines = lines.map(&wrapper)

    [pre] + wrapped_lines + [post]
  end

  def pygments
    @source.force_encoding("UTF-8")
    Pygments.highlight(@source, :lexer => lexer)
  end
end
