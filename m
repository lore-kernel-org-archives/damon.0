Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7114AD20
	for <damon@lists.linux.dev>; Sat, 13 Jun 2026 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781317986; cv=none; b=Zs5lNphMo+zeRSBB3TYYMnL7g/yKQ55o6zKvW0OCDU867STOS7h4cKHnmcQIxEhE8nyKrBfRyD3UMM690CLTOD6mVOzn5/MumsFljoSU2EVuAW7CUQ4liZSJcv06Ar2tfe4kdlbLiFF2W/erWEgrxCraHZ0cD2lIb1zStufvb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781317986; c=relaxed/simple;
	bh=mi3ZV3Gt/r2lcK06u4jEt7t01Fy3KeVWrGhal3SlYAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkXm09i25eoyuVjAZvIiOrdqcjW3R7O/cA7skglhGdVbdcYuBs/2mdGoNBOd6tjoMt56YdhzFhy4Z1OYBqaznNyakfd1XG6Y2PJchGj+ou8cv8Z4DtB/YSYGLFI1tzyIVB6CF6hefMHMQ0gwzkMDyEz9jLmY84nq+d/3zGJlm8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q91H3e+e; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q91H3e+e"
Message-ID: <4072c971-0a54-4bbe-8cb1-c06e13b22f05@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781317981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnBRu3NQHRa7FAIW+DrmHpdNjwA7eML12cXPHDJUAaQ=;
	b=Q91H3e+eKXamFdv8sBIlHNxnrqyHVsVEpM1TULIuo0ooAmms7jIllIS+uDrWNEptRe/JXp
	/Ke7BMWlhwEgH9xTEc0RngEAknMvG+CW+EY4XSytGGYpqDmgXrg9Lwy+GcvKuBpk73yHTb
	m8FvKnAJL7+5lWBxT8pBi4FhpJkept0=
Date: Sat, 13 Jun 2026 10:32:43 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] treewide: fix transposed "sign" typos and update
 spelling.txt
To: SeongJae Park <sj@kernel.org>
Cc: Shardul Deshpande <iamsharduld@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>,
 linux-kernel@vger.kernel.org, damon@lists.linux.dev
References: <20260613000715.791-1-sj@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260613000715.791-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/13/26 8:07 AM, SeongJae Park wrote:
> On Fri, 12 Jun 2026 23:46:32 +0530 Shardul Deshpande <iamsharduld@gmail.com> wrote:
> 
> > Several comments and one documentation file transpose the letters in
> > "assigned" and "unsigned", spelling them with "sing" instead of "sign".
> > Correct all of them.
> >
> > Of these, the misspelling of "assigned" is not yet flagged by
> > checkpatch, so also add it to scripts/spelling.txt.
> >
> > The remaining matches of `grep -ri singed` are RISINGEDGE register and
> > enum names, not typos.
> >
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Shardul Deshpande <iamsharduld@gmail.com>
> > ---
> >  Documentation/mm/damon/design.rst          | 2 +-
> >  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 2 +-
> >  drivers/gpu/drm/drm_color_mgmt.c           | 2 +-
> >  drivers/scsi/elx/efct/efct_hw.h            | 2 +-
> >  drivers/scsi/isci/host.c                   | 2 +-
> >  drivers/scsi/isci/port.c                   | 2 +-
> >  drivers/scsi/isci/port_config.c            | 2 +-
> >  kernel/bpf/helpers.c                       | 2 +-
> >  scripts/spelling.txt                       | 1 +
> >  9 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > index afc7d52bd..899ac9c69 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -140,7 +140,7 @@ as Idle page tracking does.
> >  Address Unit
> >  ------------
> >  
> > -DAMON core layer uses ``unsinged long`` type for monitoring target address
> > +DAMON core layer uses ``unsigned long`` type for monitoring target address
> >  ranges.  In some cases, the address space for a given operations set could be
> >  too large to be handled with the type.  ARM (32-bit) with large physical
> >  address extension is an example.  For such cases, a per-operations set
> 
> For the above DAMON part,
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

This one has already been fixed in mm-new. See
https://lore.kernel.org/20260520012104.93602-3-sj@kernel.org .

Thanks,
Zenghui
