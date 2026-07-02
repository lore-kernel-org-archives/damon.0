Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268332861F
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783025035; cv=none; b=GtTaCo4+P3g+mq91lx6iuXwj6QUv02PUjCODEeWU5LBUbgZFNr8JJVZUHzglkezW2DtGyJq1zc36ybbQKy4nIz3Gge34C1Rc+/eRz9kOYtfh530Q4KmGyyQ+Hjh5kkeyk0/qbhL8mmgxZJwiZV5X5Vf4NnwjFdflKkeDMWZjph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783025035; c=relaxed/simple;
	bh=mvpoJ/jQhmLJ6iGcU/lUiPQ0UkEh3GqoQRezo4sPuow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvrNiK/HHRMqUOJVDavDgg09AF1BxVVhLLGaJXiYovFnm8yOk6F9+7XDHgqX6OmRDYZQGeG1yBVfjZQc8m/ixVRUonuK5Qr6bOeMstzOT1O1EzfCg96z8WOwqzpyTV3CiRB051yY8mgBU0DyUlEDAoXc2xumhElTVTCthWGF9cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjBRCL2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjBRCL2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8A71F000E9;
	Thu,  2 Jul 2026 20:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783025034;
	bh=wP/LM40gKAzc6yNU15txvwkezXg6t/HFpArJC9oyuTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hjBRCL2Rd69kC7cYvsdCGlMZ/R5KQSL8zT0nFLwLyxhFeUa2ftSK3a5FrCIXfQcmE
	 AnFikoiUQRtyaRZFoz/7ARqiHT/Ot6lquGsky4/sqiZaJBWFCQENJjqI45Vr3RPof0
	 HJacL+nni32NVBsoY6ftDQQxdRPRMB0q7YGxPljZggXfmZwQ9mndc+iCIqMuJhhuVB
	 0iwq74lDkOXT69fn8lqwgNzp+btBptACHauMGv2IuZQXkk+tsCgaZC1CVO214AEbqW
	 7VZanJiaV8P8aDP/h6wPO3fPx1ZqUvr4KFJATAMoc3zTsA6/CzkZ7lf7kF30Ay2TJx
	 pniHyixRhIgoA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 3/3] mm/damon/sysfs-schemes: set probe hits as pseudo moving sums
Date: Thu,  2 Jul 2026 13:43:41 -0700
Message-ID: <20260702204341.92882-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702173207.ADACA1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 02 Jul 2026 17:32:07 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] damon_probe_hits_mvsum() returns an artificially inflated moving sum when left_window_bp == 10000 after an attribute update.
> --
> 
> commit aa52db4de056d7c850beaa9ef06ec63a3befcbf2
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: set probe hits as pseudo moving sums
> 
> This commit updates the DAMON sysfs interface to expose probe hits using
> a pseudo moving sum instead of incomplete counters. It uses
> damon_probe_hits_mvsum() to calculate the value, similar to the logic
> used for nr_accesses.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index dbf2b0515d582..32f495a96b17a 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -110,7 +110,8 @@ static int damos_sysfs_probes_add_dirs(struct damos_sysfs_probes *probes,
> >  		struct damos_sysfs_probe *sys_probe;
> >  		int err;
> >  
> > -		sys_probe = damos_sysfs_probe_alloc(region->probe_hits[i]);
> > +		sys_probe = damos_sysfs_probe_alloc(
> > +				damon_probe_hits_mvsum(i, region, ctx));
> 
> [Severity: Medium]
> Can this result in an artificially inflated moving sum being exposed to
> userspace?
> 
> Looking at damon_probe_hits_mvsum() in mm/damon/core.c:
> 
> mm/damon/core.c:damon_probe_hits_mvsum() {
>     ...
> 	return damon_mvsum(r->probe_hits[probe_idx],
> 			r->last_probe_hits[probe_idx], left_window_bp);
> }
> 
> When left_window_bp == 10000 after an attribute update, this calculates
> current + last.
> 
> Because r->probe_hits is not cleared during attribute updates, the
> un-cleared partial hits might be erroneously added to the previous
> interval's hits. This function seems to lack the safeguard for this
> condition that is present in damon_nr_accesses_mvsum().
> 
> If users query the stats immediately after an update, could this
> silently overflow the unsigned char and expose incorrect statistics?

This is good thing to improve it for the perfect.  But the perfect is the enemy
of good ;)

probe_hits was very unreliable before this patch, and this patch makes it
reliable but still having some rooms to improve.

Not a blocker for this patch, in my opinion.


Thanks,
SJ

[...]
