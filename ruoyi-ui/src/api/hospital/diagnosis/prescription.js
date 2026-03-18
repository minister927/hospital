import request from '@/utils/request'

// 查询处方列表
export function listPrescription(query) {
  return request({
    url: '/diagnosis/prescription/list',
    method: 'get',
    params: query
  })
}

// 查询处方详细
export function getPrescription(prescriptionId) {
  return request({
    url: '/diagnosis/prescription/' + prescriptionId,
    method: 'get'
  })
}

// 新增处方
export function addPrescription(data) {
  return request({
    url: '/diagnosis/prescription',
    method: 'post',
    data: data
  })
}

// 修改处方
export function updatePrescription(data) {
  return request({
    url: '/diagnosis/prescription',
    method: 'put',
    data: data
  })
}

// 删除处方
export function delPrescription(prescriptionId) {
  return request({
    url: '/diagnosis/prescription/' + prescriptionId,
    method: 'delete'
  })
}
