# Health Planet to Idobata

Bring data in [Health Planet](https://www.healthplanet.jp/) to [Idobata](http://idobata.io).

## Requirements

- Heroku / Heroku Scheduler (add-on)
- ['idobata'](https://github.com/asonas/idobata-ruby) gem
- Idobata API Generic Hook
- [Health Planet API](https://www.healthplanet.jp/apis/api.html) id/secret
   - `※値の取得は1時間60回までの制限がありますのでご注意ください。`
   - cf. [体組成データを取得する。](http://www.mirandora.com/?p=808) - mirandora.commirandora.com

## How to setup 

TODO

1. Set environment variables: 
    - `IDOBATA_END` for Idobata Generic Hook token
    - Command Example: `heroku config:add IDOBATA_END=https://idobata.io/hook/custom/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"`
2. `heroku create; git push heroku master`
3. `heroku addons:add scheduler`
4. Test: `heroku run bundle exec ruby main.rb`
5. Add a job to [Heroku Scheduler](https://scheduler.heroku.com/dashboard)
   - Task: `bundle exec ruby main.rb`
   - Dyno Size: `1x`
   - Frequency: `Hourly`
6. Done!

## References

- [APIの設定 - ヘルスプラネット](https://www.healthplanet.jp/apis/api.html)
- [体組成データを取得する。](http://www.mirandora.com/?p=808) - mirandora.commirandora.com
- [Health Planet からデータをエクスポートするための embulk-input-healthplanet プラグイン](http://muziyoshiz.hatenablog.com/entry/2016/01/11/234921) - 無印吉澤



## License 

The MIT License (MIT)

Copyright &copy; 2016 [YassLab](http://yasslab.jp)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
