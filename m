Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F903597B;
	Wed, 16 Sep 2026 00:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517600; cv=none; b=YjZ3NcTw+ZxtOArJDFjSeMyHnaxL+GhdY64e04ePXwiw8qMqoRVwCclfJboxRZFjth2upnqvWns28marmEkeqfLJxC9z8aaT7qou8IferJGTlr/Zyi5Og0iJkT1AmhviU7zL/vvG2QcPUR1Iu8IJHYHz9RVOe0chdmjyMHE4bd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517600; c=relaxed/simple;
	bh=QQkbmPZa6FzOkJZznNSjvTnbZVVcFugLnbH/fXVmVVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDV+Z+3Xpw2NV+/vXKBvd9uh9WrdVr649l1au8+zrPRZwQMsGfd7lMN6ZSsZBu1mABzoTrI63P7SCtr0vt4q/Jjbk9qUhvC1KcyrD2W/tXmiDHiS+DInaNxT6uiOTvuTmC261rcem1V+tJkq5ZcHbr6fooh4WvS1s4yPyyWSdOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+bv99ac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+bv99ac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A568C1F000FF;
	Wed, 16 Sep 2026 00:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789517598;
	bh=a2lhPSF5A/5CV1Lodrkn/7v4I07Gpj63s01SJKcdomg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m+bv99acZdpFAL97ydOR3AZHyf7sKcsXCrUMb32kvLoj9H9lyg3wioFfBCZ2W9IT/
	 kOGZVQU5b1C6l+x2Aw/1b5u1wFTrfHkcd49xva39auAfyWtmr2HYbWu9ZPYcTnnxUJ
	 ATikHTEWv66JWjpuPGrP/hbtv/jCMQjVJHsVRMHLvLShOrQr1KZqvFg6+Aysx+aodd
	 stz4cOlw/lVwJ9yBnuP5FPiGz7jWbHMh4ECN9qbTPrRN8ZCbtv0WndhiYcuc5Lzw0p
	 7geGvuPbQHEcWuc+R3wksSse8mHGP1OzZM0XBg7ne91VVvsnzYLeDeM5coZqyzKxNO
	 DSSp0Xy0jBE5A==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: score an unmeasured PSI goal as not achieved for the temporal tuner
Date: Tue, 15 Sep 2026 17:13:11 -0700
Message-ID: <20260916001311.101024-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aqm1ZPUHiXf9PFWq@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 23:19:27 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> On Tue, Sep 15, 2026 at 07:50:54AM +0100, SJ Park wrote:
> > 
> > The intention is to make no effect this round.  Setting current_value to zero
> > to temporal tuner means it will now have highest quota it could have.  If the
> > effective quota before this was zero, it gets an effect.
> > 
> > Ideally, we should somehow remember what was the last esz and keep it.  I have
> > no good idea for doing that with minimum change.  This is a corner case in my
> > opinion (correct me if I'm wrong) so I want to keep the change as simple as
> > possible.
> > 
> > If there is not easy way to do that, I think just keeping the behavior but
> > making it explicitly explained might be better.
> > 
> 
> Hello SJ,
> 
> I believe I have a version that addresses your concern without adding
> too much complexity.

Thank you for keep pursuing on improving DAMON, Karl!

> 
> In short, it leaves the tuners as they are and instead keeps
> last_psi_total across a commit of an existing PSI goal, as the code
> did before a68878f83ae6. The U64_MAX round then happens only once per
> new goal.

I actually considered this option when working on commit a68878f83ae6.  I had
two following concerns though.  First, if the user commits multiple times
before the next quota reset interval, the next tuning round will work with
pressure times that cumulated for longer than the quota reset interval.  This
is a quite rare corner case, but I didn't feel that comfortable.  Second, the
behavior for new commit and update commit is different.

So I'd still prefer to just making no effect this round.  And my commit was
failed at doing that, because it didn't aware of temporal tuner.  Maybe we
could show whether the goal was achieved or not, using esz and let the tuner
show same achieveness?  What about something like below?

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3187,6 +3187,25 @@ static inline u64 damos_get_some_mem_psi_total(void)

 #endif /* CONFIG_PSI */

+static void damos_set_psi_current_val(u64 now_psi_total, struct
+               damos_quota_goal *goal, struct damos *s)
+{
+       if (goal->last_psi_total != U64_MAX) {
+               goal->current_value = now_psi_total - goal->last_psi_total;
+               return;
+       }
+       /* Uninitialized last_psi_total; make no effect this round */
+       if (s->quota.goal_tuner == DAMOS_QUOTA_GOAL_TUNER_CONSIST) {
+               goal->current_value = goal->target_value;
+               return;
+       }
+       /* Let temporal tuner show goal achieveness same to the last round */
+       if (!s->quota.esz)
+               goal->current_value = goal->target_value;
+       else
+               goal->current_value = 0;
+}
+
 #ifdef CONFIG_NUMA
 static bool invalid_mem_node(int nid)
 {
@@ -3439,12 +3458,7 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
                break;
        case DAMOS_QUOTA_SOME_MEM_PSI_US:
                now_psi_total = damos_get_some_mem_psi_total();
-               /* uninitialized last_psi_total; make no effect this round */
-               if (goal->last_psi_total == U64_MAX)
-                       goal->current_value = goal->target_value;
-               else
-                       goal->current_value = now_psi_total -
-                               goal->last_psi_total;
+               damos_set_psi_current_val(now_psi_total, goal, s);
                goal->last_psi_total = now_psi_total;
                break;
        case DAMOS_QUOTA_NODE_MEM_USED_BP:
'''

The code could further cleaned and optimized, but hopefully that will give you
my rough idea.

What do you think?


Thanks,
SJ

[...]
