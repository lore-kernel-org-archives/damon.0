Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66CA4C9D
	for <damon@lists.linux.dev>; Fri,  5 Sep 2025 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757044455; cv=none; b=sgHht3K7JFv2zXi5JLn8fR7YTvasxindwYizb2ZP1FQAhVVkE+N+hngvddzVgr1AB1aj1DT4th0Etaj5ifC8TU0BU4zsL5R2BdNVRJ3EulyLBWyp8NwOE0UpFRo0CyPVqCetDg0t33EwgnQVyU4qrvD/euWU23A4acRY8nN49R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757044455; c=relaxed/simple;
	bh=LNaRwze4TGZtIcBUvw/S6FFHyQBjsdlnMKYv5Fi0Sw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TX2NxC8iYDf/q09MhAGBLpoVJL5YCGOD28uvAs+QAJr3ctCqFGAxxJD0zZ2WaKB2+KlRTSCdKCIveLtmv467Wk7k0+K/7AqUqoU7i0fBubBvj8u0libe/LiljFyryHM10sCjML9BoXeTOnqXVJL7oDCSw8lIJzs81Nq74uPUWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxA4Po0b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxA4Po0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176F1C4CEF1;
	Fri,  5 Sep 2025 03:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757044454;
	bh=LNaRwze4TGZtIcBUvw/S6FFHyQBjsdlnMKYv5Fi0Sw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxA4Po0b2PfmrqenbbKRpg7hz2n+oSxW+A/NJgpjcdl83c6PZWEFcGaxXdPnvY4kJ
	 0YOlYTnlAhWn4pdiTrQTEXnMWPPzeskjXVFCFvHDrWzVAHbhjX2MTK8PN/CCCHcBjt
	 iL+KBA6de4lkNk/GFZw3pUqSx9Ry6TIytXcrkW2DHYGQgJphHRBFj9oxgmommWizmW
	 tep5FLzDTclok5q6LraC1HyPqAzBFCjFcoKOH6Xg09IvURdQqO5ucoGjVUCeJVV/z9
	 jmrDv1w3B6JrlBXxXqKpwMsFfXSbpmw9HFKVwRmgCu7Qf3iss9uzZejSJTqnGLHy8Q
	 cZfum3QLmMg7Q==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	honggyu.kim@sk.com,
	kernel_team@skhynix.com
Subject: Re: [BUG] 'damo stop' causes kernel crash in v6.17-rc3
Date: Thu,  4 Sep 2025 20:54:11 -0700
Message-Id: <20250905035411.39501-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904082946.949-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  4 Sep 2025 17:29:45 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> On Wed,  3 Sep 2025 21:02:03 -0700 SeongJae Park <sj@kernel.org> wrote:
> > Hi Yunjeong,
> > 
> > On Thu,  4 Sep 2025 10:17:38 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> > 
> > > Hi!
> > > 
> > > I encountered a kernel crash when running 'damo stop' in kernel v6.17-rc3, 
> > > I tested and confirmed that this issue also occurs in v6.17-rc1.
[...]
> > I found commit d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file
> > internal work") is the first bad commit, according to 'git bisect'.  And
> > actually the code is broken for multiple kdamonds case, since it is sharing one
> > damon_call_control object for multiple kdamonds while overwriting the data
> > field to later-called one.

More problematically, the damon_call_control->list is continuously overwritten
by the multiple kdamond threads.  This corrupts the damon_call_control lists of
the contexts, and as a result kdamond_call() infinitely loops.  Hence
kdamond_fn() cannot catch the termination request and the hang happens.

> >
> > I haven't yet deep dive into by what code path the issue happens, but sharing
> > this first, since I have to go out soon.  I'll further take a look later.
> > Meanwhile, could you please also confirm if it is the first bad commit for your
> > issue, too?
> 
> Thanks for sharing your analysis!
> I also confirmed that first bad commit is d809a7c64ba8.
> The previous commit b907494768e5 doesn't cause the above issue.

Thank you for confirming.  I confirmed attaching patch fixes the problem with
your repro on my setup.  Could you please also test that on your machines and
confirm if it fixes the issues on your setups, too?  If you confirm, I will
post it soon.

[...]
> > 'scripts/decode_stacktrace.sh' can show which line of what source file each of
> > the above line points.  So if you could share the output of the script from
> > your next bug reports, it would be pretty helpful.
> 
> I'm not aware of this tool, thank you for letting me know!
> I'll trying using it next time.

No worry, and let me know if you need any help for that.

And please don't delay or hesitate reporting new issues in future for learning
of a tool.  I'd prefer getting early and incomplete issue reports much more
than late and complete reports. :)


Thanks,
SJ

[...]

=== >8 ===
From 6754cdb95c03313fd7d9f104b9dbe851ecef237e Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Thu, 4 Sep 2025 20:18:46 -0700
Subject: [PATCH] mm/damon/sysfs: use dynamically allocated repeat mode
 damon_call_control

For testing.

Fixes: d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file internal work") # v6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       |  8 ++++++--
 mm/damon/sysfs.c      | 23 +++++++++++++++--------
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ec8716292c09..aa7381be388c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -636,6 +636,7 @@ struct damon_operations {
  * @data:		Data that will be passed to @fn.
  * @repeat:		Repeat invocations.
  * @return_code:	Return code from @fn invocation.
+ * @dealloc_on_cancel:	De-allocate when canceled.
  *
  * Control damon_call(), which requests specific kdamond to invoke a given
  * function.  Refer to damon_call() for more details.
@@ -645,6 +646,7 @@ struct damon_call_control {
 	void *data;
 	bool repeat;
 	int return_code;
+	bool dealloc_on_cancel;
 /* private: internal use only */
 	/* informs if the kdamond finished handling of the request */
 	struct completion completion;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7aeb3f24aae8..be5942435d78 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2510,10 +2510,14 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 		mutex_lock(&ctx->call_controls_lock);
 		list_del(&control->list);
 		mutex_unlock(&ctx->call_controls_lock);
-		if (!control->repeat)
+		if (!control->repeat) {
 			complete(&control->completion);
-		else
+		} else if (control->canceled && control->dealloc_on_cancel) {
+			kfree(control);
+			continue;
+		} else {
 			list_add(&control->list, &repeat_controls);
+		}
 	}
 	control = list_first_entry_or_null(&repeat_controls,
 			struct damon_call_control, list);
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0ed404c89f80..a182670493bb 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1565,14 +1565,10 @@ static int damon_sysfs_repeat_call_fn(void *data)
 	return 0;
 }
 
-static struct damon_call_control damon_sysfs_repeat_call_control = {
-	.fn = damon_sysfs_repeat_call_fn,
-	.repeat = true,
-};
-
 static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 {
 	struct damon_ctx *ctx;
+	struct damon_call_control *repeat_call_control;
 	int err;
 
 	if (damon_sysfs_kdamond_running(kdamond))
@@ -1585,18 +1581,29 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 		damon_destroy_ctx(kdamond->damon_ctx);
 	kdamond->damon_ctx = NULL;
 
+	repeat_call_control = kmalloc(sizeof(*repeat_call_control),
+			GFP_KERNEL);
+	if (!repeat_call_control)
+		return -ENOMEM;
+
 	ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
-	if (IS_ERR(ctx))
+	if (IS_ERR(ctx)) {
+		kfree(repeat_call_control);
 		return PTR_ERR(ctx);
+	}
 	err = damon_start(&ctx, 1, false);
 	if (err) {
+		kfree(repeat_call_control);
 		damon_destroy_ctx(ctx);
 		return err;
 	}
 	kdamond->damon_ctx = ctx;
 
-	damon_sysfs_repeat_call_control.data = kdamond;
-	damon_call(ctx, &damon_sysfs_repeat_call_control);
+	repeat_call_control->fn = damon_sysfs_repeat_call_fn;
+	repeat_call_control->data = kdamond;
+	repeat_call_control->repeat = true;
+	repeat_call_control->dealloc_on_cancel = true;
+	damon_call(ctx, repeat_call_control);
 	return err;
 }
 
-- 
2.39.5

