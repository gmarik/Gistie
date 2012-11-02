class HighlightedSource
  def initialize(filename, source)
    @filename = filename
    @source = source
  end

  def lexer
    case @filename
    when /\.rb/     then :ruby
    when /\.md/     then :markdown
    else                 :plain
    end
  end

  def highlight
    wrap_lines(pygments)
  end
  alias_method :call, :highlight

  def to_html
    highlight.join("\n")
  end

  def to_table_html
    src = highlight

    lns = line_numbers(src.size - 2).join("\n")
    code = src.join("\n")

    html = <<-HTML.strip_heredoc
      <table cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <th>
              <pre>
                #{lns}
              </pre>
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
    from = pygments_html.index('<span ')
    to = "</pre></div>".size

    pre = pygments_html[0...from]
    post = pygments_html[-to..-1]
    lines = pygments_html[from...-to].split("\n")

    wrapper = ->(line) { %Q[<div class="line"> %s </div>] % line }

    wrapped_lines = lines.map(&wrapper)

    [pre] + wrapped_lines + [post]
  end

  def pygments
    Pygments.highlight(@source, :lexer => lexer)
  end
end
