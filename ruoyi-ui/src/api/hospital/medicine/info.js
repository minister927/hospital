import request from '@/utils/request'

// 查询药品信息列表
export function listMedicine(query) {
  return request({
    url: '/hospital/medicine/list',
    method: 'get',
    params: query
  })
}

// 查询药品信息详细
export function getMedicine(medicineId) {
  return request({
    url: '/hospital/medicine/' + medicineId,
    method: 'get'
  })
}

// 新增药品信息
export function addMedicine(data) {
  return request({
    url: '/hospital/medicine',
    method: 'post',
    data: data
  })
}

// 修改药品信息
export function updateMedicine(data) {
  return request({
    url: '/hospital/medicine',
    method: 'put',
    data: data
  })
}

// 删除药品信息
export function delMedicine(medicineId) {
  return request({
    url: '/hospital/medicine/' + medicineId,
    method: 'delete'
  })
}
