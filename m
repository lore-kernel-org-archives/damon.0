Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F05185F
	for <damon@lists.linux.dev>; Sat,  4 Jun 2022 19:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1443FC34119;
	Sat,  4 Jun 2022 19:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654370544;
	bh=vFaMYNexMvkxEoJMMWzPxcF6VKtzfvIS98V9Z3mOM2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TjQ9jRzTwaFS/Z5Vyg7f1O3uVhOPawL/Rx/17/KV5IZGaiBDK9B4KThr7/u3PdJOf
	 qcBtz2i4AACYpiK47wDOISvMogy12fUVHoxm2YspSM6MNncUPPAe72z/m3ziB7tQnT
	 D4XbtJLiICqEIhemUXbpsFKaYzqJjdSdwe1d1pxIIqbZofR/QnJoaC9+akyU8S2tx8
	 YOMoUuhNKrIkLjhkNEO685ZZGncBC2AByPGMnHWjq1D0N0y8dYxlmO88MXYzH63LFF
	 M9RfVdSLmqkVxRNxYwmnR5mpfyMyIb7J5+UYZ/B38ON6BWb1Y0pqYctNa+PQ/6gfl8
	 Zc/eV83ECzI6g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: gwhite@kupulau.com,
	Hailong Tu <tuhailong@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	bugzilla-daemon@kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev
Subject: Re: [Bug 216072] New: regression: ccccccgcdkgekhjervgbdfbhdjugcjkfdhiegeuugugtHang at boot when DAMON is enabled
Date: Sat,  4 Jun 2022 19:22:22 +0000
Message-Id: <20220604192222.1488-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604112706.d50208c3c15a748d1c04c584@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc-ing damon@lists.linux.dev

Thank you for reporting this, Greg!  And thank you for forwarding this, Andrew!

On Sat, 4 Jun 2022 11:27:06 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Sat, 04 Jun 2022 15:49:50 +0000 bugzilla-daemon@kernel.org wrote:
> 
> > https://bugzilla.kernel.org/show_bug.cgi?id=216072
> > 
> >             Bug ID: 216072
> >            Summary: regression:
> >                     ccccccgcdkgekhjervgbdfbhdjugcjkfdhiegeuugugtHang at
> >                     boot when DAMON is enabled
> >            Product: Memory Management
> >            Version: 2.5
> >     Kernel Version: 5.19 pre-rc1
> >           Hardware: All
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Other
> >           Assignee: akpm@linux-foundation.org
> >           Reporter: gwhite@kupulau.com
> >         Regression: No
> > 
> > I see a hang on boot whenever DAMON is enabled.  The specific commit that
> > causes this is listed below.  There is no printk / dmesg output, only the
> > message about an initrd being loaded by EFIStup.  Then a hard hang.  Removing
> > the commit below - or disabling DAMON entirely - fixes the issue.
> > 
> > commit 059342d1dd4e01d634184793fa3f8437e62afaa1
> > Author: Hailong Tu <tuhailong@gmail.com>
> > Date:   Fri Apr 29 14:37:00 2022 -0700
> > 
> >     mm/damon/reclaim: fix the timer always stays active
> > 
> >     The timer stays active even if the reclaim mechanism is never enabled.  It
> >     is unnecessary overhead can be completely avoided by using
> >     module_param_cb() for enabled flag.
> > 
> >     Link:
> > https://lkml.kernel.org/r/20220421125910.1052459-1-tuhailong@gmail.com
> >     Signed-off-by: Hailong Tu <tuhailong@gmail.com>
> >     Reviewed-by: SeongJae Park <sj@kernel.org>
> >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Greg has further mentioned that the issue can be reproduced when
the kernel is booting with damon_reclaim.enabled=Y parameter, and I was also
reproducible on my test machine.

DAMON_RECLAIM calls 'schedule_delayed_work()', which uses 'system_wq', from a
parameter store callback ('enabled_store()'), which is called from
'parse_args()', which is again called from 'start_kernel()'.

And 'system_wq' is initialized from 'workqueue_init_early()', which is called
from 'start_kernel()' after 'parse_args()'.

Therefore the 'schedule_delayed_work()' touches the uninitialized 'system_wq',
and the init process gets kernel NULL pointer dereference, and the system
hangs.

I further confirmed below simple change fixes this issue.  I will format it as
a patch and send soon.

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 53c0c084f046..78984c8d1047 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -374,6 +374,8 @@ static void damon_reclaim_timer_fn(struct work_struct *work)
 }
 static DECLARE_DELAYED_WORK(damon_reclaim_timer, damon_reclaim_timer_fn);

+static bool damon_reclaim_initialized;
+
 static int enabled_store(const char *val,
                const struct kernel_param *kp)
 {
@@ -382,6 +384,9 @@ static int enabled_store(const char *val,
        if (rc < 0)
                return rc;

+       if (!damon_reclaim_initialized)
+               return rc;
+
        if (enabled)
                schedule_delayed_work(&damon_reclaim_timer, 0);

@@ -450,6 +455,8 @@ static int __init damon_reclaim_init(void)
        damon_add_target(ctx, target);

        schedule_delayed_work(&damon_reclaim_timer, 0);
+
+       damon_reclaim_initialized = true;
        return 0;
 }



Thanks,
SJ

[...]
