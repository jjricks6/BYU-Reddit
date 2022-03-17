<!-- eslint-disable -->

<template>
  <v-app>
    <v-card elevation="9" min-width="1000">
      <v-container>
        <v-card-title>
          Create a new community
        </v-card-title>
      <v-row>
        <v-col>
        </v-col>
        <v-col cols=10>
          <v-row dense>
            <v-col>
              <v-card-title>
                <v-text-field
                  label="CommunityName"
                  v-model="communityname"
                ></v-text-field>
              </v-card-title>
              <v-card-title>
                <v-text-field
                  label="Description"
                  v-model="description"
                ></v-text-field>
              </v-card-title>
            </v-col>
          </v-row>
        </v-col>
        <v-col cols='1'>
        </v-col>
      </v-row>
      <v-row>
        <v-container>
            <v-row>
              <v-col cols="1">
              </v-col>
              <v-col cols="10">
                <v-select data-app
                  v-model="communitypicture"
                  :items="items"
                  label="Picture"
                ></v-select>
              </v-col>
            </v-row>
            <v-row>
            </v-row>
            <v-row>
              <v-col cols="10">
              </v-col>
              <v-col cols="2">
                <v-btn @click="createCommunity(communityname, description, communitypicture)">
                  Submit
                </v-btn>
              </v-col>
            </v-row>
        </v-container>
      </v-row>
      </v-container>
    </v-card>
  </v-app>
</template>

<script>
import Api from "../api";
export default {
  methods:{
    createCommunity(communityname, description, communitypicture){
      Api.createCommunity(communityname, description, communitypicture).then(() => {
        this.$router.push(`/c/${communityname}`);
      });
    }
  },

  data: () => ({
    items: ['BYU_Logo.png', 'Databases.png', 'Default.png', 'Dope.png', 'f12020.jpg', 'post1.jpg', 'rum.png'],
    communityname: "",
    description: "",
    communitypicture: null
  }),
}
</script>

<style>
.buttons {
  justify-content: flex-end;
}

.title {
  justify-content: flex-start;
}

.missing-data {
  font-weight: lighter;
  font-size: 24px;
  color: #CCCCCC;
}

.time {
  color: #a0a0a0
}

@media only screen and (max-width: 600px) {
  .buttons {
    justify-content: center;
  }
  .title {
    justify-content: center;
    text-align: center;
  }

}
</style>

