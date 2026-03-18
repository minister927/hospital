import request from '@/utils/request'

// 查询医护人员信息列表
export function listInfo(query) {
  return request({
    url: '/doctor/info/list',
    method: 'get',
    params: query
  })
}

// 查询医护人员信息详细
export function getInfo(staffId) {
  return request({
    url: '/doctor/info/' + staffId,
    method: 'get'
  })
}

// 新增医护人员信息
export function addInfo(data) {
  return request({
    url: '/doctor/info',
    method: 'post',
    data: data
  })
}

// 修改医护人员信息
export function updateInfo(data) {
  return request({
    url: '/doctor/info',
    method: 'put',
    data: data
  })
}

// 删除医护人员信息
export function delInfo(staffId) {
  return request({
    url: '/doctor/info/' + staffId,
    method: 'delete'
  })
}
