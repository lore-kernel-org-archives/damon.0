Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B74274B39;
	Wed,  2 Sep 2026 00:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308182; cv=none; b=AYRXeoes3l9zEQSp4080gPhIukjyimrDzHdW0lPSd7jzPYpUU/4LRnchpl3FTaYiHrVUTLyd8SPJJT9Ll5iCZYHi2358ebWrAzr8XofCMVSynK/XWQpo7fjCjcY77NubygmYisfUwvicEWe7xyj/PXbxXuGvo904P+k/JbN55Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308182; c=relaxed/simple;
	bh=tudMRj/TnfuJljnPM3xRnDACA5o7/NpkdUDiW9X7lgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bL+2QZhOxiCozlj1uqLrzsQ1PjQWzPTk/ZOKbgmkvBMya2UMfn5BQSsYJXzpxSXw0dt6BnFDTq1wnYbyhwNuWypUrStPifq/sWh6JT8SmRLIm7jaWlKDZ6GKrMdijvi/OXnZjPOS5aMndgOvre9fbC8D+QBxcwV7Dr3C15TUBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc+Ax/jZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc+Ax/jZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C3F1F000E9;
	Wed,  2 Sep 2026 00:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788308179;
	bh=OEjxeO79o4Ud75N6A9+NJyFbf3L9Zkn9+XJuWOGF7QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pc+Ax/jZ1ieQp/xsoeg17BqRC4BVaZJW84zbu27ePugyNmeFZqHKm6UQEAUDvrSn1
	 S+tcaHGDW2c7FbIT5snJKz8hR77BFFZMe29di0HS/431XrSXbvVwRRq2A/W4gZ3G/t
	 ba5BEHIpE+quFK5HU12YBN59UoCwppdNeaXMQsdOodQq3sdfXT2w9VNXkn8GVw34Yu
	 MjJexwlAlFAE3a4BbFSGjKFI4/X6gn98Ne7A/m6IQZbz3R/i3FjB31QrD4noVXrUQl
	 Xbt9MP5+0Xpan5/gqs4xEoZwPz+WPlMt5ZzQsSBEzSJqhJ0nOV+jlbZsXkt2a37A16
	 1yqzhzq7vGygg==
From: SJ Park <sj@kernel.org>
To: Nathan Gao <zcgao@amazon.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v2] mm/damon/vaddr: use a page-aligned address for the sampling walks
Date: Tue,  1 Sep 2026 17:16:06 -0700
Message-ID: <20260902001607.107382-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901202556.39515-1-zcgao@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 1 Sep 2026 13:25:36 -0700 Nathan Gao <zcgao@amazon.com> wrote:

> On Mon, 31 Aug 2026 18:35:50 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Mon, 31 Aug 2026 15:11:51 -0700 Nathan Gao <zcgao@amazon.com> wrote:
[...]
> > > 
> > > Otherwise the page is writable, the PTE_AF clearing succeeds silently
> > > and the damage only surfaces later, in whatever happened to own the
> > > page, so the backtrace is unrelated to DAMON and differs between runs.
> > 
> > Urgh, this must have been a painful debugging.  Sorry about that, and
> > appreciate your great work on this!
> > 
> 
> No problem at all!  Had fun digging into this. 

Thank you for that kind ack!

> 
> > > 
> > > Align the address down to a page boundary in damon_va_mkold() and
> > > damon_va_young(), the two users that pass it into a page table walk. It
> > > is the address of the page to sample, so this matches its intended
> > > meaning. r->sampling_addr itself is left as is, so the sampling and
> > > region bookkeeping semantics are unchanged.
> > 
> > I'm still wondering if it makes sense to restore unaligned address support in
> > contpte_test_and_clear_young_ptes() as a long term fix.
> > 
> 
> I'd appreciate Baolin's thoughts here.  If it turns out callers are
> expected to do the alignment, it would be better to have a WARN to expose
> the issue.

I agree.  If we conclude contpte helpers are not the right place to warn, we
should do that at least in DAMON internal helpers.

[...]
> > > --- a/mm/damon/vaddr.c
> > > +++ b/mm/damon/vaddr.c
> > > @@ -349,6 +349,9 @@ static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
> > >  		.hugetlb_entry = damon_mkold_hugetlb_entry,
> > >  	};
> > >  
> > > +	/* Arch helpers can derive a page range from @addr; align it down. */
> > > +	addr = PAGE_ALIGN_DOWN(addr);
> > > +
> > >  	damon_va_walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
> > 
> > Could we do the alignment just before passing the addr to
> > contpte_test_and_clear_young_ptes(), which is the exact function that disallows
> > the unaligned address?
> > 
> 
> Sent a v3.  It moves the alignment into damon_ptep_mkold(), the only place
> in DAMON that reaches contpte_test_and_clear_young_ptes(), so it is as
> close to that function as DAMON can get:
> 
> https://lore.kernel.org/all/20260901201001.33271-1-zcgao@amazon.com/

Thank you, I left comments.  Please forgive me being picky there.


Thanks,
SJ

[...]
