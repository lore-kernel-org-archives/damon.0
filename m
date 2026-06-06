Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699C27453;
	Sat,  6 Jun 2026 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704738; cv=none; b=OJYGeONF6Wq9Qv0MKgkR+mwyNjqbFP/r9ayRtI/EG6DA3libxdrOxi0N7KvF9D/wsVJIzSB/0NUO8HQkZ07ZuJpBrkUo6JhevLBHdoULnXt2P/klQ9NmYwySpmzI9TCRxlbRo4IZ8aXoww2cc6juOrHkodJYW9h8Ora88aeyxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704738; c=relaxed/simple;
	bh=hz8BU3FBo+qtSG7SP6Lf8hloiGdOU27SeTpYdUebhzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehI8Wa6W88AW/4gkN8+C7EoHmYJb0ENbZ7b51Aa29NEPlU7r2RKjDdqqMnXzdD0nxjXUnvavguLJpCLMY/cIoXrHzvvOOjnu8dPfw2brz/nM9jfOUFgd6aKYT/gMCJmWCVOdJQq5YTZTHkAv50UIy0xHWOtg4Q4vl9dpd7VDxFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czRW9f8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czRW9f8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0ED1F00893;
	Sat,  6 Jun 2026 00:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780704736;
	bh=0OCPRVR1wmkQl3i0ICCAJcUs67GgsoPTKyPUliid0Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=czRW9f8Vp4tgSqYsfCv1hSpDSPigPOJK8CDMptzmVQDGG7YnA0umr4GA7fhEByan+
	 4iYLZj/OqNTOuPHxKGecDGfJniYM9cwjDVGdmbU78VUdgV/i0Cy6+hofpm/PN3yDuL
	 n9bLtp2BDV7MM2DO5P+aWaZZKrhwocuBCocPpblDde9MzT2AjbnqIp3SRM/iq43ZlD
	 Szbnxfp58dI3hDnzitZA4McV8iFkJH1r30UT0FbuE/kQ2TILVa9NC70nZMx2KOp/O1
	 dofGbY3h0RwbP6+DnbUbuYxJcP7Ebg8jKxtyWtGdbquxHkDOmBL4R1lubEGK6mhKrE
	 Q78ut1mqxFeUQ==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	sashiko-reviews@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v3 1/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Fri,  5 Jun 2026 17:12:07 -0700
Message-ID: <20260606001209.88310-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2a4665b3-ac61-4ea2-b360-5cc6c21a6606@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 5 Jun 2026 13:57:47 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 6/4/2026 6:19 PM, sashiko-bot@kernel.org wrote:
[...]
> > [Severity: High]
> > This is a pre-existing issue, but can this cause a divide by zero kernel
> > panic?
> > 
> > If there are no active or inactive pages, or if per-CPU vmstat counter drift
> > evaluates total to 0, mult_frac() will divide by zero.
> Not a bug. The system can never have 0 consumed memory.

Makes sense.

> >> +static unsigned int damos_hugepage_mem_bp(void)
> >> +{
> >> +	unsigned long thp, total;
> >> +
> >> +	thp = global_node_page_state(NR_ANON_THPS) +
> >> +				global_node_page_state(NR_SHMEM_THPS) +
> >> +				global_node_page_state(NR_FILE_THPS);
> >> +	total = totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
> >> +	return mult_frac(thp, 10000, total);
> > 
> > [Severity: High]
> > Can mult_frac() divide by zero here?
> > 
> > If the system is highly idle or due to per-CPU vmstat counter drift, total
> > could evaluate to exactly 0.
> No, total can never be 0.
> > [Severity: Medium]
> > Is there a risk of a 32-bit overflow in this calculation?
> > 
> > On 32-bit architectures, mult_frac() preserves types, and computing
> > thp * 10000 could exceed the maximum unsigned long value if there are
> > more than ~1.7 GB of THPs, producing an arbitrarily small quota target.
> > 
> Good catch! I will cast 10000 to unsigned long to preserve the types.

But still it is 'unsigned long' that has only 32 bits on 32-bit architectures?
So it shouldn't make any change here.  Or, am I missing something?


Thanks,
SJ

[...]
