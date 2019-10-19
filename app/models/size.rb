class Size < ActiveHash::Base
  self.data = [
    {id: 0, name: '---'}, {id: 1, name: 'XXS以下'}, {id: 2, name: 'XS(SS)'}, {id: 3, name: 'S'},
    {id: 4, name: 'M'}, {id: 5, name: 'L'}, {id: 6, name: 'XL(LL)'},
    {id: 7, name: '2XL(3L)'}, {id: 8, name: '3XL(4L)'}, {id: 9, name: '4XL(5L)以上'},
    {id: 10, name: 'FREE SIZE'}, {id: 11, name: '20cm以下'}, {id: 12, name: '20.5cm'},
    {id: 13, name: '21cm'}, {id: 14, name: '22cm'}, {id: 15, name: '22.5cm'},
    {id: 16, name: '23cm'}, {id: 17, name: '23.5cm'}, {id: 18, name: '24cm'},
    {id: 19, name: '24.5cm'}, {id: 20, name: '25cm'}, {id: 21, name: '25.5cm'},
    {id: 22, name: '26cm'}, {id: 23, name: '26.5cm'}, {id: 24, name: '27cm'}, {id: 25, name: '27.5cm以上'}
  ]
end