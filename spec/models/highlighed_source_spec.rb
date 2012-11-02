require 'spec_helper'

describe HighlightedSource do

  subject(:code) {
    HighlightedSource.new('test.rb', <<-RUBY)
      puts 'hi'
      puts 'world'
    RUBY
  }


  it "highlights code" do
    subject.to_highlighted_html.should == <<-HTML.strip_heredoc.chomp
      <div class="highlight"><pre><div class="line">       <span class="nb">puts</span> <span class="s1">&#39;hi&#39;</span> </div><div class="line">       <span class="nb">puts</span> <span class="s1">&#39;world&#39;</span> </div></pre></div>
    HTML
  end


  it "highlights numbered code " do
    subject.to_formatted_html.should == <<-HTML.strip_heredoc
      <table cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <th>
              <pre><span id="LID1" rel="#L1">1</span>
<span id="LID2" rel="#L2">2</span></pre>
            </th>
            <td width="100%">
              <div class="highlight"><pre><div class="line">       <span class="nb">puts</span> <span class="s1">&#39;hi&#39;</span> </div><div class="line">       <span class="nb">puts</span> <span class="s1">&#39;world&#39;</span> </div></pre></div>
            </td>
          </tr>
        </tbody>
      </table>
    HTML
  end
end

 
