Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D6D244661;
	Tue, 17 Mar 2026 04:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773722077; cv=none; b=o1Anq7SPE/SGWrZjv44QLoW/Uw+vDq+86liKZDE6GjMovan5y7RbEB6VyOlzmqLfTkN5gy4p8A7zeMad2D7bNGNoFeNqTKp8V+oJnkie5Blrnjj/vdK10Kp7jo/ph6BVapw8zgvFe3Ed5IvbwjqTMrCMJBjAtnGnKc4vJKRH7HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773722077; c=relaxed/simple;
	bh=0/0VFLYKi+mk4PVpGHBEzM2TEEJ2Vb1grQB/KFxONgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2FXcyLbeOdw46mV0pv1RpDQy3jPoOeGVk2t77M7JmhHKnVTK2GC0VEze77Gq+tCdA10pz1OJeT81/5knfvpf8lYynA+2kJ0GvZnuKsXG7ao4srNCqL4nBcbkKSCrQQHZF9sre8JkTAaZVyZrIcMrm8ais224yYX0T9wR6mZ1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na+iKJmX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na+iKJmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9E5C4CEF7;
	Tue, 17 Mar 2026 04:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773722076;
	bh=0/0VFLYKi+mk4PVpGHBEzM2TEEJ2Vb1grQB/KFxONgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=na+iKJmXbh0gkpBBkASt2VVz4NPNOAYTNe5xFQuv+bfr57NqS2qN+EWjUgYG8bKJd
	 D+86JTxRGDLvR19RtV6VyfEXf7bhrUXfywiyOkSy+E+acOEkk32T4r2x0AbXJDmOs/
	 rffpgkrUnASX6V2RDvFBhs/EVrD1a4a6P7RdL51Z/fOq3q/IE6FbtnQ+qF8/urXAs8
	 9nZ65ha6IFkbY8Q7seCJn7rNud/NKIvnKcHU62ht2KBGqm9M3PlTnFWcJcuFyvzgh2
	 2DJI0fpg8vj3dZNCnY/0eMVn5Kk9mnNoL7eaEYnui4ET/sSGpkIgRPlJGpYS3mLxGj
	 FJ8JotwxdKV0g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 10/10] selftets/damon/sysfs.py: pause DAMON before dumping status
Date: Mon, 16 Mar 2026 21:34:28 -0700
Message-ID: <20260317043429.1057-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315210012.94846-11-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 15 Mar 2026 14:00:09 -0700 SeongJae Park <sj@kernel.org> wrote:

> The sysfs.py test commits DAMON parameters, dump the internal DAMON
> state, and show if the parameters are committed as expected using the
> dumped state.  While the dumping is ongoing, DAMON is alive.  It can
> make internal changes including addition and removal of regions.  It can
> therefore make a race that can result in false test results.  Pause
> DAMON execution during the state dumping to avoid such races.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  tools/testing/selftests/damon/sysfs.py | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> index e6d34ba05893f..a1a29f1a7c27b 100755
> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
> @@ -193,18 +193,44 @@ def assert_ctx_committed(ctx, dump):
>      assert_true(dump['pause'] == ctx.pause, 'pause', dump)
>  
>  def assert_ctxs_committed(kdamonds):
> +    paused_for_dump = False
> +    if kdamonds.kdamonds[0].contexts[0].pause is False:
> +        kdamonds.kdamonds[0].contexts[0].pause = True

Quoting sashiko.dev comments [1] with ': ' prefix below.

: Does this code only pause the first context? The validation loop below
: iterates over all contexts in the kdamond, so if there are multiple
: contexts, will the others remain unpaused and vulnerable to the race
: condition during the state dump?

There is no real caller of this function that uses multiple contexts.  So there
is no real problem.  That said, I think this code will be better to take care
of such case that might happen in the future.

I will therefore add below change to the next version of this patch.

'''
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -196,15 +196,17 @@ def assert_ctx_committed(ctx, dump):
     assert_true(dump['pause'] == ctx.pause, 'pause', dump)

 def assert_ctxs_committed(kdamonds):
-    paused_for_dump = False
-    if kdamonds.kdamonds[0].contexts[0].pause is False:
-        kdamonds.kdamonds[0].contexts[0].pause = True
-        err = kdamonds.kdamonds[0].commit()
-        if err is not None:
-            print('pause fail (%s)' % err)
-            kdamonds.stop()
-            exit(1)
-        paused_for_dump = True
+    ctxs_paused_for_dump = []
+    for kd in kdamonds.kdamonds:
+        for ctx in kd.contexts:
+            if ctx.pause is False:
+                ctx.pause = True
+                err = kd.commit()
+                if err is not None:
+                    print('pause fail (%s)' % err)
+                    kdamonds.stop()
+                    exit(1)
+                ctxs_paused_for_dump.append(ctx)

     status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
     if err is not None:
@@ -212,17 +214,17 @@ def assert_ctxs_committed(kdamonds):
         kdamonds.stop()
         exit(1)

-    if paused_for_dump:
-        # resume
-        kdamonds.kdamonds[0].contexts[0].pause = False
-        err = kdamonds.kdamonds[0].commit()
-        if err is not None:
-            print('resume fail (%s)' % err)
-            kdamonds.stop()
-            exit(1)
-
-        # restore for comparison
-        kdamonds.kdamonds[0].contexts[0].pause = True
+    for kd in kdamonds.kdamonds:
+        for ctx in kd.contexts:
+            if ctx in ctxs_paused_for_dump:
+                ctx.pause = False
+                err = kd.commit()
+                if err is not None:
+                    print('resume fail (%s)' % err)
+                    kdamonds.stop()
+                    exit(1)
+                # restore for comparison
+                ctx.pause = True

     ctxs = kdamonds.kdamonds[0].contexts
     dump = status['contexts']
@@ -230,9 +232,11 @@ def assert_ctxs_committed(kdamonds):
     for idx, ctx in enumerate(ctxs):
         assert_ctx_committed(ctx, dump[idx])

-    if paused_for_dump:
-        # restore for the caller
-        kdamonds.kdamonds[0].contexts[0].pause = False
+    # restore for the caller
+    for kd in kdamonds.kdamonds:
+        for ctx in kd.contexts:
+            if ctx in ctxs_paused_for_dump:
+                ctx.pause = False

 def main():
     global kdamonds
'''

> +        err = kdamonds.kdamonds[0].commit()

: Does calling commit() here inadvertently mask test failures by forcing the
: entire Python object state to the kernel right before reading the status?
: 
: For example, if a test marks a target obsolete, commits it, and deletes
: the target from the Python list to verify if the kernel autonomously
: removed it, this commit() would explicitly push the target's deletion to
: the kernel, potentially bypassing the test's purpose.

No.  Callers that could have such problem should call this function after
pausing the context on their own.  That's what the target obsolete test case is
doing.

[1] https://sashiko.dev/#/patchset/20260315210012.94846-11-sj@kernel.org


Thanks,
SJ

[...]
