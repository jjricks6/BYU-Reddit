<!-- eslint-disable -->

<template>
  <v-card elevation="10" min-width="1000">
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
                    v-model="communityName"
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
        <v-card min-width="1000">
            <v-container>
                <v-row>
                    <v-col cols="1">
                    </v-col>
                    <v-col cols="10">
                        <v-file-input
                            accept="image/*"
                            label="Upload a picture"
                            v-model="picture">
                            
                        </v-file-input>
                    </v-col>
                </v-row>
                <v-row>
                </v-row>
                <v-row>
                    <v-col cols="10">
                    </v-col>
                    <v-col cols="2">
                        <v-btn>
                            Submit
                        </v-btn>
                    </v-col>
                </v-row>
            </v-container>
        </v-card>
    </v-row>
    </v-container>
  </v-card>
</template>

<script>

export default {
  methods:{
  },

  data() {
    return {
      communityName: "",
      Description:"",
      picture: null
    }
  }
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

