Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576551397
	for <damon@lists.linux.dev>; Sat,  8 Aug 2026 00:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147667; cv=none; b=c6gUPuAtGSqGiqm4Uqj3WKLTmqyQ09yFxH4yw+xzUbmlmE2EpnEjieE+e6U3/FOzghEm95bImuWtF05pqZd5jlX2kiBAlMv1F/xO8FJiTQZp/2OopbL/SyxreDXcdyVpNnP0tvoFg55a5UeORxmq30eUWLbwySeeilrVGrZcpbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147667; c=relaxed/simple;
	bh=ibGMZwYwCjHCpha6ArnzxNaXxnR5zNAiI9eY8j4uHSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6jqiqll+PF+JXuIX6kfKizTS6wsX2pEkHlFHaSebA2Th8HJQ4HBG5ihJcopp4oVYd1x1vCGTn+65jPL4q83bmvhLaUpicksjL+Yb+xt8p/SIVH4zAXhXb3+pp6eZZwvTAXpzQfGgzoNmthn5JBTEtYWh6HNVqVIh6myx0ZvgUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoFR3W53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoFR3W53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3EC1F000E9;
	Sat,  8 Aug 2026 00:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786147666;
	bh=jURskxvxN8Et2Wft8lg3avApYLlxcoCblCUkQrEksBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZoFR3W535iIJL7/T3VlGOvG4vWl1jyomma/oC/XHtmSdwpFzeG8s6nNVD3/3WBcWU
	 9TTIXF0owhgDtfiVGEd19jH3fF5ghW1lTOj2doZh7Up6zVGP8R9sBvX4y4GvRP3cPC
	 TIUvmqUmf30++8P8yZIda5tD4IzmwzUpipQ5sh3aYB73bGFvmlCfxKdr6gLPMbRY3e
	 Wo50B0fql//H0hbOUv86hcq1vpOVtfHnA7/EJPqatDy2zm3tHikTi+KbnVpkmlqmUy
	 t8qft6XxZuxRcj8tHsm3/aKsQKRiW7LgLediOtap3G3plM6iWzBWgxvyj0PZR1xWD7
	 OKXE0Gr7+JGVA==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/damon: skip deactivated schemes in watermark checks and add fallback sleep
Date: Fri,  7 Aug 2026 17:07:38 -0700
Message-ID: <20260808000739.1308-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260807161840.56993-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  8 Aug 2026 00:18:40 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SJ,
> 
> On Fri,  7 Aug 2026 07:07:39 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > This is an intended implementation.
> > 
> > When all schemes are deactivated by watermarks, DAMON stops monitoring.  It was
> > implemented in the way because we didn't want DAMON consumes system resource in
> > the case.  But, later it turned out DAMON's resource consumption is really
> > negligible.  Rather, it is turned out that it makes DAMON runs with stale
> > history when it is activated again.  Particularly, regions have 'age' and their
> > start/end addresses that was emerged before the deactivation.  Those are
> > meaningless and could even cause wrong DAMOS decisions.
> > 
> > We don't want that anymore.  For a case the user really want DAMON completely
> > stops, we introduced 'pause'.  For max_nr_snapshot-based deactivation, we don't
> > intend to completely stop DAMON.
> > 
> > Maybe the documentation can be updated to further clarify this.
> 
> Thank you for your detailed explanation! I also glad to hear that
> DAMON's monitoring's resource consumption is negligible, since I plan to
> add a contexts/<N>/always_monitoring parameter later on, allowing users
> to decide for themselves whether to keep monitoring even all schemes is
> deactivated by watermarks.

Unless it is for your real use case, I'd not encourage improving watermarks.

Here are contexts.  Watermarks was initially developed for DAMON_RECLAIM.  But
I found it is difficult to be extended for other use cases.  Also it has the
aobve mentioned problem: losing the monitoring results that was converged over
time.

I'm planning to develop an alternative superior feature and deprecate
watermarks over time.  The plan is not having a high priority because I don't
show real requirement of that.  If anyone wants it for their real use case,
please let me know so that I can prioritize.


Thanks,
SJ

[...]
