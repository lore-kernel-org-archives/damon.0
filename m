Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF5D19995B
	for <damon@lists.linux.dev>; Mon,  2 Dec 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160097; cv=none; b=pN2uLLjRgxNWof82G9axbJtGSu9lMcn3hkzoEI2LAJp6WoPbvf7fL8olO/JIQF0Uf5xjcfL2VigiKLgcptBGag+KaZa9+bRbqBjnji0jgzReRlZ5gxmnsBCNTj9cSstBMfEH6Hq2+0ZsxdsREkOnGxe5CtdD/eL9RmJOWMC/THI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160097; c=relaxed/simple;
	bh=sf0xa51zsqkhyyLzEDM2GQZEbF53/1q1kn0kNkE8rps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXOb44LoPmjVVvlWcFFY1ghs6TAtZogKwODCr5rkyMWXSRv5AhoogCGcuYTqbor1cXYQR7PQTFnJ4dlThtHH4Quhi3aZCbSwPBL5+TGdXFX7YPhsxVYCFyBUvaU50gxl68nMnxw1eYDbWY8WWpF82AzYWSk2c9QkI8VUTRLIVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlkiQ3by; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlkiQ3by"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C159AC4CED1;
	Mon,  2 Dec 2024 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160096;
	bh=sf0xa51zsqkhyyLzEDM2GQZEbF53/1q1kn0kNkE8rps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rlkiQ3bybufYrzeYCIZX2CywSpI736tK1TmxBJihLASVwfjJJ3gYtg0AKOBZZEhrg
	 Nb6BsPwDQIdUi6QmNA7KjJg7vap6tPD9CHiA0BfZCAYRY+svyKZTdm1cAFLM0ZYVPP
	 dBZ6k2+bSGiBtb/f5osW1sHF298paShS7ssYFfU947gjsqTFmS9aaW+cYc92DswvJv
	 zLhVtA6+pnVmlgfCoL00UxiEYvLEImGPSVQL/WFTy/YqP647PjP5+GoFvA89Ab2H2o
	 L7Efui12NVbcl4rYGtXJm/XQiG368mfX4taznFkq9NZAMQxJuMNoiUFPz9F+TTxAgF
	 J4Vb/7wa1aRrQ==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel_team@skhynix.com,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH] mm/damon/core: accumulate applied size to quota->charged_sz
Date: Mon,  2 Dec 2024 09:21:34 -0800
Message-ID: <20241202172135.1999157-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202122409.82-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2 Dec 2024 21:24:05 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> Thanks for the feedback.  Please see my comments below.
> 
> On Fri, 29 Nov 2024 11:55:29 -0800 SeongJae Park <sj@kernel.org> wrote:
> > On Fri, 29 Nov 2024 17:31:01 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > 
> > > While testing DAMOS_MIGRATE_COLD action, Yunjeong found that the
> > > quota->charged_sz is way less than actually migrated size.
> > 
> > You mean "more", not "less", right?
> 
> Correct.  I wrote it opposite.  quota->charged_sz is highly accumulated
> even if zero pages are affected by the migrate_cold action.
> 
> > And, is it a problem for your use case?  Could you please share more details?
> 
> I think this is for general use cases.  I thought this is logically
> quite straightforward but I will see if I can provide more details if
> you need.

Even if this is for general use cases, providing a concrete example would be
always nice.  Especially for this kind of behavioral changes, I'd like to have
the details.

> 
> > > 
> > > In damos_apply_scheme(), quota->charged_sz is used when checking whether
> > > the quota exceeds the effective size.  The current implementation
> > > accumulates the charged_sz with sz(region size), but many pages in the
> > > region might be discarded by DAMOS filters.
> > > 
> > > In order to make the quota calculation more accurate, charged_sz is
> > > better to be accumulated by the actually applied size, which is
> > > sz_applied in the code.
> > 
> > This is an intended behavior.  Quota is for making a limit of resource
> > consumption from DAMOS.
> 
> Sure. We know about the purpose of quota.
> 
> > Trying a DAMOS action consumes some of the system
> > resource even if it was eventually filtered out or failed, so we charge those.
> 
> I would like to have more discussion on this.  Although trying a DAMOS
> action consumes some resouce but it seems to be much smaller compared to
> applying actions. (especially in migrate actions)
> 
> You might think it takes some resource, but it is more close to the concept
> of time quota.  We just compare the size with esz when making decision
> of quota usage so I'm not quite sure if we really have to accumulate
> the size of discarded pages.

I agree failing a DAMOS action would be lighter.  But, it's still not zero.
Depending on use case, I think that could be somewhat cannot be ignored.  For
example, if a huge amount of memory is filtered-out by page-granular DAMOS
filters (e.g., young), the overhead would be more than what we want to ignore.

> 
> > We can consider changes of the behaior depending on problems and use cases, but
> > it is unclear to me.  Could you please elaborate, as I requested above?
> 
> It might take some time to prepare for the backup data but I just share
> what I have thought about it.

This is a behavioral change.  I'd like to make such change only if the theory
is very clear, or there is a real problem.

> 
> Roughly speaking, we found that quota->charged_sz increases 90 MiB for
> each interval in our test, but we saw no migration happened when
> applying the migrate_cold action.
> 
> Let's say that there is a region of 90 MiB and that consists of 23040
> pages.  If there are 10 MiB of pages at the end of the region, but the
> initial pages are not candidates because of filter setup.  In this case,
> the current implementation may consume the most of charged_sz at the
> beginning so it discards the last 10 MiB of pages that we are
> interested because quota->charged_sz + sz is already greater than
> quota->esz although no actions applied.

I'm not very sure if I'm understanding your concern well.  Are you saying DAMOS
will _never_ apply the action to the 10 MiB region?

DAMOS resets the age of a region after applying an action[1], regardless of the
failure.  Hence in this example, yes, DAMOS may not apply the action to the 10
MiB region immediately, due to the quota.  But in the next interval or aftr,
DAMOS will eventually apply the action to the region.

Or, are you saying DAMOS action will not _immediately_ be applied to the 10 MiB
region, and the slow speed is your concern?

On a level of time scales of real workloads, I think that's not a big problem.
If that's causing a real problem, users could also adjust the quota online on
their own.

Of course I might underestimating something, and I will be happy to be
enlightened.  Real data and use cases would be very helpful for that.

> 
> My explanation is not good enough, but hope this can be helpful.

It is very helpful, thank you :)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/mm/damon/design.rst?h=v6.13-rc1#n354


Thanks,
SJ

[...]
