import request from '@/utils/request'

// 查询药品分类列表
export function listCategory(query) {
  return request({
    url: '/hospital/category/list',
    method: 'get',
    params: query
  })
}

// 查询药品分类详细
export function getCategory(categoryId) {
  return request({
    url: '/hospital/category/' + categoryId,
    method: 'get'
  })
}

// 新增药品分类
export function addCategory(data) {
  return request({
    url: '/hospital/category',
    method: 'post',
    data: data
  })
}

// 修改药品分类
export function updateCategory(data) {
  return request({
    url: '/hospital/category',
    method: 'put',
    data: data
  })
}

// 删除药品分类
export function delCategory(categoryId) {
  return request({
    url: '/hospital/category/' + categoryId,
    method: 'delete'
  })
}
