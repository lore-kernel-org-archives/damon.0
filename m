Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8124022B;
	Mon, 13 Jan 2025 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736798575; cv=none; b=fEshRcwYrUptz/Coh5lywtbUsDf4tJcQYfOH5jHijpGuRQazjLIJ/1+dy693EkM5+4RBnDgSaP/JUQd7+J7N50IDpMbg5LMyjrmGmPPd7+rKcJZipljjDJvtjxKH+sfmqZFrZYDTMjutr8cP7q5mEoPwK/JcTuCS/91+9SY663c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736798575; c=relaxed/simple;
	bh=AyPqzFgA4xVjhERkJaxYAdaaqP+fpWVx7YEtFbuSgdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tt4SO0LB5rXCshghP0zQ0yavarg6fhVBKvBptlUFUj3gMRbX5/PfwVhq0GKhdHt4ykPlbBEMUCdWI6k2iOya9hyII5HnYxqO+TfbsKGBCm7yeG/SVIRmmg0Cv4BfzpiQuy8bK6UntJe5Sy2FJZ2hgELSrrjD40dn5ySWlWgdFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URA+RzvM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URA+RzvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622D6C4CED6;
	Mon, 13 Jan 2025 20:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736798574;
	bh=AyPqzFgA4xVjhERkJaxYAdaaqP+fpWVx7YEtFbuSgdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URA+RzvMsQE3gAX1Plcekf0VYBJ+KmC9LyNEarFm0v9PdU0tikGhiZsTVDVYopuWr
	 j+73yrvcEObaT3CGvqOQeoT/f/bNYg2g4Z71UjAP0+ERMBDFCAwsnIeybwJPhDTr0i
	 VUlMbqZPPLcdIFSrXx6+Ky2tIAgnuoa0OJKCa/jvtlw1IqFgV6k5oW+gdE1Ae1WCHu
	 ijz4yIrFkCvB3Tfy2W6I7GNHgWu7s4+OtTVopz3pfG1qjKItyQgLk+W4HB3RKZ8tWG
	 +l733JnUrIY32tNqCGz/vwKGz6wzFdbdYRKftY3mHGGe++PNZ7rPUGPPM+kRwBBb83
	 +eACKJGgtutig==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/18] mm/damon/paddr: report filter-passed bytes back for DAMOS_STAT action
Date: Mon, 13 Jan 2025 12:02:52 -0800
Message-Id: <20250113200252.38124-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113194939.4152203-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joshua,

On Mon, 13 Jan 2025 11:49:37 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Wed, 18 Dec 2024 20:03:16 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> Hello SJ,
> I hope you are doing well! Sorry to add noise to an old mail, but I recently
> saw Usama's patch that improves this function, and it brought my attention
> to this series, so I have been reading it today.
> 
> I was unsure if I should send this mail because I had a nit / naive question
> about the patch:
> 
> [...snip...]
> 
> > +static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
> > +		unsigned long *sz_filter_passed)
> > +{
> > +	unsigned long addr;
> > +	LIST_HEAD(folio_list);
> > +
> > +	if (!damon_pa_scheme_has_filter(s))
> > +		return 0;
> > +
> > +	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
> > +		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
> > +
> > +		if (!folio)
> > +			continue;
> > +
> > +		if (damos_pa_filter_out(s, folio))
> > +			goto put_folio;
> > +		else
> > +			*sz_filter_passed += folio_size(folio);
> > +put_folio:
> > +		folio_put(folio);
> > +	}
> > +	return 0;
> 
> Is there a reason that we decide to use a goto statement here?

There was no special reason.  I wrote this function by copying
damon_pa_migrate() and removing parts that not necessary.  As a result, the
weird 'goto' has remained.

> As far as I
> can tell, this is the only place this goto statement is used, and the else
> case bleeds into it as well. That is, I believe that the following could be
> more readable:
> 
> 		if (!damos_pa_filter_out(s, folio))
> 			*sz_filter_passed += folio_size(folio);
> 
> 		folio_put(folio);
> 	}
> 	return 0;

I agree.  This looks much better!  If you don't mind, pleae send a patch!

> 
> [...snip...]
> 
> Again, I am sorry if this is a naive question.

No worry, thank you for this nice and important question!  I believe
readability matters and DAMON code needs many helps for that :)

> Thank you for your time,
> I hope you have a great day!

You too!


Thanks,
SJ

[...]
