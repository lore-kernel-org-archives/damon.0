Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2CE282F20
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 01:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397812; cv=none; b=lIk+ZTDHk5oa+cCinzMSrBtk6jFc70vG6cgZzRnLYcTd4pPjW+9t8Jqm90vLOykveAmbQAzT8aJHFvnYVRlV7hWF1zh92MAUBeBpUWM6Kjc86S+VJXf1KMT6TOo0Ccjj3NEqdqMKa1bOkNcimshTAyXjkR2qFUMmVnlXCQy/EUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397812; c=relaxed/simple;
	bh=Ed38Us48IX1ZarON5u91elU5hN8XKZqJ4P/ZhSUXNFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uNmSqkEeHJDYhwKD30D1Dt3P8kBWRyZ1wW8yNIPn8BGZtyusrHnGFPVHnHXPS4ulgErFm9HONuS7upI4l8zWR7+yQ0HisHXB9q1Ak6GkSHx0uvRWUAmm5+syQg7KZayDNMRMGbi+kfDyc+e7NRcRoDC6kI36KCqCZh+mDqdaG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxekIfJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxekIfJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC2F1F000E9;
	Thu,  3 Sep 2026 01:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788397810;
	bh=BbXJZSxQuXy5wVOqhKuN4+mOWRUTSDTzeAjNujsE+t0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WxekIfJccp3W44Z97ncG0ZdH62RKdqIfYwQEGC5DO6jnDT6BbtfuOGNgZKPdS9PFE
	 Kd/PNb+kx78seUjb5lgcNA38P0pMnuemae9Xv1Keg8807s3uMpiHapQw9FAAdf8swK
	 IEKTp3a9CG4AsbxtnQy5qwd7TdlVWoJ194KLgVZfoaKLRcp/c8C3MVNzKM2BlkUp0q
	 3MDBpmP6iiRco/tiv6Hdwmq+6+R1VtHSjCTRseUnxuE+tAZtmEruvrPYuEWJGIRQvQ
	 E/GdZvcS6D6ecKstvzhXQTZmysC8XpNlAPG7bfBfpQeWp67fOHDvpeDV1iTpmAApLd
	 OE5NbBgPLbLzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] mm/damon/lru_sort: remove unnecessary damon_call()
 param validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260903010334.93622-5-sj@kernel.org>
References: <20260903010334.93622-1-sj@kernel.org>
 <20260903010334.93622-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 01:10:10 +0000
Message-Id: <20260903011010.7FC2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON_LRU_SORT avoids passing NULL or unstarted damon_ctx to
> damon_call() with its own validation.  The validation is no longer
> needed, because the DAMON core layer now handles the corner cases
> itself.  Remove the unnecessary check.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903010334.9362=
2-1-sj@kernel.org?part=3D4

