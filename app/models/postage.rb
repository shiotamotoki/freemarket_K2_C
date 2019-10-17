class Postage < ActiveHash::Base
  self.data = [
    {id: 0, name: '---'}, {id: 1, name: '送料込み(出品者負担)'}, {id: 2, name: '未使用に近い'}
  ]
end