Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46074199230;
	Thu,  1 Jan 2026 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767232836; cv=none; b=MPalxMZM75t2mSrbSvEoSOFhHgySFWxv0fYMX0oeJO++M0DFBBazVjB/KThXzbZlbu68Lr+MVp5wl3Mnn+BNcGQXAJnyYd8QZZQdn/OrD6v/fcJW5lQsb9R1iXDO2OzZEo9h7kIeawx/MyHs4iKNpWLyjcqsTZnvInpL4XM7hDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767232836; c=relaxed/simple;
	bh=SfUd+VIYbA5tyDlhKz1PyHaZjHMxYtaNAXFMWqOAQws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXTv9zFxt7OKXlQ5A1Q1jYubiQa83vxZYt7sW0SuweTzoPhgqHem+7LtzpxMyxBDS5bbfe3f7LL8mxwOP1qh9iWREQPAoj9j01qrxBRqZFYX8hFDcjBgSleX2itI2B322de1DjCoXaHq6zDDfOpcWMmFIS95vc3RnHepMVxxk7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyEuIJMM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyEuIJMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0A4C113D0;
	Thu,  1 Jan 2026 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767232835;
	bh=SfUd+VIYbA5tyDlhKz1PyHaZjHMxYtaNAXFMWqOAQws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyEuIJMM5hM3OgqjM6myvFfoDMfB+64kXLBnhjT6N0VxJijiH5bYzArVhLmcKxOgL
	 UfqyCYpeTqi/EMwNXZgwZd2rfOgWiKSSzFIWWdpWrnK62VmRLCkY3FSexzkEE8mZip
	 qn033Qg7cmiVldfoGKW6cBWV0qCQpmaiJUQ+nDi2Htxvoo3HJ3zKF/VRhlk2cJc9TR
	 uy3yGLrh1iDtpf4zWBJJNIpmSW0pgCOpjiVtVdbJYwUnG2hkzOnICEggYdMVfxHgVs
	 93mT3FhFD0xMBrtJSv22bM0g7aVgnQKWYl//I1I4YgIHShS3YVzssBK4Kmc7hlFXz5
	 n7o0wOj1RE0vQ==
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
Date: Wed, 31 Dec 2025 18:00:27 -0800
Message-ID: <20260101020028.88096-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC6or4a5YM-byNFkB4q8v8YO=ZrT0VymYQfSXEx84wgeZw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 1 Jan 2026 10:11:58 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Thu, 1 Jan 2026 at 00:32, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Wed, 31 Dec 2025 15:10:12 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > On Wed, 31 Dec 2025 at 13:59, SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > On Wed, 31 Dec 2025 11:15:00 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > >
> > > > > On Tue, 30 Dec 2025 at 00:23, SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > > > Hello Asier,
> > > > > >
> > > > > >
> > > > > > Thank you for sending this patch!
> > > > > >
> > > > > > On Mon, 29 Dec 2025 14:55:32 +0000 Asier Gutierrez <gutierrez.asier@huawei-partners.com> wrote:
> > > > > >
> > > > > > > This is a minor patch set for a call_controls_lock synchronization improvement.
> > > > > >
> > > > > > Please break description lines to not exceed 75 characters per line.
> > > > > >
> > > > > > >
> > > > > > > Spinlocks are faster than mutexes, even when the mutex takes the fast
> > > > > > > path. Hence, this patch replaces the mutex call_controls_lock with a spinlock.
> > > > > >
> > > > > > But call_controls_lock is not being used on performance critical part.
> > > > > > Actually, most of DAMON code is not performance critical.  I really appreciate
> > > > > > your patch, but I have to say I don't think this change is really needed now.
> > > > > > Please let me know if I'm missing something.
> > > > >
> > > > > Paradoxically, when it comes to locking, spin_lock is better than
> > > > > mutex_lock
> > > > > because "most of DAMON code is not performance critical."
> > > > >
> > > > > DAMON code only accesses the ctx belonging to kdamond itself. For
> > > > > example:
> > > > > kdamond.0 --> ctx.0
> > > > > kdamond.1 --> ctx.1
> > > > > kdamond.2 --> ctx.2
> > > > > kdamond.# --> ctx.#
> > > > >
> > > > > There is no cross-approach as shown below:
> > > > > kdamond.0 --> ctx.1
> > > > > kdamond.1 --> ctx.2
> > > > > kdamond.2 --> ctx.0
> > > > >
> > > > > Only the data belonging to kdamond needs to be resolved for concurrent access.
> > > > > most DAMON code needs to lock/unlock briefly when add/del linked
> > > > > lists,
> > > > > so spin_lock is effective.
> > > >
> > > > I don't disagree this.  Both spinlock and mutex effectively work for DAMON's
> > > > locking usages.
> > > >
> > > > > If you handle it with a mutex, it becomes
> > > > > more
> > > > > complicated because the rescheduling occurs as a context switch occurs
> > > > > inside the kernel.
> > > >
> > > > Can you please elaborate what kind of complexities you are saying about?
> > > > Adding some examples would be nice.
> > > >
> > > > > Moreover, since the call_controls_lock that is
> > > > > currently
> > > > > being raised as a problem only occurs in two places, the kdamon_call()
> > > > > loop
> > > > > and the damon_call() function, it is effective to handle it with a
> > > > > spin_lock
> > > > > as shown below.
> > > > >
> > > > > @@ -1502,14 +1501,15 @@ int damon_call(struct damon_ctx *ctx, struct
> > > > > damon_call_control *control)
> > > > >         control->canceled = false;
> > > > >         INIT_LIST_HEAD(&control->list);
> > > > >
> > > > > -       mutex_lock(&ctx->call_controls_lock);
> > > > > +       spin_lock(&ctx->call_controls_lock);
> > > > > +       /* damon_is_running */
> > > > >         if (ctx->kdamond) {
> > > > >                 list_add_tail(&control->list, &ctx->call_controls);
> > > > >         } else {
> > > > > -               mutex_unlock(&ctx->call_controls_lock);
> > > > > +               spin_unlock(&ctx->call_controls_lock);
> > > > >                 return -EINVAL;
> > > > >         }
> > > > > -       mutex_unlock(&ctx->call_controls_lock);
> > > > > +       spin_unlock(&ctx->call_controls_lock);
> > > > >
> > > > >         if (control->repeat)
> > > > >                 return 0;
> > > >
> > > > Are you saying the above diff can fix the damon_call() use-after-free bug [1]?
> > > > Can you please elaborate why you think so?
> > > >
> > > > [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
> > > >
> > >
> > > The above code works fine with spin_lock.  However, when booting the kernel,
> > > the spin_lock call trace from damon_call() is output as follows:
> > > If you have any experience with the following, please share it.
> >
> > Can you please reply to my questions above, first?
> 
> I have answered your above question.

Are you saying your reply [1] that posted today?  Unfortunately I was unable to
get all answers to my questions from it, so I asked your more explanation as a
reply to that.

> And, since call_controls_lock has a
> short waiting time, I think it would be a good idea to consider spin_lock.

This sounds like you are only repeating what you told so far, without
additional explanation.  Hopefully the additional explanation can be made on
the thread [1].  Please keep replying there.

[1] https://lore.kernel.org/CAHOvCC65azs4BU2fyP-kxvFWB3ZPCfyZ7KCO8N1sc0jtTENmNw@mail.gmail.com


Thanks,
SJ

[...]
