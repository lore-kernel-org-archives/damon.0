Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC1D1E0DD8
	for <damon@lists.linux.dev>; Thu, 16 Apr 2026 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776320907; cv=none; b=fjckbmNLeQ/B29YIlRhKoSTPvd5gSA5tIFf9g6ervF2VquylSQrlauDZ48JbrXb6ILiWF2danwcwmm/vemkmlteYCQ7Qa7TxkLjVgzBkOXJfjboSbL/CCwZsBxLQ89qJGlQgGpbcha4e2cwK1cbDlQGTafTqWIuBxY5Q6RcP028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776320907; c=relaxed/simple;
	bh=I0eXWmVqJC6+YWmn5CD0AkD+KKmkZUikqya5rMLLO/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrHWlU2nWNztSMRNj/KOj3wdkJjCk0vifnahOgLUANFSDW6sUG/UsksuZcTncEHcyjVwf/dlT/DWtiaC5sHeVMZ49UAtYlZZ+qQo3e9giFg76lf4XUIoKjzP4qetFAdUrczsKnwt5gX0fqdJoDO2w0EhYEKF5um1wdmmigCdtYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLe96iLk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLe96iLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D83C2BCAF;
	Thu, 16 Apr 2026 06:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776320907;
	bh=I0eXWmVqJC6+YWmn5CD0AkD+KKmkZUikqya5rMLLO/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLe96iLkBO0GN3NY0SMvGJ8jMkXKlDXjvseWaZJF27ZSwzXKrZxqKhwBLPtAkR1yB
	 /gF/kGb6r2MQ76YN6vLG7qHSOduvYOtL5lsOzGc2SWZMhifWoK2Qm9seyWDxuytIA5
	 PM4fRhqWb+hgJnlYKmaof9FPsKNOhAvYrE95ntqVmOMtrVRW930VvSXdQ5+CMty8qg
	 HOaUkCaYTMCK1KGKGOJR+iT65kcN5x8x+maBNTtDTxOlmMZD8qI80Mo4BhZ2kWZNL4
	 bLYUlyem8KHC8P/y4Gcn26Leu8CW+u8rE+KXN3bvkT3NOHJWMbo7XojR8icb8w8oRa
	 Sv94UpfQpPpEw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] mm/damon: reset thread status parameters upon kdamond termination
Date: Wed, 15 Apr 2026 23:28:17 -0700
Message-ID: <20260416062818.949-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415235529.86329-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Apr 2026 16:55:29 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 16 Apr 2026 02:45:12 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Mon, 13 Apr 2026 17:34:34 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > On Mon, 13 Apr 2026 17:23:03 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > 
> > > > On Tue, 14 Apr 2026 02:52:47 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > > 
> > > > > Problem
> > > > > ========
> > > > 
> > > > Let's align the underline with the subject.  Also, let's add one blank line
> > > > after the underline.
> > > > 
> > > > > When kdamond terminates unexpectedly, 'enabled' remains 'Y' and
> > > > > 'kdamond_pid' remains stale. This prevents user from restarting DAMON
> > > > > because both writing 'Y' and 'N' to 'enabled' will fail.
> > > > > 
> > > > > "Unexpected termination" here means the kdamond exits without any user
> > > > > request (e.g., not by writing 'N' to 'enabled').
> > > > 
> > > > Could you please further explain when such termination can happen?
> > > > 
> > > > > 
> > > > > User Impact
> > > > > ===========
> > > > > Once kdamond terminates this way, it cannot be restarted via sysfs
> > > > > because:
> > > > > 
> > > > > 1. DAMON_LRU_SORT/DAMON_RECLAIM is built into the kernel, so it cannot
> > > > >    be unloaded and reloaded at runtime.
> > > > 
> > > > I think this is quite obvious, so may better to be dropped.
> > > > 
> > > > > 2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
> > > > >    Writing 'Y' does nothing, as 'enabled' is already Y.
> > > > > 
> > > > > As a result, the only way to restore DAMON functionality is a full
> > > > > system reboot.
> > > > 
> > > > Thank you for clarifying the user impact.  I think this deserves Cc-ing
> > > > stable@.
> > > > 
> > > > I think 'Problem' and 'User Impact' can be unified into one section.
> > > > 
> > > > > 
> > > > > Solution
> > > > > ========
> > > > > damon_commit_ctx() sets 'maybe_corrupted=true' at the beginning and only
> > > > > sets it to false upon successful completion. When 'maybe_corrupted'
> > > > > remains true, kdamond will terminate eventually.
> > > > 
> > > > This seems better to be explained earlier, on the problem section.
> > 
> > Okay, this is my current commit message:
> > 
> >     Problem
> >     =======
> > 
> >     When kdamond terminates unexpectedly, 'enabled' remains 'Y' and
> >     'kdamond_pid' remains stale. This prevents user from restarting DAMON
> >     because both writing 'Y' and 'N' to 'enabled' will fail.
> > 
> >     "Unexpected termination" here means the kdamond exits without any user
> >     request (e.g., not by writing 'N' to 'enabled'). This can happen when:
> >     - Internal error of kdamond.
> >     - Invalid parameters commit via 'commit_inputs' (e.g., addr_unit=3).
> > 
> >     The root cause is that damon_commit_ctx() sets 'maybe_corrupted=true' at
> >     the beginning and only sets it to false upon successful completion. When
> >     'maybe_corrupted' remains true, kdamond will terminate eventually.
> > 
> >     Once kdamond terminates this way, it cannot be restarted via sysfs
> >     because writing 'N' to 'enabled' fails (kdamond no longer exists) and
> >     writing 'Y' does nothing ('enabled' is already Y). As a result, the only
> >     way to restore DAMON functionality is a full system reboot.
> > 
> >     Solution
> >     ========
> > 
> >     The problem is that 'enable' parameter value is not trustworthy.
> >     Instead of relying on the 'enabled' variable, use damon_is_running(ctx)
> >     which reflects the true kdamond state.
> 
> I don't want to be picky, but ...  I still feels this is easy to make readers
> including future myslef be confused for some points.  Given this is a bit
> serious bug fix, I feel I have to raise the bar, at least for future myself.
> What about below?
> 
> 	Kdamonds for DAMON_RECLAIM and DAMON_LRU_SORT could stop without
> 	properly updating 'enabled' parameter value, when parameters online
> 	commit fails due to invalid user inputs or internal memory allocation
> 	failures.  The enabled parameter value, which can be stale after
> 	certain kdamond stops, is used by the modules' kdamond start/stop
> 	logic, to avoid doing unnecessary start/stop works.  As a result, uses
> 	cannot restart the kdamonds before the system is rebooted and 'enabled'
> 	parameter value is correctly reset.  For example, the issue can be
> 	reproduced like below:
> 
> 	<your reproducer>
> 
> 	Fix the issue by using damon_is_running(), which should reflect the
> 	true kdamond state, instead of the 'enabled' parameter.
> 
> > 
> > > > [...]
> > > > So the problem is that 'enable' parameter value is not trustworthy, and this
> > > > series is trying to make it trustworthy.  I think it is bit complicated,
> > > > especially for stable@ fix.  What about simply using more trustworthy
> > > > information, e.g.,
> > > > 
> > > > '''
> > > > --- a/mm/damon/reclaim.c
> > > > +++ b/mm/damon/reclaim.c
> > > > @@ -390,7 +390,7 @@ MODULE_PARM_DESC(addr_unit,
> > > >  static int damon_reclaim_enabled_store(const char *val,
> > > >                 const struct kernel_param *kp)
> > > >  {
> > > > -       bool is_enabled = enabled;
> > > > +       bool is_enabled = false;
> > > >         bool enable;
> > > >         int err;
> > > > 
> > > > @@ -398,6 +398,9 @@ static int damon_reclaim_enabled_store(const char *val,
> > > >         if (err)
> > > >                 return err;
> > > > 
> > > > +       if (ctx)
> > > > +               is_enabled = damon_is_running(ctx);
> > > > +
> > > >         if (is_enabled == enable)
> > > >                 return 0;
> > > > 
> > > > '''
> > 
> > Thank you for the suggestion. I have tested this implementation and it
> > works expected. I agree that its complexity is much lower and more
> > suitable for a stable fix.
> 
> Thank you for testing!

Hmm, and now I think we migt be able to use this kind of trustworthy
information for reading part too, for not only enabled but also kdamond_pid,
like below.

'''
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index ecfc6b58d07d2..775b33dbc952f 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -159,15 +159,6 @@ static unsigned long addr_unit __read_mostly = 1;
 static bool skip_anon __read_mostly;
 module_param(skip_anon, bool, 0600);
 
-/*
- * PID of the DAMON thread
- *
- * If DAMON_RECLAIM is enabled, this becomes the PID of the worker thread.
- * Else, -1.
- */
-static int kdamond_pid __read_mostly = -1;
-module_param(kdamond_pid, int, 0400);
-
 static struct damos_stat damon_reclaim_stat;
 DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_reclaim_stat,
 		reclaim_tried_regions, reclaimed_regions, quota_exceeds);
@@ -343,12 +334,8 @@ static int damon_reclaim_turn(bool on)
 {
 	int err;
 
-	if (!on) {
-		err = damon_stop(&ctx, 1);
-		if (!err)
-			kdamond_pid = -1;
-		return err;
-	}
+	if (!on)
+		return damon_stop(&ctx, 1);
 
 	err = damon_reclaim_apply_parameters();
 	if (err)
@@ -357,9 +344,6 @@ static int damon_reclaim_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
-	kdamond_pid = damon_kdamond_pid(ctx);
-	if (kdamond_pid < 0)
-		return kdamond_pid;
 	return damon_call(ctx, &call_control);
 }
 
@@ -387,10 +371,16 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
 MODULE_PARM_DESC(addr_unit,
 	"Scale factor for DAMON_RECLAIM to ops address conversion (default: 1)");
 
+static bool damon_reclaim_enabled(void)
+{
+	if (!ctx)
+		return false;
+	return damon_is_running(ctx);
+}
+
 static int damon_reclaim_enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
-	bool is_enabled = enabled;
 	bool enable;
 	int err;
 
@@ -398,7 +388,7 @@ static int damon_reclaim_enabled_store(const char *val,
 	if (err)
 		return err;
 
-	if (is_enabled == enable)
+	if (damon_reclaim_enabled() == enable)
 		return 0;
 
 	/* Called before init function.  The function will handle this. */
@@ -414,15 +404,48 @@ static int damon_reclaim_enabled_store(const char *val,
 	return err;
 }
 
+static int damon_reclaim_enabled_load(char *buffer,
+		const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%c\n", damon_reclaim_enabled() ? 'Y' : 'N');
+}
+
 static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_reclaim_enabled_store,
-	.get = param_get_bool,
+	.get = damon_reclaim_enabled_load,
 };
 
 module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled,
 	"Enable or disable DAMON_RECLAIM (default: disabled)");
 
+static int damon_reclaim_kdamond_pid_load(char *buffer,
+		const struct kernel_param *kp)
+{
+	int kdamond_pid;
+
+	if (ctx) {
+		kdamond_pid = damon_kdamond_pid(ctx);
+		if (kdamond_pid < 0)
+			kdamond_pid = -1;
+	} else {
+		kdamond_pid = -1;
+	}
+	return sprintf(buffer, "%d\n", kdamond_pid);
+}
+
+static const struct kernel_param_ops kdamond_pid_param_ops = {
+	.get = damon_reclaim_kdamond_pid_load,
+};
+
+/*
+ * PID of the DAMON thread
+ *
+ * If DAMON_RECLAIM is enabled, this becomes the PID of the worker thread.
+ * Else, -1.
+ */
+module_param_cb(kdamond_pid, &kdamond_pid_param_ops, NULL, 0400);
+
 static int __init damon_reclaim_init(void)
 {
 	int err;
'''

This is much bigger change than your original suggestion.  But I feel this is
simpler, because this eliminates the needs to keep the states.  What do you
think?


Thanks,
SJ

> 
> > 
> > > > 
> > > > > 
> > > > > Changes from RFC-v1
> > > > > (https://lore.kernel.org/20260330164347.12772-1-aethernet65535@gmail.com)
> > > > > - Remove RFC tag.
> > > > 
> > > > When dropping RFC tag, let's start from v1 again, from the next time.
> > 
> > Regarding the versioning, I have two questions:
> > 1. Is version number inhritance only required when converting from
> >    non-RFC to an RFC?
> 
> I'd request such conversion when dropping RFC tag.  E.g.,
> 
> RFC -> RFC v2 ... -- (drop RFC) -> v1 -> v2 ...
> 
> > 2. Should my next version be tagged as v3 (since the current one is v2)?
> 
> The ship is already sailed for this patch series.  Please tag it with v3.  But
> please follow the suggestion from next times.
> 
> > 
> > > 
> > > Also, I just found the patches don't have Fixes: and Cc: stable@.  Could you
> > > please add those appripriately?
> > 
> > Regarding the Fixes: tags, I will include the following:
> > - Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
> 
> This seems correct, but ...
> 
> > - Fixes: 059342d1dd4e ("mm/damon/reclaim: fix the timer always stays active")
> 
> Is this correct?  At the point of this commit, there was no commit_inputs
> parameter.  Were you able to confirm this issue can and cannot be reproduced on
> this commit and its parent commit, respectively?
> 
> 
> Thanks,
> SJ
> 
> [...]

Sent using hkml (https://github.com/sjp38/hackermail)
