Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8047C1DFD8B;
	Wed, 31 Dec 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767195150; cv=none; b=WR6sbRdz1ip2C5AJ3OTsTdM3Zuk4YCVPK8tWZOlHelfMsXjZVMrdykOjcqDwEI28SmKdfDFyyfJ5jtvAv57QvogLvTKasF1mQMdy040Vhh5PxzY1V+/++rsPAbC5nMydboX2xkPBFoWps2oKnGRaaqgRFBEOqn1UMinlGVBB7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767195150; c=relaxed/simple;
	bh=wZSt7/UMXpEBgJcZocMzNkrHh9oTHPi1H+DWNxUfbIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNpn2HlQFDaumgnyPi+l32oZPtDU4h+UKwXEe722mxzj9TKd8QUt8YpEh+XOsxNrm9anI/yUSdXvzRaXOTTtTqpJlg9bQ1ZI4AhMz2s12r7xTshOSTmht0H7Aeu3D2rtlYk1rcXA/MHwyfaoKQeebjDhzUxtyF5pkAzBr+Na8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5pdPmm6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5pdPmm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3752C113D0;
	Wed, 31 Dec 2025 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767195150;
	bh=wZSt7/UMXpEBgJcZocMzNkrHh9oTHPi1H+DWNxUfbIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5pdPmm6tf16Z03/jVsx9PPzuhDvh0wSBsMhQqPhXgmWs8F9OXA8R/VATda/W+b+D
	 dt4oXj1tWSYiGZ9V3+1TKSx7DLyI+LatmVKvzOlaWaL826Vqn/+rUWsZiMCEzD9XAd
	 55ao3aCn9ULX+Q+bz7tTPeVx+MSuFapxwsy5rz77WPNoecxlNa0aKE07f1XGKsx8bT
	 dtfZ5S89xPLQbcUS9B1KlVCLXAK/4oZH25VuNJX9XO4VvFDnxHOeVm7rJaeaJ2756f
	 zHOkN2gTJVSAJSBWrvq+0N0wHGgKrLvtELfmAov8AW/ae+ICP1lc9JN/AtYpVp0x3S
	 a7T2MY8uoqZXA==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	wangkefeng.wang@huawei.com,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com
Subject: Re: [RFC PATCH v1] mm: improve call_controls_lock
Date: Wed, 31 Dec 2025 07:32:15 -0800
Message-ID: <20251231153216.82343-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC6ZPyi=tMK9YhcuWPEzdnTje1ADCWzhs7uJCwHh3SMHpg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 31 Dec 2025 15:10:12 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Wed, 31 Dec 2025 at 13:59, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Wed, 31 Dec 2025 11:15:00 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > On Tue, 30 Dec 2025 at 00:23, SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > Hello Asier,
> > > >
> > > >
> > > > Thank you for sending this patch!
> > > >
> > > > On Mon, 29 Dec 2025 14:55:32 +0000 Asier Gutierrez <gutierrez.asier@huawei-partners.com> wrote:
> > > >
> > > > > This is a minor patch set for a call_controls_lock synchronization improvement.
> > > >
> > > > Please break description lines to not exceed 75 characters per line.
> > > >
> > > > >
> > > > > Spinlocks are faster than mutexes, even when the mutex takes the fast
> > > > > path. Hence, this patch replaces the mutex call_controls_lock with a spinlock.
> > > >
> > > > But call_controls_lock is not being used on performance critical part.
> > > > Actually, most of DAMON code is not performance critical.  I really appreciate
> > > > your patch, but I have to say I don't think this change is really needed now.
> > > > Please let me know if I'm missing something.
> > >
> > > Paradoxically, when it comes to locking, spin_lock is better than
> > > mutex_lock
> > > because "most of DAMON code is not performance critical."
> > >
> > > DAMON code only accesses the ctx belonging to kdamond itself. For
> > > example:
> > > kdamond.0 --> ctx.0
> > > kdamond.1 --> ctx.1
> > > kdamond.2 --> ctx.2
> > > kdamond.# --> ctx.#
> > >
> > > There is no cross-approach as shown below:
> > > kdamond.0 --> ctx.1
> > > kdamond.1 --> ctx.2
> > > kdamond.2 --> ctx.0
> > >
> > > Only the data belonging to kdamond needs to be resolved for concurrent access.
> > > most DAMON code needs to lock/unlock briefly when add/del linked
> > > lists,
> > > so spin_lock is effective.
> >
> > I don't disagree this.  Both spinlock and mutex effectively work for DAMON's
> > locking usages.
> >
> > > If you handle it with a mutex, it becomes
> > > more
> > > complicated because the rescheduling occurs as a context switch occurs
> > > inside the kernel.
> >
> > Can you please elaborate what kind of complexities you are saying about?
> > Adding some examples would be nice.
> >
> > > Moreover, since the call_controls_lock that is
> > > currently
> > > being raised as a problem only occurs in two places, the kdamon_call()
> > > loop
> > > and the damon_call() function, it is effective to handle it with a
> > > spin_lock
> > > as shown below.
> > >
> > > @@ -1502,14 +1501,15 @@ int damon_call(struct damon_ctx *ctx, struct
> > > damon_call_control *control)
> > >         control->canceled = false;
> > >         INIT_LIST_HEAD(&control->list);
> > >
> > > -       mutex_lock(&ctx->call_controls_lock);
> > > +       spin_lock(&ctx->call_controls_lock);
> > > +       /* damon_is_running */
> > >         if (ctx->kdamond) {
> > >                 list_add_tail(&control->list, &ctx->call_controls);
> > >         } else {
> > > -               mutex_unlock(&ctx->call_controls_lock);
> > > +               spin_unlock(&ctx->call_controls_lock);
> > >                 return -EINVAL;
> > >         }
> > > -       mutex_unlock(&ctx->call_controls_lock);
> > > +       spin_unlock(&ctx->call_controls_lock);
> > >
> > >         if (control->repeat)
> > >                 return 0;
> >
> > Are you saying the above diff can fix the damon_call() use-after-free bug [1]?
> > Can you please elaborate why you think so?
> >
> > [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
> >
> 
> The above code works fine with spin_lock.  However, when booting the kernel,
> the spin_lock call trace from damon_call() is output as follows:
> If you have any experience with the following, please share it.

Can you please reply to my questions above, first?


Thanks,
SJ

[...]
