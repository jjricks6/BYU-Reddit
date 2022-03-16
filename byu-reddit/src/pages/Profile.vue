<!-- eslint-disable -->

<template>
  <v-card
    class="mx-auto"
    max-width="434"
    tile
  >
    <v-img
      height="100%"
      src="https://cdn.vuetifyjs.com/images/cards/server-room.jpg"
    >
      <v-row
        align="end"
        class="fill-height"
      >
        <v-col
          align-self="start"
          class="pa-0"
          cols="12"
        >
          <v-avatar
            class="profile"
            color="grey"
            size="164"
            tile
          >
            <v-img src="https://cdn.vuetifyjs.com/images/profiles/marcus.jpg"></v-img>
          </v-avatar>
        </v-col>
        <v-col class="py-0">
          <v-list-item
            color="rgba(0, 0, 0, .4)"
            dark
          >
            <v-list-item-content>
              <v-list-item-title class="text-h6">
                {{ user[0].username}}
              </v-list-item-title>
              <v-list-item-subtitle>Network Engineer</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
      </v-row>
    </v-img>
  </v-card>
</template>

<script>
import Api from "../api";
//import Post from "../components/Post.vue"

export default {
  components:{
//    Post
  },
  name: "ProfilePage",
  data: function () {
    return {
      loading: false,
      user: [],
      //filter_items: ["Top", "Popular"]
    };
  },
  created: function () {
    this.loading = true;
    Api.getProfile().then((res) => {
      this.user = res.data;
      this.loading = false;
      console.log(this.user);
    });
  },
};
</script>