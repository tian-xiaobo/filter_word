# 和谐过滤器

和谐过滤器用于检查输入是否包含中文或英文敏感词，并可替换为特殊字符。生活在天朝，和谐过滤器必须人手必备。

### 特点

* 速度快，比常规的正则匹配要快10倍以上，具体性能可运行benchmark查看
* 可以输出检测到的敏感词，请看初始
* 简单，可根据需要方便的调整敏感词字库

### 默认使用

<pre>
validate_harmonious_of *attr_names
</pre>

* 检查输入是否包含敏感词 `FilterWord.clean?(your_input)`
* 检查包含的敏感词 `FilterWord.harmonious_words(your_input)`
* 替换包含的敏感词为* `FilterWord.clean(your_input)`

### 自定义使用

你可以使用相应模型下敏感词库，例如

<pre>
validate_harmonious_of [:title, :body], model: post
</pre>

这时将会使用 `post_chinese_dictionary.hash` 与 `post_english_dictionary.yml` 敏感词库

同理使用这两个敏感词库

* 检查输入是否包含敏感词 `FilterWord.clean?(your_input, 'post')`
* 检查包含的敏感词 `FilterWord.harmonious_words(your_input, 'post')`
* 替换包含的敏感词为 `FilterWord.clean(your_input, 'post')`

(注：自定义使用时必须有相对应的铭感词库)

### 安装

准备Gemfile
<pre>
gem filter_word
</pre>

创建必要的配置文件
<pre>
rails g filter_word:setup
</pre>

然后你需要准备敏感词字库，如果你已经有自己的敏感词库，请把中文和英文词对应复制到项目目录`config/filter_word/`下的**chinese_dictionary.txt**和**english_dictionary.txt**。

最后需要生成序列化的词库，默认使用直接运行
<pre>
rake filter_word:generate 
</pre>
将会生成 `harmonious.hash` 与 `harmonious_english.yml` 词库

自定义使用运行
<pre>
rake filter_word:generate model=post
</pre>
将会生成 `post_harmonious.hash` 与 `post_harmonious_english.yml` 词库

### 原理

不同与常规敏感词检查正则匹配，和谐过滤器对输入的中文以给定敏感词字库做为分词词库做分词处理，算法采用自yzhang的<https://github.com/yzhang/rseg>，和谐过滤器对算法做了简化处理以提高效率。


### License

MIT license

