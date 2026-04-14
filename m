Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D073D561
	for <damon@lists.linux.dev>; Tue, 14 Apr 2026 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126542; cv=none; b=OVmeZseEP3HA9KIkm39cLjOB0mYpWwmAAzFOBlpmml9ajWWiu7egFYRkRwX4ysmEBYuND/oxZ06BJcQhCWUgOAVLRZ+npdZLYP31cNlA97pyYTTnyHx41fBSsWCH/TrSZ1Wa7IBOKxlR7i7ViITfryEYvh93cE+nifj87OdRxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126542; c=relaxed/simple;
	bh=KJQ8DjNdIK1+MWNYUBk1EM61NlNb9p1GDy6iEy4DTG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMaYfFa12w2Ry6/RuPzIxtfh8yebvCNpergDZXhno7ooHiBASpZIPNJ44s4bCAwy5TRzclqBHC6Db3m9FawmciJ8tf6oq1JFIh+qfk8n6kLbsClDIzbQmlbL9USbbN3AzLB4Ju7cYy1DdLieSrYQgzSPhqSO3LOBfR9VzDfcJUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+yYJ3OE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+yYJ3OE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8C1C2BCB4;
	Tue, 14 Apr 2026 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126541;
	bh=KJQ8DjNdIK1+MWNYUBk1EM61NlNb9p1GDy6iEy4DTG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+yYJ3OEIxNXhrBnBljLxL3lE5OcCdPspgAAE9SMqP3A/xLorXJ7KyTjH++vqAfsG
	 rShEU7EVM7LUBmJzJJbkGDwl0Kkpme/WZzFEfhAOXig2/odpfSwTbhB3CK2yFeJk4g
	 Nz1S2fMXNjSqekVil7TTxHbf17Q9BMi397+VCIFvFa7eQSl2Bh8RD2kzqdMCXjHAjo
	 +pAO44PwNXq2yLntTUZ23teL2fWuodJ5iHFHp79s99bo65JpXq6oDWkZk7RNCeQGyt
	 ooDwxNJuYMxe5TxGEZOZyRvw0DhNmIvulKTyWwKg4v9s//bL7zvp62a9RYhhNzy7Qo
	 DUu1Lco4mktaQ==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] mm/damon: reset thread status parameters upon kdamond termination
Date: Mon, 13 Apr 2026 17:28:53 -0700
Message-ID: <20260414002854.83483-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260413220511.30677-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Apr 2026 06:05:11 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> I've reviewed the Sashiko report on [PATCH v2 1/2] and [2/2]. Since the
> issues are essentially the same, I want to reply to them all in one
> email.
[...]
> # PATCH v2 2/2
> > > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > > index 86da147786583..e3e148fd80f97 100644
> > > --- a/mm/damon/reclaim.c
> > > +++ b/mm/damon/reclaim.c
> > [ ... ]
> > > @@ -250,6 +250,10 @@ static int damon_reclaim_apply_parameters(void)
> > >  	if (err)
> > >  		goto out;
> > >  	err = damon_commit_ctx(ctx, param_ctx);
> > > +	if (err) {
> > > +		enabled = false;
> > > +		kdamond_pid = -1;
> > > +	}
> > >  out:
> > >  	damon_destroy_ctx(param_ctx);
> > >  	return err;
> > 
> > Can prematurely resetting enabled to false here introduce a race condition
> > leading to a use-after-free of the DAMON context structures?
> > 
> > If damon_reclaim_apply_parameters() is invoked from the kdamond worker thread
> > (for example, when applying commit_inputs) and damon_commit_ctx() fails,
> > ctx->maybe_corrupted is set to true. This signals the kdamond thread to
> > break its main loop and begin its teardown phase, such as executing
> > damon_destroy_targets() to free lists.
> > 
> > Because enabled is set to false asynchronously here, a concurrent sysfs write
> > of 'Y' to enabled will succeed and immediately trigger
> > damon_reclaim_turn(true). This unconditionally calls
> > damon_reclaim_apply_parameters() and executes damon_commit_ctx() from the
> > sysfs thread.
> > 
> > Since damon_commit_ctx() locklessly mutates and frees items in
> > ctx->adaptive_targets and ctx->schemes, would this race directly with the
> > still-exiting kdamond thread traversing and freeing those exact same lists,
> > resulting in list corruption and a use-after-free?
> 
> The core issue is - modifying 'enabled' and 'kdamond_pid' in the error
> path of damon_commit_ctx() is racy.

We simply made such racy user behaviors be prohibited [1].  So this should be
fine.  But, I'd prefer simpler fix, as I replied to the cover letter.

> 
> My plan for v3:
> - Remove the reset code in damon_*_apply_parameters()
> - Keep only the fix in damon_*_turn(false)
> 
> This resolves the restart issue without introducing new races.
> Please let me know if this direction looks good.
> 
> Small changes for v3:
> - Delete a "=" at the bottom of "Problem" (commit message):
> 
>       Problem
> -     ========
> +     =======
> 

I also added comments about above as a reply to the cover letter.  Please reply
there.

[1] https://lkml.kernel.org/r/20260329153052.46657-2-sj@kernel.org


Thanks,
SJ

[...]
