Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482315;
	b=Ta+0Hy1r6aFDhCi8+jZ53OYEqXFf1U752fqchzB08ED9CPRY6oDAChVzvPmkY6ob3qM7
	 38aueZgXvt3mR6oO65eEr0KmIR2WZWIOIv7lfdchqoNvetb1Jj9PccemRZLM+XdGAZ2pn
	 N5zb3B0i1tc7yM7R0eGnKft6DgVUH7X5JA2wssXU2SUV3DkBxB/o3sTD00iejAifAoyDt
	 cS0lJN14JlbVPTq8t2TWH3O8CmXC6Z91Pt//V6W0ObKqEtFFvu0hd8ahJrGl7Om+zt6DY
	 BdvlnDvveuNgYXcbYpGPpXg3E0PijYmhV43dqiQn3GGPpaVchIATwn6QRDxPagj3awA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482315;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KENda9nYN/y7XIiHiZ/NO1fdbgQMsJasxhpRCd9Tv5c=;
	b=yNkXrg6Xn86NJRmRCyw6rxUpFW6EbdeHg57sz/b8dC6brHGj/+LrGwq6BT/tgUyoVOQv
	 w3A3wc0gOk8AcHgbKFWeSRjOJTszqm+BiDGlaodC1Nx0WLhqHyeMIFAQsDALJPBfZxr7T
	 iI7P/EMMmJPZ39p4Y2kNwoLoXV4YM97PupNJ7LT9a7ezqvBP7djtDTo0P4D/RzPZ9cyfu
	 B0C04PP4ZF6ILLeWfQ/7cMD0rO0j38wq6CQQQpYowY0uPFveoLuGVfJbWcxQiOSBo7maN
	 BQ1EKWQdSP1ZSbxCwmN/sKql3w6KR0FnkGJTdCADVqCAwgVxS8B384oWR1qKILKvzfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8Bu8fNF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C83606A31E;
	Tue, 24 Nov 2026 01:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8Bu8fNF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969EB1F000C0;
	Tue, 24 Nov 2026 01:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795482314;
	bh=KENda9nYN/y7XIiHiZ/NO1fdbgQMsJasxhpRCd9Tv5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z8Bu8fNF+KXKJP9X9cs7klKU/PMw6iRImxz2/KDQQ5DvZBSk9iTuE3dOl3FlZ2FUJ
	 CZYSElfbv9T6BFnFm15N5jNkoDXCPRxffVy+zmyWsdS/kqOdnAQWNql1NTW6fthNvR
	 kWracD8cuMVhdssm/s270lZU9L7lzPgD/xcAuwmRnA1oQ5YTum3gzgi4YVqeokZO0N
	 92ayQ26WsGGVRFiPYD8xzyMdhopNVfSyMTORqWis2lFLrNCprDvhtcg68sN04+rC3V
	 wPfkhjCtGapWX3+iur44c8F5rAb7ysYTr804cCxGFxf0CbtIrY4ysWm02xs8V7O/H6
	 gI/bZE3WdhI6g==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 14/27] mm/damon/paddr: support REPORT_MADE type probe filter
Date: Mon, 23 Nov 2026 17:05:07 -0800
Message-ID: <20261124010507.90151-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179545322647.4.683470932650691650.b4-reply@b4>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 24 Nov 2026 04:00:26 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi Lian and SJ,
> 
> On Mon, 23 Nov 2026 20:00:02 +0800 Lian Wang wrote:
> 
> >  		addr_range.start = damon_pa_core_addr(pa, ctx->addr_unit);
> > -		addr_range.end = damon_pa_core_addr(pa + 1, ctx->addr_unit);
> > +		addr_range.end = addr_range.start + 1;
> 
> With this conversion, each paddr context looks up reports in its own
> addr_unit. Producers submit to one global queue, so two contexts with
> different addr_unit values can interpret the same report as referring
> to different physical ranges.

I agree such interpretation will happen.  But I find it is hard to imagine a
purpose of such setup for real users.

> 
> Could we define a common address unit for reports and document it for
> addr_start and addr_end?

I'm afraid if that will add something that we need to maintain long term,
without clear use case.  I think we could revisit after we get such realistic
use cases.


Thanks,
SJ

[...]
