<template>
  <div></div>
</template>

<script>
export default {
  name: 'MedicalRecordRedirect',
  created() {
    if (this.$router) {
      this.$router.replace({ path: '/hospital/diagnosis/record/index', query: this.$route.query });
    }
  }
}
</script>
