Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8BC8FB;
	Sun,  2 Jun 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717347111; cv=none; b=W7fXTumNslFJGWHWqWabmSS7jeyTRvgQOpKHkWvzYmVj/13ejZzoruqNxU5h8fi0q6F7rDHMuJk/hc60edAh9hXcU4Mqua2mYaMSUxJAAEPwN0mBAq1BSiIICHBzLFf7f6Gx4OE6kNkDKnS+oPDgdzUpUHQ9j+np/PwLKyWaDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717347111; c=relaxed/simple;
	bh=KELyIxp7C1ZSE4EnYb9KTlzQqzR9hlMFEMS1zC3RQxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jsE6yaR3g9ps/a9wOGTyHpnBMR/U2Rg7xw4LI/yD3aGrVP99LMmNm6Bjk8r4n/ka5vSW5zH7WpM57TIsK65Ldnl5+4J5HbdP4q5IWK3UYmrljLZoBYD3S3RzaBcHJCu8KpDmyAJYYOA8Yy9Ae36qWnEKaRmxWPAx3XsZuSnlv2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1gDEQCl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1gDEQCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9393CC2BBFC;
	Sun,  2 Jun 2024 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717347111;
	bh=KELyIxp7C1ZSE4EnYb9KTlzQqzR9hlMFEMS1zC3RQxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J1gDEQClGBBLQL3FBD1Ih4eMbaU0SRJ2Nxtj92djkUjE1Dm0yHTIFW7w8Lr4UnlHF
	 o1oPw8oNwTHAeDr6FM6fuhDiX+BaTwYA40XnaJttl81TPoLD6hAVQS++Ya/I/MJd0I
	 3OzWKg9GJIxSjO/WF5vuX6imlEdZWF+a9OqQV88M0OlDW4RUblrjF136+3+RiEBeMM
	 5b+0MKxXpkLSur0C6sLiUeKdRXZ2vPU3oYyfSnN9/yaHyAY74Mml/TXsX39ZKUsugs
	 6TT4j4WgEowExdBf7UBjkW5bCFiA3h2+mRrJ59icvisKqEGyfn3k2pZaquZeme8vzw
	 bH8VbCH7aLF7A==
From: SeongJae Park <sj@kernel.org>
To: Alex Rusuf <yorha.op@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: add 'struct kdamond' abstraction layer
Date: Sun,  2 Jun 2024 09:51:48 -0700
Message-Id: <20240602165148.92368-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240602161557.927788-1-yorha.op@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  2 Jun 2024 19:15:57 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:

> Hi SJ,
> 
> > Hi Alex,
> > 
> > On Fri, 31 May 2024 15:23:19 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:
> > 
> > > In current implementation kdamond tracks only 1
> > > context, that is kdamond _is_ damon_ctx what makes
> > > it very difficult to implement multiple contexts.
> > > 
> > > This patch adds another level of abstraction, that is
> > > 'struct kdamond' - structure which represents kdamond itself.
> > > It holds references to all contexts organized in list.
> > > 
> > > Few fields like ->kdamond_started and ->kdamond_lock
> > > (just ->lock for 'struct kdamond') also has been moved
> > > to 'struct kdamond', because they have nothing to do
> > > with the context itself, but with the whole kdamond
> > > daemon.
> > > 
> > > Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
> > > ---
> > >  include/linux/damon.h     |  73 ++++++++---
> > >  mm/damon/core.c           | 249 ++++++++++++++++++++++-------------
> > >  mm/damon/lru_sort.c       |  31 +++--
> > >  mm/damon/modules-common.c |  36 +++--
> > >  mm/damon/modules-common.h |   3 +-
> > >  mm/damon/reclaim.c        |  30 +++--
> > >  mm/damon/sysfs.c          | 268 ++++++++++++++++++++++++--------------
> > >  7 files changed, 463 insertions(+), 227 deletions(-)
> > >
[...]
> > > +/**
> > > + * damon_kdamond_running() - Return true if kdamond is running
> > > + * false otherwise.
> > > + */
> > > +bool damon_kdamond_running(struct kdamond *kdamond)
> > > +{
> > > +	bool running;
> > > +
> > > +	mutex_lock(&kdamond->lock);
> > > +	running = kdamond->self != NULL;
> > > +	mutex_unlock(&kdamond->lock);
> > > +	return running;
> > >  }
> > 
> > Seems this function is used by only DAMON sysfs interface.  Don't implement
> > unnecessary public function.  Implement it in mm/damon/sysfs.c please.
> 
> DebugFS interface also uses this.

I think dbgfs.c is using damon_nr_running_ctxs() now?  De-duplicating code is
nice, but I think that can be done in a separate patch.  Moreover, DAMON
debugfs interface is deprecated now.  I'd like to keep changes to the file as
minimum as possible.

[...]
> > > +static inline struct damon_ctx *damon_lru_sort_ctx(void)
> > > +{
> > > +	return damon_first_ctx(kdamond);
> > > +}
> > > +
> > > +static inline struct damon_target *damon_lru_sort_target(void)
> > > +{
> > > +	return damon_first_target(
> > > +			damon_lru_sort_ctx());
> > > +}
> > 
> > Do we really need above two functions?  Can't we simply add 'kdamond' global
> > variable but still uses 'ctx' and 'target' as before, except interface changed
> > function calls?
> 
> We can, I just tried to use 'readable' interface, I thought
> that using raw pointers from kdamond will be less readable.

I agree this will eventually be better code.  But let's do such things in
separte patches.  Keeping individual patch simple and small would help poor
reviewers :)

[...]
> > > @@ -1065,15 +1055,15 @@ static struct damon_sysfs_cmd_request damon_sysfs_cmd_request;
> > >  static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
> > >  		char *buf)
> > >  {
> > > -	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
> > > +	struct damon_sysfs_kdamond *sys_kdamond = container_of(kobj,
> > >  			struct damon_sysfs_kdamond, kobj);
> > 
> > This makes reviewing bit difficult.  Let's keep current name for now.
> > 
> > > -	struct damon_ctx *ctx = kdamond->damon_ctx;
> > > +	struct kdamond *kdamond = sys_kdamond->kdamond;
> > 
> > Keep 'kdamond' variable name as is, and use shorter name for this variable,
> > say, kd, or do kdamond->kdamond.
> 
> It usually makes reading code difficult, these are two different abstraction of
> kdamond, but the name will almost be the same, I don't think this is a good idea.
> 
> > 
> > >  	bool running;
> > >  
> > > -	if (!ctx)
> > > +	if (!kdamond)
> > 
> > "if (!kd)" or "if (!kdamond->kdamond)"
> 
> And this is an example, I can't say which one belong to sysfs's abstraction
> and which represents core's kdamond. With "sys_" prefix or "sysfs_" sometimes,
> it is much easier to read.

I agree that.  But from my perspective, these name changes are not essential
for the purpose of this patch but only make review time consuming.  Do one
thing with minimum change, please.  You could do the code cleanup in other
patches.

[...]
> > 
> > >From this point, I think below changes could be significantly changed in next
> > version of this patchset if you agree to above comments.  So I'm stop reviewing
> > this patch from here for now.  Please let me know if you have different opinion
> > about it.
> 
> Thank you very much for your comments, I really appreciate that you spent time to
> review this. I'll try to improve the patch-set in next versions!

No problem, and looking forward to the next version!


Thanks,
SJ

[...]
