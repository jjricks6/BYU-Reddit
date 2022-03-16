import Vue from "vue";
import VueRouter from "vue-router";
import { BootstrapVue, IconsPlugin } from "bootstrap-vue";
import Vuex from 'vuex'

import App from "./App.vue";
import Home from "./pages/Home";
import Feed from "./pages/Feed";
import Explore from "./pages/Explore";
import Login from "./pages/Login";
import Logout from "./pages/Logout";
import Register from "./pages/Register";
import Community from "./pages/Community";
import Profile from "./pages/Profile";
import Search from "./pages/Search";
import Post from "./pages/Post";

Vue.config.productionTip = false;
Vue.use(Vuex)

import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";
import { getJwtToken } from "./auth";
import vuetify from './plugins/vuetify'

Vue.use(BootstrapVue);
Vue.use(IconsPlugin);
Vue.use(VueRouter);

const checkAuth = function(to, _, next) {
  const token = getJwtToken();
  if (token === undefined || token === "undefined" || token === null) {
    // redirect to login because we don't have token yet
    next({
      path: "/login",
      params: { nextUrl: to.fullPath },
    });
  } else {
    next();
  }
};

const router = new VueRouter({
  routes: [
    { path: "/", component: Home },
    { path: "/c/:communityname", component: Community },
    { path: "/login", component: Login },
    { path: "/logout", component: Logout },
    { path: "/register", component: Register },
    { path: "/u/:username", component: Profile },
    { path: "/explore", component: Explore },
    { path: "/search", component: Search },
    { path: "/c/:communityname/:id", component: Post },

    {
      path: "/feed",
      component: Feed,
      beforeEnter: checkAuth,
      children: [
      ],
    },
  ],
});

Vue.prototype.$user = null

const store = new Vuex.Store({
  state: {
    user: undefined,
  },
  mutations: {
      setUser(state, user) {
          state.user = user
      },
  },
  actions: {
    async updateUser(user) {
      this.commit('setUser', user)
    }
  }
})

new Vue({
  store,
  router,
  vuetify,
  render: (h) => h(App),
  created: () => {
    store.dispatch('updateUser')
}
}).$mount("#app");
