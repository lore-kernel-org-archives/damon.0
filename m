Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCE143DEAF;
	Fri, 11 Sep 2026 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133561; cv=none; b=ABqGMLUfetR3fIj955MxXo4RaHXalfSYeaIInYZqh02m91Nsqq0r+umQ2blVs7CKy/HFy8HnKl0DvTSGvjEbdQO+JInwFBfcsyxyZEmmq0Oe1vqmC57ylSCe5CqAcMy9CGZuHm46eJ5l+wwJpLHKAJTnKHCH878IlbPXrMOBLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133561; c=relaxed/simple;
	bh=P2UzBLdehlA6O/poEAEdNe6+6BAr0NDnBI8UFPn6Hps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7uewd7bh0ZbJsr60YUPNFcax449kO7OEqiGMYENeW5+OrvcmDghb4hxO4t5lDk+vrh2Tf/Z/f6K0icvSAIkM4s/2nE59QqUajOKz+PkH/xUq7g1HfW3/MD1Phngc2nleXtTnBPAyv6hzq3RfrOL8GgmBsj+ZMm7IqXqNnihAwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fi7eT0Tk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi7eT0Tk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0081F000FF;
	Fri, 11 Sep 2026 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789133559;
	bh=N4cjZyg9TwtoYS0w3Uy/aHxv7zEHGwy0d+Cmi9Q21fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fi7eT0TkQmppnxyAyCkikpwfZbm5O2/Wc0O4B/TIREOKCFn/Xltpt7fQgsfD4/4th
	 b07wACychsuviIbE+qwjxQzwfu82D10HimieReg+VHnUeWDv8pg/+tE1MufglZgstR
	 IkczmtJVwza2MIbD/Y2A4YEKuL2Egssl1RiQg631laq+B4WCzXVMAxreGnpMTv5gFN
	 KLyJjtkRU7MzlZckZtXiW2yRE/JAqIp49p2qniT//EAyY/T2ts5R+sQC994QdQFOhr
	 mYoQrBZCHa6x5nTW3tb6K3RXLkC5LXD6EoiWwhPC/Zi+/CUR3rQ1UvFOmcPED3v7DV
	 xnQHvcY+e2pZA==
From: SJ Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH REPOST 5/5] mm/damon/vaddr: support pgidle_unset probe filter type
Date: Fri, 11 Sep 2026 06:32:31 -0700
Message-ID: <20260911133232.91581-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911100427.2804601-1-kunwu.chan@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kunwu,

On Fri, 11 Sep 2026 18:04:26 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:

> On Wed,  9 Sep 2026 07:04:07 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > DAMON virtual address space operation set (vaddr) does not support
> > pgidle_unset probe filter type.  Add the support.
> > 
> > Signed-off-by: SJ Park <sj@kernel.org>
> > ---
> >  mm/damon/vaddr.c | 55 ++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 48 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 45239f05e113b..9a38dc89a156e 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -522,13 +522,49 @@ static void damon_va_prep_probes(struct damon_ctx *ctx, bool set_samples)
> >  	}
> >  }
> >  
> > -static bool damon_va_filter_pass(struct folio *folio, struct damon_probe *p)
> > +static bool damon_va_young_addr(struct folio *folio, pte_t *pte, pmd_t *pmd,
> > +		struct mm_struct *mm, unsigned long addr)
> > +{
> > +	bool young = false;
> > +
> > +	if (pte)
> > +		young = pte_young(*pte);
> > +	else if (pmd)
> > +		young = pmd_young(*pmd);
> 
> Hi SJ,
> I see that all callers already check pte_present() / pmd_present()
> before calling this helper, so I don't see a correctness issue here.
> 
> However, the other DAMON young/accessed helpers, such as
> damon_pte_young(), damon_hugetlb_young(), and the PMD path in
> damon_folio_young_one(), keep the present check together with the
> young check.
> 
> Would it make sense to keep the same check here for consistency?

In my humble opinion, it is already consistent as long as we didn't miss
present check in callers.  If you concern a case that we call
damon_va_young_addr() without present check in future, how about adding a
comment noting that on damon_va_young_addr() as a followup work?

Also, thank you for your reviews to this series!


Thanks,
SJ

[...]
