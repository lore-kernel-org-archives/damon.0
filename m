Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51D14036E;
	Fri, 17 May 2024 22:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715986765; cv=none; b=CA/7N1gcCZm8/BUgpvz1K7gk/sz0Ciyrj6bkU9OkYsOvp6xZx7bYsQ0YcNvWE6sYdH9iHR8giQuvx9ufMCXJc3GiRMVKlEpYhCse7wc8SfmS+NcFSRNLiFvHwdn4EsqoxN82cKGU3Q2XpcIySG9o+0xt+3I3FW0IoEHQ7oScCVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715986765; c=relaxed/simple;
	bh=i/lf2TVxejq4yug3FFuoGpl/sEmPNn8np1eVzk7EMx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d2XIa5Jl6o6RXbTeAYI7PUBBS4fbQalvr8tro4CPAL7n5J1SQsftvE9s3HUOHGC2TKKVDx6rdGerTj6vOUkV5OKLb8KeOpbOIYHoF4GD+h9KfzGT4Fqao6DdIKCB6a7Mfog7+jZ4tyEcjLgYAeser9zAtwu1G9dIE1e7G9L3sMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfdxB9f5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfdxB9f5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34440C2BD10;
	Fri, 17 May 2024 22:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715986764;
	bh=i/lf2TVxejq4yug3FFuoGpl/sEmPNn8np1eVzk7EMx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VfdxB9f5UkPBi+DVIpPNNx1wh81JGtsYu2nbc/+ACQtcMligzURaYIG5SvChMswLe
	 Cf2HHR5Dy4FS/SH+1ft1ngHqNSSsgsQlLr2mTwD0CKuQ04ua+/0bs0qwemDBVceAng
	 GiWKCUqXL4HG/ojnBJ3y+AU0va9YxScuBtZn/OmjnNphbm9x9dCK8Xc8GhnsdnzqKs
	 t49qjD71YJMe/17NEuRmVPyYKkKFlCMbCa8eo0xT4qXRnzynXxXJPKo4KfRnVHVg9x
	 OutgHRJ20LyAbf0Yoj+BQOokoFf9qqGo6CG1SPv0tXZyKtumbqcCe4UI78wPac32ae
	 o7oGKOjVJmv9g==
From: SeongJae Park <sj@kernel.org>
To: Alex Rusuf <yorha.op@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/7] DAMON multiple contexts support
Date: Fri, 17 May 2024 15:59:21 -0700
Message-Id: <20240517225921.128477-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517085151.630844-1-yorha.op@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 17 May 2024 11:51:51 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:

> Hi SJ
> 
> > Hello Alex,
> > 
> > 
> > Adding high level comments first.  I will try to read each patch and add
> > detailed comments to those as soon as I get some time.
> > 
> > Also, please Cc linux-mm@ for DAMON patches.  I'd also recommend cc-ing
> > linux-kernel@.
> 
> Thank you for clarification, I'll add them!
> 
> > 
> > On Wed, 15 May 2024 18:24:50 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:
> > > Currently kdamond uses only one context per kthread
> > > and most of its time it sleeps, so utilizing several
> > > contexts can scale kdamond and allow it to use
> > > another set of operations.
[...]
> > > 	[3] https://github.com/onlyoneofme/damon-multi-contexts-tests.git
> > 
> > Do you have a plan to integrate this into DAMON selftests or damon-tests?
> 
> Not in the form they are for time being. These are just simple shell scripts
> that set up kdamond to use multiple contexts and these scripts only
> collect information like DAMO (but only as perf.data).
> 
> Anyway, I think we can integrate them with damon-tests with some modifications
> to be able to actually _test_ if multiple contexts work.
> 
> As for DAMON selftests, I didn't touch them for time being, so they truly
> need to be modified and expanded, but before doing that I would like
> you to look at implementation first, because changes in implementation
> could affect selftests, so once we agree on that I will implement selftests.
> 
> Also note, that I didn't integrate changes with debugfs. I remember this is
> deprecated interface, but I'm not sure if compatibility need to be preseved
> with it, so do we need to expand debugfs for this?

I think we should keep debugfs work as was.  So I think we should ensure it's
not broken, but don't need to expand it to support this new feature.

> 
> > 
> > > Alex Rusuf (7):
> > >   mm/damon/core: kdamond_struct abstraction layer
> > 
> > Let's make the subjects clear what it does.  For example, this patch's
> > subject could be "add kdamonds_struct abstraction layer".  Similar comment
> > for other patches.  Also, I think '_struct' suffix of 'kdamond_struct' is
> > not really needed.  Let's remove it if there is no special reason to add
> > it.
> 
> Sure, I'll change that in next version, thanks!
> 
> > 
> > >   mm/damon/core: list-based contexts organization
> > 
> > I think this can be squashed into the first patch?  If not, could you please
> > let clarify?
> 
> I just tried to separate those patches for them to be as simple as
> possible (actually I failed at that...), but sure, we can squash them.
> 
> > 
> > >   mm/damon/lru_sort: kdamond_struct abstraction layer
> > >   mm/damon/reclaim: kdamon_struct abstraction layer
> > 
> > Does these two patches mean lru_sort and reclaim are broken by the first
> > patch? Let's keep everything unbroken in middle of the patchset, to help
> > bisect.
> 
> Yes, they're broken by the first patch, I'll squash them, thanks!
> 
> > >   mm/damon/core: rename nr_running_ctxs -> nr_running_kdamonds
> > 
> > I think this would also better to be together with the first patch?  I know
> > this does not break something, but makes reading patch bit complex.
> 
> No problem, thanks!
> 
> > 
> > >   mm/damon/core: multi-context support
> > >   mm/damon/core: multi-context awarness for trace events
> > 
> > I think these two patches should be squashed into one patch.  Otherwise, the
> > trace point is broken in the middle of the patch series, right?
> 
> You're right, I'll squash them, thanks!

Cool, I'm looking forward to the next version of this great patchset!


Thanks,
SJ

[...]
