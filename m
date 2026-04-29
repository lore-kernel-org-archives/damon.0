Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D6332635
	for <damon@lists.linux.dev>; Wed, 29 Apr 2026 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472839; cv=none; b=d4nfoKdgyf9Inq8CgvVyu6WFVef+84MHuxTFM/fMtJD7cImVkIzXkAcMkCUXoMCy6hTCRZWtNe7QOllwjGMSlQ1krmo4A5QC5zjNOwM6Gv/7y7vo2/Xgt9H3vLgkNZxvucpjUCltx+Vsr914YmKcHsXU2EVq3ryMmui5VMEneUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472839; c=relaxed/simple;
	bh=UnjXcSLPBm3DZwNMO34DZpoFrKQ44ZS6wiIeEJ5KUJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjcJdiHzRlXklR7VlX8PzXzJdBcXuZYzBhjJgwQ5ZfYpbsqf9JXWUmMF1Dvaf/VbsQZlfRxp0yfHdCjbIC22vodCBh3QkyBOGqxBxzVktTl++jrpayFAJMFWYXe7V36Qno305OOaqVho08xEnrbdNPIrLY92rzrrEngXLDylm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE54XCdE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE54XCdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81ACC2BCC4;
	Wed, 29 Apr 2026 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472838;
	bh=UnjXcSLPBm3DZwNMO34DZpoFrKQ44ZS6wiIeEJ5KUJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YE54XCdE3kvgb72kpOpLta66p73vxd8PnXdhn37mrSbBBAHzV5ou0/KOIuXoOOjbt
	 X51aCtsQQa6fGOE7hGRiAOjIJPLY1hVMWpd/AD6YN7pCjCsUhWZhMAS7kpB5UmHPJ2
	 7fj3xo3cWan9f1cLJpl4l4GdWpbKtOUNTjP2ac7L+2cvoJxmaN4J/usyotavWR0Iyd
	 Z/WILmbyolBJgw/MldO1HMQZXvHhx5kRypmZwg/L0ImCaibZCUQSAlg46IviF1roFc
	 SNY0jx7hX3LSXLQYut33sQJXn1vgWgfnxUx+H8l//3D+IdGFffCrBniirIW64uziE9
	 wF8KH+WL/FbBw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6/7] Docs/admin-guide/mm/damon/reclaim: update for entire memory monitoring
Date: Wed, 29 Apr 2026 07:27:10 -0700
Message-ID: <20260429142711.93760-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429070201.A6B80C2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 29 Apr 2026 07:02:01 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The commit updates the English documentation for DAMON_RECLAIM but fails to update the corresponding translated documents.
> --
> 
> commit 0775463e5909bcac92ff21d728b9a1b112304371
> Author: SeongJae Park <sj@kernel.org>
> 
> Docs/admin-guide/mm/damon/reclaim: update for entire memory monitoring
> 
> This commit updates the DAMON_RECLAIM usage document to reflect the new
> default monitoring target region selection, which now spans the system's
> entire physical memory instead of just the biggest System RAM region.
> 
> > diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
> > index 01a34c215b66..57ab8b187650 100644
> > --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> > +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> > @@ -229,7 +229,8 @@ Start of target memory region in physical address.
> >  
> >  The start physical address of memory region that DAMON_RECLAIM will do work
> >  against.  That is, DAMON_RECLAIM will find cold memory regions in this region
> > -and reclaims.  By default, biggest System RAM is used as the region.
> > +and reclaims.  By default, the system's entire physical memory is used as the
> > +region.
> 
> Should the corresponding zh_CN and zh_TW translations be updated alongside
> this to keep them in sync? The translated documents currently still state
> that the biggest System RAM is used by default.

Updates of the translations are usually done by the contributors.  Hopefully
they will do, and I will help if needed.


Thanks,
SJ

[...]
