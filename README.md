### Created with [VuePress](https://vuepress.vuejs.org/).

```bash
# start server
vuepress dev

# build
vuepress build

# view build
cd .vuepress/dist/
ls -al

# push new build
git init
git add -A
git commit -m 'update content'
git push -f git@github.com:Infinite-Actuary/Econ-417-McGarvey.git master:gh-pages
```
