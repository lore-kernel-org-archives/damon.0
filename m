Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBE72417D9;
	Tue, 19 May 2026 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154080; cv=none; b=WZepUURmh8Vt6/YKlzAiM14BlASA4We0BReSrCk2uuAXOKS4WDN+Bu1XVfMr9GQrhHIqVMtlIiI/upUnn1J8rXGmUTyGPObfTCz+Z4+yoZuhHAuwNdSs9S8uYcmflQmCoAAVi5ZKInJO5MWc5FpfLW4v6q2IUT4I11qTbMlF3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154080; c=relaxed/simple;
	bh=DjXNCz7wjkPFz2WXiAKd8+VZo5X/xiI3NVF+wDWE2s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpnfj5qFmX/wtXICv7FXCkvp1c3Ayh2FxWDM9Ra4chjWEsKgv4jDz1dRWAANXwjvTqdxwAWnCDx3njUeDjEEvpYVkF0nIihlliUeTeIDQt1yOqAoXuB2TH+HTqjg622dkrnShxFXlV4elIWrgqwr6nMq1ywGQzIoRgNu3NOA8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9HtO594; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9HtO594"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B273CC2BD05;
	Tue, 19 May 2026 01:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779154080;
	bh=DjXNCz7wjkPFz2WXiAKd8+VZo5X/xiI3NVF+wDWE2s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m9HtO594Zbm3HLKn9aIlj+5m+ubOP15FeC9sHw6SxJZQKm9yr70dhyJUTPgJqllOB
	 s0Cf/hIqoPRQ5JzUNxly+jkmbaM9FFV1W3It0w0BVqAeyWvomKHflfuMmO8OcbwIcR
	 wMM4yevotJSHREc5k0fpb0g3L69qAFXY/E8q5BE2XmFWDeYaQ/mUa9aGblCtbp4PnK
	 IJuhS+vGUh3T95sXpT6Hmskqw36v3qinWorYh1mBT9Na3/f7UDEtB/5iByd6oWTchn
	 e1mK0WtwJTjKvX2CBfWYevBx+ypsrRaL9iUf4D9rSGBM+9EbLYZORoS+9kyiuBRXK8
	 y8HqZUM2VuBVg==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH 5/5] mm/damon/paddr: add time budget to migration page walk
Date: Mon, 18 May 2026 18:27:50 -0700
Message-ID: <20260519012752.100188-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y17XTzjAK5ZyKAKZLN1cAE-+c+2DgqpmuHGWgjUAZMgkFg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 17 May 2026 22:54:18 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Sun, May 17, 2026 at 4:43 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Sat, 16 May 2026 14:03:57 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> >
> > > On populated physical address ranges the pageblock skip optimization
> > > alone is insufficient — most pageblocks contain at least one allocated
> > > page, so the walk still iterates millions of PFNs.
> >
> > So my questions to the fourth patch of this series are also applied here,
> > especially about the assumption of systems having most memory free.  I will
> > hold digging deep here until the high level discussion is completed.
> >
> Hello SJ,
> 
> Stepping back to look at this with fresh eyes, I think this
> patch is in the same bucket as patches 1 and 3 (full background
> on the patch 3 thread): it came out of the same parallel debug
> effort, where I was seeing long walks during the startup
> transient on a multi-hundred-GB monitored target -- before
> kdamond_split_regions() and damon_apply_min_nr_regions() had
> trimmed the initial regions down -- and was unsure whether
> those long walks were contributing to the NMI-side
> responsiveness issues I was chasing.
> 
> Once the actual NMI problem was fixed and the per-region work
> in steady state is bounded by DAMON's region splitting (and by
> the scheme's quota when one is set), the per-call cost in
> damon_pa_migrate() is already small enough that the budget
> isn't doing useful work.  cond_resched() after damon_migrate_pages()
> covers the preemption case.
> 
> If a real workload later shows a per-region walk long
> enough to matter, I'll re-evaluate then with concrete numbers.

Sounds good!

FYI, many parts of DAMON are designed assuming it will be used on production
environments that have long-running workload and prefer stability.  It helps
making good results in long run, but also make it difficult to understand it in
short term, especially on lab environments.

I learned that by grateful users including you, and therefore recently
developed the multiple quota tuning logics and failed regions charge ratio.  I
feel like such DAMON limitation has contributed to this case to confuse you.
Sorry if that was the case, and please feel free to share your pain points and
improvement ideas.  Every user's use case including yours does matter!


Thanks,
SJ

[...]
