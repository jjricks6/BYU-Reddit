<template>
  <div>Logging you out...</div>
</template>

<script>
import { deleteJwtToken } from "../auth";
export default {
  name: "LogoutPage",
  mounted: function () {
    deleteJwtToken();
    this.$router.push({ path: "/" });
  },
};
</script>