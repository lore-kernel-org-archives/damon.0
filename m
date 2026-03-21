Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8392C0261;
	Sat, 21 Mar 2026 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774126046; cv=none; b=m25vebtQcfYTyct15UH4l5kw/6c/LJU1crDfoVPTqzdBDtmQEByEgFntXdewiqZWQLxyWK2Lv2evFgrJsmMhJveIkq1X7g2LQkqSSlY4ejoP64mvIu97bbW6Nm6+5zLFOdwFoyT2Q3LuPiYkcFlPA+wmcFGJnAjCb22WbItYryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774126046; c=relaxed/simple;
	bh=RBNX+2Z4AQoEE8CopXAPjDqi8wnLBhXwutOSqIaoAjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKEzZa9tpoApyEfO2KaqzXgxZf2mciYee4Z5PQ0SbPWyWWWEgyagh4FeT9N+8+xMzqNEXVHSbbH5puWHgqIFw7aozemyr2jUY0RchJ+fgY2YwtweuT9almo4yaqBc86lo9gDeC8P3xBa8L/olHxtoFSJO4vq2cfc2IBvAVYGQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKyPy7Jt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKyPy7Jt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F87C19421;
	Sat, 21 Mar 2026 20:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774126046;
	bh=RBNX+2Z4AQoEE8CopXAPjDqi8wnLBhXwutOSqIaoAjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKyPy7JtllSfPx3H6nNERtnh0R2fNDmdVVqCLCAHHRf72hw3dTlCtowh+zpEhaA0o
	 j1A9weHFbXBpEbUrJf7rPSJnBKIj+I4PkrgYm1uKZrBfmoZdZr2JZ+RCU7ZNtk8HC4
	 Xnj0kr3LyklOqw6oA2nZ78XG7TawP3JsL2wbtGeBdgS7e6mHcYI3ExkhXo6zbENnre
	 ZFtLtw+mcHCpwXZOro4zTNYG3dTBcplqaxABXmkhUTirzRSUquPYWrcoDwZXIhW6Hw
	 7Z6lEp+w9raGrebjRIpC2rCh04GfoxXnjllkMipUyj7Kh33MxmG7s/1ylrY4YlxRKH
	 kQZMA9lWs5SRQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko) [PATCH 10/10] selftets/damon/sysfs.py: pause DAMON before dumping status
Date: Sat, 21 Mar 2026 13:47:17 -0700
Message-ID: <20260321204717.98765-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321201250.95873-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: need to add below attaching fixup.  Unless Andrew pick it together with
this, I will post v2 tomorrow.

On Sat, 21 Mar 2026 13:12:49 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260321181343.93971-11-sj@kernel.org
> # start of sashiko.dev inline review
> commit 019bf04e4448bbce4f6d092792a1b959f718f39a
> Author: SeongJae Park <sj@kernel.org>
> 
> selftets/damon/sysfs.py: pause DAMON before dumping status
> 
> This isn't a bug, but there is a typo (selftets) in the subject line.

Good eye!  Unless Andrew fixes this up, I will post v2 with the fix tomorrow.

> 
> This commit updates the DAMON sysfs selftest to pause DAMON execution
> during state dumping. This prevents potential races caused by internal
> DAMON changes, such as the addition or removal of regions, while the
> dump is ongoing.
> 
> > diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> > --- a/tools/testing/selftests/damon/sysfs.py
> > +++ b/tools/testing/selftests/damon/sysfs.py
> > @@ -193,18 +193,53 @@ def assert_ctx_committed(ctx, dump):
> >      assert_true(dump['pause'] == ctx.pause, 'pause', dump)
> >  
> >  def assert_ctxs_committed(kdamonds):
> > +    ctxs_paused_for_dump = []
> > +    # pause for safe state dumping
> > +    for kd in kdamonds.kdamonds:
> > +        for ctx in kd.contexts:
> > +            if ctx.pause is False:
> > +                ctx.pause = True
> > +                ctxs_paused_for_dump.append(ctx)
> > +        if len(ctxs_paused_for_dump) > 0:
> > +            err = kd.commit()
> 
> Since ctxs_paused_for_dump is initialized outside the outer loop, if the
> first kdamond appends a context to this list, won't len(ctxs_paused_for_dump)
> > 0 evaluate to true for all subsequent kdamonds?
> 
> This seems like it would trigger kd.commit() on every subsequent kdamond
> even if none of its contexts were actually modified.

Good eye.  There is no multiple kdamonds use case here, but why not make the
code more complete?  I will fix this, like below.

'''
@@ -201,13 +201,16 @@ def assert_ctx_committed(ctx, dump):

 def assert_ctxs_committed(kdamonds):
     ctxs_paused_for_dump = []
+    kdamonds_paused_for_dump = []
     # pause for safe state dumping
     for kd in kdamonds.kdamonds:
         for ctx in kd.contexts:
             if ctx.pause is False:
                 ctx.pause = True
                 ctxs_paused_for_dump.append(ctx)
-        if len(ctxs_paused_for_dump) > 0:
+                if not kd in kdamonds_paused_for_dump:
+                    kdamonds_paused_for_dump.append(kd)
+        if kd in kdamonds_paused_for_dump:
             err = kd.commit()
             if err is not None:
                 print('pause fail (%s)' % err)
'''

Note that this is not a complete fix.  Similar change will be needed to be made
to later part of this file, too.


> 
> [ ... ]
> 
> > +    # resume contexts paused for safe state dumping
> > +    for kd in kdamonds.kdamonds:
> > +        for ctx in ctxs_paused_for_dump:
> > +            ctx.pause = False
> > +        if len(ctxs_paused_for_dump) > 0:
> > +            err = kd.commit()
> 
> Does this inner loop repeatedly modify contexts across all kdamonds on
> every outer iteration?
> 
> Because ctxs_paused_for_dump is shared across all kdamonds, this appears
> to redundantly modify and commit contexts for every kdamond instance.
> Could ctxs_paused_for_dump be scoped per-kdamond instead to avoid this?

Good eye!  I will fix this like below.

'''
@@ -221,15 +224,14 @@ def assert_ctxs_committed(kdamonds):
         exit(1)

     # resume contexts paused for safe state dumping
-    for kd in kdamonds.kdamonds:
-        for ctx in ctxs_paused_for_dump:
-            ctx.pause = False
-        if len(ctxs_paused_for_dump) > 0:
-            err = kd.commit()
-            if err is not None:
-                print('resume fail (%s)' % err)
-                kdamonds.stop()
-                exit(1)
+    for ctx in ctxs_paused_for_dump:
+        ctx.pause = False
+    if kd in kdamonds_paused_for_dump:
+        err = kd.commit()
+        if err is not None:
+            print('resume fail (%s)' % err)
+            kdamonds.stop()
+            exit(1)

     # restore for comparison
     for ctx in ctxs_paused_for_dump:
'''

> 
> [ ... ]
> 
> > +    # restore for comparison
> > +    for ctx in ctxs_paused_for_dump:
> > +        ctx.pause = True
> 
> Since the context was forced to pause before the status dump, and the
> python object is forced to pause right here before the comparison,
> doesn't this mean the test only ever asserts that True == True?
> 
> It appears this entirely skips verifying whether the originally requested
> unpaused state was successfully committed to the kernel before the dump
> procedure began. Any kernel bug where the pause parameter is stuck as
> True might silently pass this test now.
> 
> Should the original state be verified by reading the specific sysfs file
> before overriding it?

I agree there is the room to improve.  But, there is no good way to test the
feature for making the test safe, at the moment.  We have kunit test for the
pause commit feature, though.  So, I'd not add change for this to this patch.

> 
> [ ... ]
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260321181343.93971-11-sj@kernel.org

So, below attaching fixup is needed for this patch.  Unless Andrew pick it
together with this patch, I will post v2 tomorrow.


Thanks,
SJ

=== >8 ===
From 90acf3dacea715790622c0dd6cf97c6ed97d1105 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 21 Mar 2026 13:43:50 -0700
Subject: [PATCH] selftests/damon/sysfs.py: fixup: avoid unnecessary commit()
 and resume setup

As Sashiko suggested and I agreed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 7a4cd915d5bc9..5f00e97f019f4 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -194,13 +194,16 @@ def assert_ctx_committed(ctx, dump):
 
 def assert_ctxs_committed(kdamonds):
     ctxs_paused_for_dump = []
+    kdamonds_paused_for_dump = []
     # pause for safe state dumping
     for kd in kdamonds.kdamonds:
         for ctx in kd.contexts:
             if ctx.pause is False:
                 ctx.pause = True
                 ctxs_paused_for_dump.append(ctx)
-        if len(ctxs_paused_for_dump) > 0:
+                if not kd in kdamonds_paused_for_dump:
+                    kdamonds_paused_for_dump.append(kd)
+        if kd in kdamonds_paused_for_dump:
             err = kd.commit()
             if err is not None:
                 print('pause fail (%s)' % err)
@@ -214,15 +217,14 @@ def assert_ctxs_committed(kdamonds):
         exit(1)
 
     # resume contexts paused for safe state dumping
-    for kd in kdamonds.kdamonds:
-        for ctx in ctxs_paused_for_dump:
-            ctx.pause = False
-        if len(ctxs_paused_for_dump) > 0:
-            err = kd.commit()
-            if err is not None:
-                print('resume fail (%s)' % err)
-                kdamonds.stop()
-                exit(1)
+    for ctx in ctxs_paused_for_dump:
+        ctx.pause = False
+    if kd in kdamonds_paused_for_dump:
+        err = kd.commit()
+        if err is not None:
+            print('resume fail (%s)' % err)
+            kdamonds.stop()
+            exit(1)
 
     # restore for comparison
     for ctx in ctxs_paused_for_dump:
-- 
2.47.3

