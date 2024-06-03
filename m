Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA01386C5;
	Mon,  3 Jun 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440304; cv=none; b=A5FgcTuLMCGAFcHpRPDjwLsbh1c767iDKX+4Ds+XPn6bUh/bP4soIZXpld3DQIPPQ8LTCjmVlc2Cp7h1S6ONrdWs7oiZBjBwbfhlNoiWE000aLDkGYv95V/udCIGGZYnE1JyOYQCQk0ZVly2kgoSQKoF9kdLUJlKqHVfg7SC7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440304; c=relaxed/simple;
	bh=VGBp8Um3wObQGvuZF4EnQDH/utHRzJD1Fwno53k5PYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q76Kr+kPrszkib3hZrz5xGF+xHfabr6UlyE+JCl5V73hjYMH2D0Mod7FBFin0ffkK3M6bNG+BiAoQdlvnCSv/MgPpKIp8dp9Ui4hR25kjm2D1iJApOI8YytbIXdWfZeJI9819YDYmTU3prihNd9w2Ea2it5w4wu9mYvcpPIpMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qA754UYK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qA754UYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B89BC2BD10;
	Mon,  3 Jun 2024 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717440303;
	bh=VGBp8Um3wObQGvuZF4EnQDH/utHRzJD1Fwno53k5PYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qA754UYKlUnk+Qhx8Pv/DYBWPN0GFGcXOmvQxad+Kcioj30QdOg5LbY+zGbityjJl
	 KuZvqZag+8nvXagwiJBC/sibN/A7QgQ50C194DrOudHh4/B0MvKhZ7poMVDtcbIBQA
	 E6Z4a+KJKq1+neyXoWmZ5MvdrBGwd3SzKjLv66pmoaA+PlacP0ExZGajcqKcQqCr2V
	 Qx0C4INkmubpZubYdWRLl3wX80XD6wZGlPE08tcId2ZI3GVnF/dE/mGdwJTOr9v5rO
	 s1A+yIe5Rjfdeh6kG3kBuoxGTA4tdSYHZTxTa/LH1dXDxJVS3yTvEdk/WQrmYrMW9l
	 CT1hTtvvYRCZA==
From: SeongJae Park <sj@kernel.org>
To: Alex Rusuf <yorha.op@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm/damon/core: implement multi-context support
Date: Mon,  3 Jun 2024 11:45:00 -0700
Message-Id: <20240603184500.104495-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240602194814.929457-1-yorha.op@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  2 Jun 2024 22:48:14 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:

> [...]
> 
> > > 
> > > > 
> > > > >  
> > > > >  /* private: */
> > > > >  	/* for waiting until the execution of the kdamond_fn is started */
> > > > > @@ -634,7 +632,10 @@ struct damon_ctx {
> > > > >  	 * update
> > > > >  	 */
> > > > >  	unsigned long next_ops_update_sis;
> > > > > +	/* upper limit for each monitoring region */
> > > > >  	unsigned long sz_limit;
> > > > > +	/* marker to check if context is valid */
> > > > > +	bool valid;
> > > > 
> > > > What is the validity?
> > > 
> > > This is a "flag" which indicates that the context is "valid" for kdamond
> > > to be able to call ->check_accesses() on it. Because we have many contexts
> > > we need a way to identify which context is valid while iterating over
> > > all of them (please, see kdamond_prepare_access_checks_ctx() function).
> > 
> > It's still not very clear to me.  When it is "valid" or not for kdamond to be
> > able to call ->check_accesses()?  I assume you mean it is valid if the
> > monitoring operations set's ->target_valid() returns zero?
> > 
> > The callback is not for preventing unnecessary ->check_accesses(), but for
> > knowing if continuing the monitoring makes sense or not.  For example, the
> > callback of 'vaddr' operation set checks if the virtual address space still
> > exists (whether the target process is still running)  Calling
> > ->check_accesses() for ->target_valid() returned non-zero target is totally ok,
> > though it is meaningless.  And therefore kdamond stops if it returns non-zero.
> > 
> > > 
> > > Maybe name should be changed,
> > 
> > At least some more detailed comment would be appreciated, imo.
> > 
> > > but now I don't see a way how we could merge
> > > this into kdamond_valid_ctx() or so, because the main cause of this "valid"
> > > bit is that there's no more "valid" targets for this context, but also we could
> > > have ->after_sampling() returned something bad.
> > 
> > As mentioned above, calling ->check_accesses() or others towards invalidated
> > targets (e.g., terminated processes's virtual address spaces) should be ok, if
> > any of the targets are still valid.  So I don't show special technical
> > difficulties here.  Please let me know if I'm missing something.
> 
> This is true in case of only 1 context. kdamond can be stopped if there's
> no valid targets for this context (e.g. no address space exists anymore),
> but when there are many contexts we need to check if any of contexts has
> valid target(s). For example, we have 3 contexts per kdamond, at some
> point of time we have 1st context having no valid targets (process has been
> finished), but other 2 contexts do have valid targets, so we don't need
> to call ->prepare_access_checks() and ->check_accesses() as well for 1st
> context, but we do need to call them for other contexts.

Yes, we don't need to.  Nonetheless, calling ->prepare_access_checks() is also
not a big problem, right?  If I'm not wrong, I don't want to add more
complexity for unclear benefit.  In other words, I think simply letting a
kdamond continues access monitoring for virtual address space targets even
after the processes are terminated while there are other contexts that need to
continue access monitoring is ok, unless it has clear and significant problem.

> 
> We can call ->kdamond_valid_ctx() before calling ->check_accesses(),
> but then we also need to check if nothing bad has been returned from
> ->after_sampling() call, so that we're allowed to further call
> ->check_accesses().
> 
> I decided to use a "valid" flag inside damon_ctx structure, so
> that if this context isn't valid, we will just skip it while
> iterating over all contexts.

If this is really needed, why don't you simply call ->target_valid() for each
target for whenever we need to know if the target is valid?


Thanks,
SJ

[...]
