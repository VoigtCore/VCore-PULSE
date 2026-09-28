#!/usr/bin/env bash
# Builds third-party code only. No Pulse source, credentials or database is used.
set -euo pipefail
ROOT="$PWD"
WORK="$(mktemp -d)"
export WORK
SQLCIPHER_COMMIT=63697beb0fafcb61faa7a3e6fd267036548ab11b
git clone --depth 1 --branch v4.18.0 https://github.com/sqlcipher/sqlcipher.git "$WORK/sqlcipher"
test "$(git -C "$WORK/sqlcipher" rev-parse HEAD)" = "$SQLCIPHER_COMMIT"
cd "$WORK/sqlcipher"
./configure --with-tempstore=yes --disable-shared --disable-readline
make -j2 sqlite3.c sqlite3.h
cd "$WORK"
curl --fail --location --retry 3 https://registry.npmjs.org/better-sqlite3/-/better-sqlite3-13.0.3.tgz -o driver.tgz
python3 - <<'PY'
import base64,hashlib,tarfile,pathlib
b=pathlib.Path('driver.tgz').read_bytes()
assert base64.b64encode(hashlib.sha512(b).digest()).decode()=='RbOBxmLBG8uvFUc15X9+9SFemKcQ0WBuISBVkpuiaUB2qblC8UWlHEjdWVoZ8AdhSwmoEgsiXKfopX0CQxaACQ=='
with tarfile.open('driver.tgz') as t:
 for m in t.getmembers():
  assert m.isfile() or m.isdir()
  assert m.name.startswith('package/') and '..' not in pathlib.PurePosixPath(m.name).parts
 t.extractall('.')
PY
cd "$WORK/package"
npm install --ignore-scripts --omit=dev --omit=optional --no-audit --no-fund
npm install --ignore-scripts --no-save --no-audit --no-fund node-gyp@11.5.0
python3 - <<'PY'
import pathlib,os,platform,subprocess
root=pathlib.Path(os.environ['WORK'])
source=root/'sqlcipher/sqlite3.c'
defines='''#define SQLITE_HAS_CODEC 1
#define SQLITE_TEMP_STORE 2
#define SQLITE_EXTRA_INIT sqlcipher_extra_init
#define SQLITE_EXTRA_SHUTDOWN sqlcipher_extra_shutdown
#define SQLITE_THREADSAFE 2
#define SQLITE_ENABLE_FTS5 1
#define SQLITE_ENABLE_COLUMN_METADATA 1
'''
if platform.system()=='Darwin':
 defines+='#define SQLCIPHER_CRYPTO_CC 1\n'
 libraries=['-framework Security','-framework CoreFoundation']
else:
 defines+='#define SQLCIPHER_CRYPTO_OPENSSL 1\n'
 triplet=subprocess.check_output(['cc','-dumpmachine'],text=True).strip()
 crypto=pathlib.Path('/usr/lib')/triplet/'libcrypto.a'
 assert crypto.is_file()
 libraries=[str(crypto),'-ldl','-lpthread']
source.write_text(defines+source.read_text())
p=pathlib.Path('binding.gyp');s=p.read_text();needle="'target_name': 'better_sqlite3',";assert s.count(needle)==1
p.write_text(s.replace(needle,needle+"\n      'libraries': "+repr(libraries)+","))
PY
if [ "$(uname -s)" = Darwin ]; then export MACOSX_DEPLOYMENT_TARGET=13.5; fi
node node_modules/node-gyp/bin/node-gyp.js rebuild --release --force_build=1 --sqlite3="$WORK/sqlcipher" -j 2
export NATIVE_OUTPUT="$ROOT/native-output"
node "$ROOT/tools/native-crypto/verify.cjs"
