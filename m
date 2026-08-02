Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393B17B50F
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785692628; cv=none; b=LMcrcPtza/LEKfT/IjZ8r1GZC3nbsprPtvJRxanqrb7aQzkqygtU3AcqcKqlxgzPoY/IAcvfrCH2EGIfAkjEKGw7dDxNMRQpFB2uGsDHKX0PBVirwfHnygksAl69ydFie6/qxJzO7U7sw9iFZZXSQ8A4/1ifMRDiJZzwHFEoaeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785692628; c=relaxed/simple;
	bh=8+yAwdzukgflMLFWvUICLDj2qcstw6b9qY15GVu0Dhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qzq4630Vszi7eILXEyWVQVCm5x46WjaC8edABIKtw93ltklhzRL+3fOjjOgfIGOX5XENyxZ1b+LX224LooG2YOHKQo4WLd9V6K0ynPjfemRu1k9mw7GPbt2JV/xQfUICa1IkOwLTEf/tICy1rRnNwkaE3YLSryn35gl+GxFHnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMtbz2+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMtbz2+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3851F000E9;
	Sun,  2 Aug 2026 17:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785692627;
	bh=BND7gpURSdtJwUMnrpxZi/Jmg7bEHuuQh3k0/pMXf8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MMtbz2+5/wCipNyFtT2g0FHQP74fDf2i/clOxC8gYPEuHNI0j4rB7UyaOkYQ03kR6
	 PTRZG3PNnIi/t5wEceSIexJiYmLeGg1p8a8WxDy5NHTNOeqLG9CM3R+EodoLthidHO
	 X2iUVk7C93B6AlWf0+6ZR/0BAWPrD67NugZcmO7dsv6r3B5oURJJF56pdMiviwdyL7
	 QtLTbjYc3yNBrGiA/am+c++TUc1zsX+P779LTH/zQRpxGFP/R5EKxr6hJjlPTyB3/J
	 Ns86+8Xq2GhFlOF84xeYxrflBbQLtjV+kmKbBfLkodqgEkSwoSzlMZHPSc/eAAHM0r
	 8HO2+Cs7DpLdA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 3/9] mm/damon/paddr: respect folio end for DAMOS_STAT
Date: Sun,  2 Aug 2026 10:43:38 -0700
Message-ID: <20260802174340.1587-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802163458.108881F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 02 Aug 2026 16:34:57 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the patch provides an incomplete fix for an address advancement logic bug. While it corrects the `addr += folio_size(folio)` issue in `damon_pa_stat()` to correctly align the next address to the end of the large folio, it fails to apply the exact same fix to `damon_pa_pageout()`, `damon_pa_de_activate()`, and `damon_pa_migrate()`.
> --
> 
> --- Patch [3]: [RFC PATCH v1.1 3/9] mm/damon/paddr: respect folio end for DAMOS_STAT ---
> commit 99e0c032eda9c903df8d327aa77b989129d9b193
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: respect folio end for DAMOS_STAT
> 
> This commit fixes the address advancement in damon_pa_stat(). When a region
> starts in the middle of a large folio, it now properly aligns to the start of
> the next folio instead of simply adding the folio size and overshooting.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -379,7 +379,7 @@ static unsigned long damon_pa_stat(struct damon_region *r,
> >  
> >  		if (!damos_pa_filter_out(s, folio))
> >  			*sz_filter_passed += folio_size(folio) / addr_unit;
> > -		addr += folio_size(folio);
> > +		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the same address
> advancement logic regression still exist in other DAMON actions?
> 
> While you fixed the overshoot behavior here in damon_pa_stat(), it looks like
> damon_pa_pageout(), damon_pa_de_activate(), and damon_pa_migrate() in
> mm/damon/paddr.c might still be using the flawed logic.
> 
> For example, in damon_pa_pageout():
> 
>     put_folio:
> 		addr += folio_size(folio);
> 		folio_put(folio);
> 
> Could this cause DAMON actions to silently skip sections of valid memory
> if a region starts in the middle of a large folio?

A later patch of this series fix that.

> 
> >  		folio_put(folio);
> >  	}
> >  	s->last_applied = folio;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260802162631.90304-1-sj@kernel.org?part=3
> 


Thanks,
SJ
