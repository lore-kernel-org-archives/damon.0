Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E033A242D62;
	Thu,  1 Jan 2026 00:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767228771; cv=none; b=cnHNoG6+mzwpSK/HFa3jk+XOMapZsuE+N+PFcVbuiU0sZ3AxN29ixcJ/Co+Nas2cf1HgpI1gojEqi1IKLyJUUSZyOA9ZK313dj1yqlcbBYHuXopOOM8wB8P8V4/VBCQTfTNKVkX4JYWzqFtV0eWmi6Sn9BRoGO2PlAG9izHqQx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767228771; c=relaxed/simple;
	bh=uRFI9tQrnCYxWpT5BJj60ROQreng33NJj7TDugKTC0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnEYh3F6bQOmPGtwSoAcy8gFP84oJymlgTuBk5KNz+KaEaEIs7BZdNUam7j4eFZs+HMynfYZrGkzsXgQRiUZ/4QVyklo6DXxb0Nhsdk1Ro5HWx8cG0XGH2B2NT0/AUPDObugHYSXnmnHg7CuwRNMcWgj/7fQrLjn5o/3RadcFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmdLyjeK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmdLyjeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8D0C113D0;
	Thu,  1 Jan 2026 00:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767228770;
	bh=uRFI9tQrnCYxWpT5BJj60ROQreng33NJj7TDugKTC0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmdLyjeKJE+Dr8YmzkZuoR+GC8w82koPUFL5eXmgfMdc3wHxYZiW38fhI7YmuVPPa
	 KTub+t33ztfKcTpasShLRy2yJeg/55WB4CKm1u72Vgyp3MBv1fuiCuocqJCBDcjPhx
	 cFnapSrqsul1Bzk0uS9wOzEpfAuGARrhYIksuSMGQYJLesP6sZgRyXSgqAYA0NSJCp
	 FGgKjC22I22lHTgc6lfY04+WDs+WAOI4eHBoHzdM64KxXjJ09F/ZtwAqtOnHPEPE67
	 2PrbdvCU99S5vUGzaB315+SJjvI6uQvhLphYpPYMr2kREhGWgg36hLgGjWmgur+nqI
	 XGkoWbrfvIUOQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Aaron Yang <yangqixiao@inspur.com>,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev
Subject: Re: [PATCH v1] mm/damon/pa: initialize 'folio' to NULL to prevent use of uninitialized value
Date: Wed, 31 Dec 2025 16:52:41 -0800
Message-ID: <20260101005243.84695-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231070029.79682-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+ damon@

On Tue, 30 Dec 2025 23:00:22 -0800 SeongJae Park <sj@kernel.org> wrote:

> Hello Aaron,
> 
> 
> Thank you for sending this patch!
> 
> For the patch subject, let's use 'mm/damon/paddr:' as the prefix of the
> subject, for making it consistent with other past commits for the paddr.c file.
> 
> On Wed, 31 Dec 2025 13:57:37 +0800 Aaron Yang <yangqixiao@inspur.com> wrote:
> 
> > In damon_pa_mark_accessed_or_deactivate(), the local variable 'folio'
> > is declared but not initialized. If the region [r->ar.start, r->ar.end)
> > is empty or invalid such that the while-loop body is never entered,
> > 'folio' retains an indeterminate (garbage) value. The function then
> > unconditionally assigns this uninitialized pointer to s->last_applied
> > (line 239), resulting in undefined behavior. Subsequent dereference or
> > folio_put() on s->last_applied may cause crashes or memory corruption.
> 
> Nice finding!
> 
> > 
> > Although DAMON regions are typically non-empty, zero-length regions
> > can arise during region merging/splitting or due to address unit
> > alignment — making this path reachable in practice.
> 
> But, can zero-length regions be made in real?  damon_ctx->min_sz_region
> disallows DAMON having regions of size less that it, and all DAMON API callers
> set it at least 1.  That is, DAMON code is at least intentionally designed to
> prohibit zero-length regions.  And many parts of DAMON including
> damon_pa_mark_accessed_or_deactivate() are written under the assumption that
> there is no zero-length regions.  If there is a case that allows zero-length
> regions, all such parts could trigger problems.
> 
> > 
> > Fix by initializing 'folio' to NULL. Assigning NULL to s->last_applied
> > is safe and semantically correct: it cleanly indicates "no folio was
> > processed in this invocation", and callers are expected to check for
> > NULL before use (as per common kernel practice).
> 
> For the above mentioned reason, I'd like to fix the code that allows
> zero-length regions, rather than making only this single function safe from the
> bug.

I still think in the above way.  But in my second thought, I also find no
reason to oppose to initializing 'folio' to NULL.  It adds overheads of
unnecessary initialization, but those seems quite negligible.  Meanwhile,
_arguably_ it makes the function more complete and easy to read in my humble
opinion.  The function might better to have further cleanup or complete
rewriting, but I think such complete rewriting is too much request, while
initializing the variable is a readability improvement for at least someone.

That said, to do the initialization, I think the commit message need to be
correctly updated.  Otherwise, it may only confuse people and encourage making
changes that allow zero-length regions.  Also, this pattern exists on
damon_pa_pageout(), damon_pa_migrate() and damon_pa_stat(), so better to update
those altogether for consistency.

So, Aaron, if you still williing to make this change, could you please send v2
after doing aobvely commented requests (updating commit message and making
changes to other functions)?


Thanks,
SJ

[...]
