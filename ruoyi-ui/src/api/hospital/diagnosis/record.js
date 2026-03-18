import request from '@/utils/request'

// 查询就诊记录列表
export function listMedicalRecord(query) {
  return request({
    url: '/hospital/record/list',
    method: 'get',
    params: query
  })
}

// 查询就诊记录详细
export function getMedicalRecord(recordId) {
  return request({
    url: '/hospital/record/' + recordId,
    method: 'get'
  })
}

// 新增就诊记录
export function addMedicalRecord(data) {
  return request({
    url: '/hospital/record',
    method: 'post',
    data: data
  })
}

// 修改就诊记录
export function updateMedicalRecord(data) {
  return request({
    url: '/hospital/record',
    method: 'put',
    data: data
  })
}

// 删除就诊记录
export function delMedicalRecord(recordId) {
  return request({
    url: '/hospital/record/' + recordId,
    method: 'delete'
  })
}

// 获取患者草稿处方
export function getDraftPrescription(patientId) {
  return request({
    url: '/hospital/record/draftPrescription/' + patientId,
    method: 'get'
  })
}
