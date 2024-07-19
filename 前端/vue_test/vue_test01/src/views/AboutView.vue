<template>
  <div class="about">
    <h1 class="text">开发中....</h1>
    <div class="loader">
      <el-loading :fullscreen="false" lock v-loading="loading" class="custom-loading">
      </el-loading>
    </div>
  </div>
</template>

<script>


export default {
  data() {
    return {
      loading: true
    };
  },
  methods: {
    stopLoading() {
      this.loading = false;
    }
  }
};
</script>

<style scoped>
.custom-loading {
  display: flex;
  align-items: center;
}

.loader {
  margin-top: 20%;
}

.text{
  color: #b1b1b1;
}
</style>