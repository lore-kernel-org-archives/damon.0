Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336E530BF7D;
	Wed, 31 Dec 2025 04:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767157191; cv=none; b=RY/lpcTDPtFmqLHpRfeukUm7sQxU1Gk5rJ3VzaESJfXD9zIXYTtsttubR/WFnQrvf1dXwTnVIKXY9k3EbukPbX85JcQVD3h3Tbpm9/Q/4cOFLiQsT3Xtml6md3Y6H7JN8yFivbJFvQCKMcPtehrsThpyqtT4L++85tgoZzqkFwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767157191; c=relaxed/simple;
	bh=1vkr9V/MD64Y0pYrKiO0vgFUHcY2dKFCgeu7wq+aQ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCMyP/liR6/o10RxnhNBOD2H9W4w8pZRoAaNJoOZMdG6pyC83lUORdMfD/jKJU9kZmZ44AqyZiC3nLVzL1kfohVQbBmTnhyLxVxajd11WZ4H0yMBjGpmZf7RPpk1AeGFjyLU/0aXcDZLzvxdvvP/4oGGNpVqERgrwCusLcErnH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orhdW9k5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orhdW9k5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6484DC116B1;
	Wed, 31 Dec 2025 04:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767157190;
	bh=1vkr9V/MD64Y0pYrKiO0vgFUHcY2dKFCgeu7wq+aQ8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orhdW9k52n1qz2Vwl+eS/OF4qd4l+IvUqSRw7W5ioOn+70hj2LbGhwnszGW25Yp8U
	 +0GpQm/8j9cMd/isE+mearVNJTkBerC1vDZIiPaTSsbc3+SLgAurRyLgjazuAR4tEU
	 LyT62GQA4Ke/+q1xInM3Ka2SOPwqcEUpym7xfACWIG+6dIS4yl46J2N1KrYugU+OKI
	 HtjKR8HnpxRzOYboVDxJnBDJywKJpyqfrN3vtvS3EweJsZ2qkhWJRfRupQLEUnv14K
	 FyO/nx1uJqXB42TmrbuaHDoHKu6gDYCAY33sNgjTZsy5y3sDhK6hqlSEppImovdfHd
	 UGvg6sQhSd9VA==
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
Date: Tue, 30 Dec 2025 20:59:46 -0800
Message-ID: <20251231045948.77624-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC4FhpLrknhvWbDd=cxaLUyxHFkFxBDYSC3waeg4FC+TBg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 31 Dec 2025 11:15:00 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Tue, 30 Dec 2025 at 00:23, SeongJae Park <sj@kernel.org> wrote:
> >
> > Hello Asier,
> >
> >
> > Thank you for sending this patch!
> >
> > On Mon, 29 Dec 2025 14:55:32 +0000 Asier Gutierrez <gutierrez.asier@huawei-partners.com> wrote:
> >
> > > This is a minor patch set for a call_controls_lock synchronization improvement.
> >
> > Please break description lines to not exceed 75 characters per line.
> >
> > >
> > > Spinlocks are faster than mutexes, even when the mutex takes the fast
> > > path. Hence, this patch replaces the mutex call_controls_lock with a spinlock.
> >
> > But call_controls_lock is not being used on performance critical part.
> > Actually, most of DAMON code is not performance critical.  I really appreciate
> > your patch, but I have to say I don't think this change is really needed now.
> > Please let me know if I'm missing something.
> 
> Paradoxically, when it comes to locking, spin_lock is better than
> mutex_lock
> because "most of DAMON code is not performance critical."
> 
> DAMON code only accesses the ctx belonging to kdamond itself. For
> example:
> kdamond.0 --> ctx.0
> kdamond.1 --> ctx.1
> kdamond.2 --> ctx.2
> kdamond.# --> ctx.#
> 
> There is no cross-approach as shown below:
> kdamond.0 --> ctx.1
> kdamond.1 --> ctx.2
> kdamond.2 --> ctx.0
> 
> Only the data belonging to kdamond needs to be resolved for concurrent access.
> most DAMON code needs to lock/unlock briefly when add/del linked
> lists,
> so spin_lock is effective.

I don't disagree this.  Both spinlock and mutex effectively work for DAMON's
locking usages.

> If you handle it with a mutex, it becomes
> more
> complicated because the rescheduling occurs as a context switch occurs
> inside the kernel.

Can you please elaborate what kind of complexities you are saying about?
Adding some examples would be nice.

> Moreover, since the call_controls_lock that is
> currently
> being raised as a problem only occurs in two places, the kdamon_call()
> loop
> and the damon_call() function, it is effective to handle it with a
> spin_lock
> as shown below.
> 
> @@ -1502,14 +1501,15 @@ int damon_call(struct damon_ctx *ctx, struct
> damon_call_control *control)
>         control->canceled = false;
>         INIT_LIST_HEAD(&control->list);
> 
> -       mutex_lock(&ctx->call_controls_lock);
> +       spin_lock(&ctx->call_controls_lock);
> +       /* damon_is_running */
>         if (ctx->kdamond) {
>                 list_add_tail(&control->list, &ctx->call_controls);
>         } else {
> -               mutex_unlock(&ctx->call_controls_lock);
> +               spin_unlock(&ctx->call_controls_lock);
>                 return -EINVAL;
>         }
> -       mutex_unlock(&ctx->call_controls_lock);
> +       spin_unlock(&ctx->call_controls_lock);
> 
>         if (control->repeat)
>                 return 0;

Are you saying the above diff can fix the damon_call() use-after-free bug [1]?
Can you please elaborate why you think so?

[1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org


Thanks,
SJ

[...]
