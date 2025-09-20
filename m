Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A862189;
	Sat, 20 Sep 2025 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758364943; cv=none; b=NKQS7CPF/gOc0mq/F1bi0RyWC3X9EsMTevmofZto0QgGxrze1scooUTEhMIN6AZcKBdh4Sosf50a7PIkqVu42oZWbjBV8Q24LdVhf0GweksyGfTZssZML5Su+gFCGf2EmZPfY4NI6QoTZtEbgmT+jPfHWjIO8F4LqJ9QkcNKOz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758364943; c=relaxed/simple;
	bh=9kwVqoLydbm2Rbeubw/EvPFJmKcEfrJda/IiMPaoeEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VB8lx/hbbRLSQHVfBNw8Z9tKydcmHTS8qmdegmyJ7Q4+N3z1pFWBbvS9zzZkwfNantg0nmvil3etGo+JcOGPDPPq8IKs1pVyAQj7MgU58K34yv6zGxn8D7S8oq8W9vTfiJDxt4fd9AgSr9WVvbewCp7aLeV8ptFdYny0qjXGq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O83uxJ3m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O83uxJ3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADA4C4CEEB;
	Sat, 20 Sep 2025 10:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758364942;
	bh=9kwVqoLydbm2Rbeubw/EvPFJmKcEfrJda/IiMPaoeEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O83uxJ3mk3gybuY33XyTcokG0zq83t1iApEr3h2IJvkiY7uOByucy4zzlJZbOeKGm
	 SoTmG7WRl2NLBAUx1XuMQTNWJ6ER/14T70mp2NdHxMkUa9CJTva9MNuwN0hefq25gk
	 zjSwXnjoWRQmUU4/O8Bd4epIB6xdbWmWQcRGRqkcDmC0g13avlzQuCVe+erhgUw7nq
	 mWPzv73cVXnITs0h2IGJohXdmlcOy1BVULuEiFR3vMeBt+BT+td49w2d3WfvBRSr7u
	 IKysXP9BJthGnRlB91Ly/LoEDCmSQzEUxF10SBpWLUUWQk/WcI28PbfKZGV5IoZ7DM
	 1CgRl/5HTyXQQ==
From: SeongJae Park <sj@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	Xinyu Zheng <zhengxinyu6@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zouyipeng@huawei.com
Subject: Re: [BUG REPORT] mm/damon: softlockup when kdamond walk page with cpu hotplug
Date: Sat, 20 Sep 2025 03:42:20 -0700
Message-Id: <20250920104220.1399-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <296c2b3f-6748-158f-b85d-2952165c0588@google.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Sep 2025 20:56:56 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> On Thu, 18 Sep 2025, SeongJae Park wrote:
> 
> > Hello,
> > 
> > On Thu, 18 Sep 2025 03:00:29 +0000 Xinyu Zheng <zhengxinyu6@huawei.com> wrote:
> > 
> > > A softlockup issue was found with stress test:
[...]
> This had me worried for a while: thought we might be needing to change
> lots of other places, and scatter cond_resched()s here and there.
> 
> But no: no need for cond_resched()'s, this is all just a confusion about
> where pmd migration entries are handled: a pmd migration entry is accepted
> by pmd_trans_huge_lock(), but is not accepted by pmd_trans_huge().
> 
> See fs/proc/task_mmu.c for mm_walk examples of trying pmd_trans_huge_lock(),
> then pte_offset_map_lock() if it failed, or ACTION_AGAIN if that failed too.
> 
> When I ACTION_AGAINed damon_mkold_pmd_entry() and damon_young_pmd_entry()
> in 6.5, I didn't realize that the pmd migration entries were reaching the
> pte_offset_map_lock(), with corrupt results (or did pmd_bad() filter them
> out? I didn't think so, but it'll take me too long now to work out whether
> a pmd migration entry counts as pmd_bad or not); but knew that the new
> pte_offset_map_lock() filtered them out safely if there was a race.
> 
> But they've been reaching it without any race, so yes the ACTION_AGAIN
> would send the mm_walk back again and again for as long as the pmd
> migration entry remained there: not good, and Xinyu finds a lockup
> when hotplugging CPU without preemption.

Thank you for your detailed and kind explanation, Hugh!

> 
> My suggested patch below (please take it over SJ, and do with it what
> you will), converting damon_mkold_pmd_entry() and damon_young_pmd_entry()
> to use pmd_trans_huge_lock() as I'd been expecting, so handling the
> pmd migration entry up in that block.  (Side note: patch against 6.17-rc,
> but I see mm.git adds also a damos_va_stat_pmd_entry(), which would
> better be converted to the same pmd_trans_huge_lock() pattern -
> though I notice you're not setting ACTION_AGAIN in that one.)
> 
> But I have to admit, there's very little gained by using ACTION_AGAIN
> in these functions: it helps not to miss the range when racing against
> THP collapse or split, but you're already content to miss the extent
> if it has a pmd migration entry, and there can still be an instant when
> the range which used to have a page table does not yet show the THP.
> 
> So if you prefer a smaller fix (but a larger source file!), just
> dropping the walk->action = ACTION_AGAIN lines should be good enough.

I agree all your points.

I'd prefer the smaller source file following your suggested change below (using
pmd_trans_huge_lock()) in long term.  But, for a short term, I'd prefer the
smaller fix (dropping walk->action = ACTION_AGAIN) since it should also be
merged into stable@, up to 6.5.y.

So, I'd like to suggest as following.  Let's drop the
'walk->action = ACTION_AGAIN' like the below attached one, for now.  After it
is confirmed to fix the issue and merged into relevant trees including stable
trees, let's revisit the code to cleanup following pmd_trans_huge_lock()
pattern.

Please let me know if I'm missing something, or you have other opinions.

Xinyu, could you please test if the below attached patch fixes your issue and
let us know the result?

If Xinyu confirms the validity of the fix and no one objects to the above plan,
I will post the fix as a formal one with a better commit message.


Thanks,
SJ

[...]

==== >8 ====
From 743cafda8982624229541741dbfe5ff252328ac0 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 20 Sep 2025 03:35:34 -0700
Subject: [PATCH] mm/damon/vaddr: do not try page table walk again

For a quick fix of a softlockup issue:
https://lore.kernel.org/20250918030029.2652607-1-zhengxinyu6@huawei.com

Signed-off-by: SeongJae Park <sj@kernel.org>
---
From 743cafda8982624229541741dbfe5ff252328ac0 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 20 Sep 2025 03:35:34 -0700
Subject: [PATCH] mm/damon/vaddr: do not try page table walk again

For a quick fix of a softlockup issue:
https://lore.kernel.org/20250918030029.2652607-1-zhengxinyu6@huawei.com

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 8c048f9b129e..7e834467b2d8 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -328,10 +328,8 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	}
 
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-	if (!pte) {
-		walk->action = ACTION_AGAIN;
+	if (!pte)
 		return 0;
-	}
 	if (!pte_present(ptep_get(pte)))
 		goto out;
 	damon_ptep_mkold(pte, walk->vma, addr);
@@ -481,10 +479,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
 
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-	if (!pte) {
-		walk->action = ACTION_AGAIN;
+	if (!pte)
 		return 0;
-	}
 	ptent = ptep_get(pte);
 	if (!pte_present(ptent))
 		goto out;
-- 
2.39.5

