Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70BA40DFBD;
	Tue, 31 Mar 2026 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915324; cv=none; b=l/PBOwQcMlUra0VzFSBIOFXvYzVN1rXUduZCx8QKcUBiH0fWoEGsuEh2IaAy1FAEzwdwfPlJ/gBuolkjcQ28ICvZDeoH+0w54IOMxhSBObMXphVpUMNMPyr3wSZ58JyetcYIhg29CYTm60SEGnTISc7wtaNA/vMkzaJlw6o7ICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915324; c=relaxed/simple;
	bh=XVAKfu7eLmfU1HifJAIhaEimRjzexU0fRODDV7Mv2Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+9NqSv9eSGY+/PP30lVEFOz2hQNtPvuSbkqsV+dOjsRQTrij9LTs9H9UtiVSWl+HHt2cfvf6lJSH7mHo7u+8hQSX5DDqjXtS/Mz33PPgdZiYiVpX9pGjLNcGVioM5sr6aR+un0bJOR2yjGEJ2CgstA+1ADfYREN29u7EjmSRHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLyY51Zj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLyY51Zj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F017CC4CEF7;
	Tue, 31 Mar 2026 00:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774915323;
	bh=XVAKfu7eLmfU1HifJAIhaEimRjzexU0fRODDV7Mv2Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tLyY51ZjAd+HGv4Qeywe9qZLh2eUWwzqfw9wMkpienVW+me74TVlD8nDEVcazHsRm
	 bmh0cDrpGBkLkSDzswF6+AkftWZT18277IBzBFbPdiEOfSkccUFufjFH58Zui+RDnE
	 aGKQccLDaeFyV7t9oP5YM9HWq+wRsprckZgSV67oe8GEvgUllBe6kbCZdV16+lq+m+
	 DsBvkxbOBV69l3ONaFRqlqi5HXGUvf6JioyfoGbe6fziSoyPaGWzD6tif2xKZ4FGJM
	 vF3KOpBSW7aImNoL0bIvPjBQO4WT8UQVHslvEj/ZTI0u4kWJJJ0xHbyjWBkhYAe0nC
	 w0y5di0OJOIuw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: gutierrez.asier@huawei-partners.com,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: (sashiko review) [PATCH v1 1/1] mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
Date: Mon, 30 Mar 2026 17:01:59 -0700
Message-ID: <20260331000200.4897-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330234337.4456-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+Cc madvise developers (maintainers and reviewers).

On Mon, 30 Mar 2026 16:43:37 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260330145758.2115502-1-gutierrez.asier@huawei-partners.com
> # start of sashiko.dev inline review
> commit cd78854e55ee90102333f0331c58417c16e8d798
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
> 
> This commit introduces the DAMOS_COLLAPSE action to DAMON. It allows DAMON
> to synchronously collapse memory regions into huge pages by leveraging the
> existing MADV_COLLAPSE mechanism.
> 
> Link: https://lore.kernel.org/damon/20260313000816.79933-1-sj@kernel.org/
> 
> [ ... ]
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index b069dbc7e3d2..dd5f2d7027ac 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -903,6 +903,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
> >  	case DAMOS_NOHUGEPAGE:
> >  		madv_action = MADV_NOHUGEPAGE;
> >  		break;
> > +	case DAMOS_COLLAPSE:
> > +		madv_action = MADV_COLLAPSE;
> 
> Could exposing MADV_COLLAPSE to automated continuous execution via DAMOS
> trigger a pre-existing use-after-free in the core madvise logic?
> 
> In madvise_collapse(), the lock_dropped boolean tracks whether the lock is
> currently dropped and tells madvise_walk_vmas() if the lock was ever dropped.
> 
> If collapse_single_pmd() drops the mmap lock, *lock_dropped is set to true.
> On the next loop iteration, madvise_collapse() re-acquires the lock,
> validates the VMA, and resets *lock_dropped = false to avoid double-locking.
> If a subsequent iteration does not drop the lock, the function returns to
> madvise_walk_vmas() with lock_dropped set to false.
> 
> Because madvise_walk_vmas() sees false, it assumes the lock was continuously
> held and the original VMA pointer is still safe. However, another thread
> could have freed the original VMA while the lock was temporarily dropped,
> leading to a use-after-free when madvise_walk_vmas() dereferences
> vma->vm_end.
> 
> While this flaw pre-dates this patch,

It sounds like sashiko is saying the bug still exists and not yet fixed.
madivse() deveopers, could you please confirm if it is true?

> does introducing DAMOS_COLLAPSE expose
> it to continuous background execution by kdamond, making the race condition
> much more likely to occur in practice?

DAMOS_COLLAPSE simply calls do_madvise(), so I think it shouldn't be different
from user space programs calling madvise(MADV_COLLAPSE).  Hence I don't think
this patch is making something worse.

Nonetheless, (if my undertanding of sashiko's argument is not a hallucination
but a real), I agree this change could help the bug triggered more frequently
if DAMOS_COLLAPSE is adopted by more people faster than the bugfix is merged.
If that's the canse and it concerns madvise() developers, I think we can hold
this patch or adjust the scheudles to ensure this patch is merged only after
the MADV_COLLAPSE bug fix.  madvise() developers, please let us know if you
think such hold or schedule adjustment is needed.


Thanks,
SJ

[...]
