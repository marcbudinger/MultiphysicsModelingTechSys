{% extends 'markdown.tpl' %}

{%- block header -%}
---
title: {{resources['metadata']['name']}}
description: {{resources['metadata']['description']}}
---

{%- endblock header -%}

{% block in_prompt %}
**In [{{ cell.execution_count }}]:**
{% endblock in_prompt %}

{% block data_markdown scoped %}

{% endblock data_markdown %}

{% block data_svg %} 
![svg]({{ output.metadata.filenames['image/svg+xml'] | path2url }}) 
{% endblock data_svg %} 

{% block data_png %} 
![png]({{ output.metadata.filenames['image/png'] | path2url }}) 
{% endblock data_png %} 

{% block data_jpg %} 
![jpeg]({{ output.metadata.filenames['image/jpeg'] | path2url }}) 
{% endblock data_jpg %}


{% block input %}
{{ '{% highlight python %}' }}
{{ cell.source }}
{{ '{% endhighlight %}' }}
{% endblock input %}

