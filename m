Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632088;
	b=Aj+pHub/s5x2frNb7XrBbw+DTbb4kgNimEoD+7hpJtH6JjBGqp7srPfpmowiySKaeo2b
	 GfPZU+C8zh2sjoiCqNZw0CZQGuC138auXqFCHFzrd6dVKXjsA7TqB8OUeNrd32jFKtNjU
	 HzjcoTdJcOZPgiIViVl1tmb7VyslGPgB2ASaGGM3+tMqlz1GXmB9LTF3i62lyaDeM8I1j
	 gfEfsQC0WKQ2Jbvn2PYGwEiX/eN9eox1bKmjFj+T0W246HUG4E/G4FCruyZWkSIqjrLHb
	 UpkN8+ha1INspItN0+jZWJMHJQBD3HleYkowrnuf4iYrktjLSYcueaCVgXaUQNaVJrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632088;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=c6vXo64FE51u/FRjXpJ4fxOm9pgZA8t7pGEdtQQpkrc=;
	b=FyAd6w49gw6Kr4bqJ7+2n9QjWfeT9i14POuZ6pcLdHkmp2NQY7srNjEmABT3rSS144eD
	 szznTUd4y5W4XTe7ll1ZkUwntymHauv1eEK3VcCakNtxs8MQG+6L8mLzeoHXxBET1T96s
	 D5dGhE2/BW/AEOqg8zWLEwaBLjXzZ/sjBg9Y5PorzVmsKrrVoZuZ/8s+QsV2HyR1YUJ2l
	 Hb4iuJ2r1f3KD0bmhkjvlhSCXxX1yvTcYY4EE9R3lRewwYT/UIPgNlykLwIkIUhGRzulC
	 hJAuA3D7D9a5p6WwstHrKHhNIascCj4i7u875GXFpEeK2C1a2+J3PpX8wQU6xUWt/eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKzpjaeK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A7C60A0FF9;
	Mon,  2 Nov 2026 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKzpjaeK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599D11F00A25;
	Mon,  2 Nov 2026 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632087;
	bh=c6vXo64FE51u/FRjXpJ4fxOm9pgZA8t7pGEdtQQpkrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FKzpjaeKxeWvrMo9fGM/PnSq0y0waTRF4nSaoUSYDv463BztBvjEVpSlC5+0COvjN
	 X26BBza7Xv6XWxrBPglzRWkVzVzPJvCoHeXy3056YIhWrGQWrPbp2OLtEmO4vPx/SG
	 7+g0AzMvI7cNlqVF/b6KqJ0pltCp527K6EerXOA2bhuIj9m6SIpi/ywzjcN595FUjO
	 k2drc6SVXL7i8UG16cGyfpDc9Lh39ZF0gNIZ2VjEdlrh7mvPx3wIZ8c6z07Ozs/2gt
	 pMubg37QrajgabkRLwZdsCeLBhk01x7VY3kNOVEVwOawnfeDk8HsKbgTLB8698U51P
	 vwyw1wIhBumcA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH 6/9] selftests/damon/sysfs.py: stop obsolete_target shells hanging the test
Date: Mon,  2 Nov 2026 07:07:53 -0800
Message-ID: <20261102150757.93058-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102150757.93058-1-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>

The obsolete_target test spawns three 'sh' processes as monitoring
targets.  The processes inherit stdin from the test.  When the test is
run via 'make run_tests' from an interactive terminal, the kselftest
runner executes it under 'timeout', which puts it in a background
process group.  The 'sh' processes then try to read the terminal, so
the kernel sends SIGTTIN to the whole process group.  This stops the
'sh' processes, and also the child the test has just forked to spawn
the next 'sh', before it can run 'sh'.  The test then waits on that
child forever, until the kselftest runner kills it after 45 seconds.
The test passes when run directly.

Fix this by passing stdin=subprocess.PIPE when spawning the processes.
The processes then read from a pipe that never receives input, so they
stay alive and idle as the test expects.

Assisted-by: LLM
Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Tested-by: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261018020415.35567-1-jaeyeon.lee.dev@gmail.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 tools/testing/selftests/damon/sysfs.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 66c826189320d..ce54fa21c09fe 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -390,12 +390,12 @@ def main():
     kdamonds.stop()
 
     # test obsolete_target.
-    proc1 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
-                             stderr=subprocess.PIPE)
-    proc2 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
-                             stderr=subprocess.PIPE)
-    proc3 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
-                             stderr=subprocess.PIPE)
+    proc1 = subprocess.Popen(['sh'], stdin=subprocess.PIPE,
+                             stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    proc2 = subprocess.Popen(['sh'], stdin=subprocess.PIPE,
+                             stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    proc3 = subprocess.Popen(['sh'], stdin=subprocess.PIPE,
+                             stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
                 contexts=[_damon_sysfs.DamonCtx(
-- 
2.47.3
