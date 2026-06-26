Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A512CDA5
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 00:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433546; cv=none; b=T8Fl6IggrBmjI9dzbMOUfRWfEJe3ZgP5FzdcH7uX9R4GNR562pPzqYqKkhA3cnkg8QSauRcffpHUJOxraQWO5Vmdupjrd7to39EWB8Akifq6sDPiONvSNKC187M71/3YP2z2LvsyeTwTqX8u1OxSYedL8hod+aBTSkbctea+DaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433546; c=relaxed/simple;
	bh=z3qT0t52cWmHuk5w1GIuSHhGzb8AEHRvM82E13uGZOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z2B1bfMpTvZqN/ILLFTcxAtlCOWBVLsOzM09W08oZiGWfq6sHEYGuKp4dkqvLchnwY00xzGQDv5G/qXJcB8Yw/dBGP9BB+McingIpVKgYY8z9eRmhTP3jzKaZx/9rCr+rGh9LqjZS3XJPyAIPFzctnoxouyOYAhIq2muJojJye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITZhnWr8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITZhnWr8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8211E1F000E9;
	Fri, 26 Jun 2026 00:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433545;
	bh=GxuMGCNIevYa6u4uSlGs+g0+E3i4rQ9SAKBaw5RJrqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ITZhnWr8anmvQaiIPhYJ7ayrrttizlqGc0X6TP3FqMTFQmHkdijuraymmg5vMSfyT
	 ptw85126HSYm37tnqX6r2+lRvR308SPLoni/7Jg2cylTkhrqNeza2baaBDg1gW1n0q
	 kgAS+4Gk2yPj/sXexm/fDYwXVQ+WbMWPzALAEpxHax+GIHZnRTHjdvj5OH/40xrtVP
	 CsFIvv69sCJ8jnHUpbGfxb4EfkdwFtZysP/VT8vULKF4TUdQVAlC02i5dphjIKr+sN
	 H98OdKC4QsfMRptEcII5AkMXi2UVfonXPw8U3hg+3Y0SzWVZ1tkUt7kkBPe75x8Ss9
	 3bbww0Ee3M9MQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 02/11] Docs/ABI/damon: document probe files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260626001644.85825-3-sj@kernel.org>
References: <20260626001644.85825-1-sj@kernel.org>
 <20260626001644.85825-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 00:25:45 +0000
Message-Id: <20260626002545.8211E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The documentation for the probe filter 'type' attribute fails to en=
umerate the supported filter type values.
--

commit bda36c29fa892137debaa25d64442f7c3b5efd22
Author: SeongJae Park <sj@kernel.org>

Docs/ABI/damon: document probe files

This commit updates the DAMON ABI document to include descriptions for the
DAMON probe sysfs files.

> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentat=
ion/ABI/testing/sysfs-kernel-mm-damon
> index b73e6bc28ea5f..f914aab79fced 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
[ ... ]
> +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_a=
ttrs/probes/<P>/filters/<F>/type
> +Date:		May 2026
> +Contact:	SeongJae Park <sj@kernel.org>
> +Description:	Writing to and reading from this file sets and gets the typ=
e of
> +		the memory of the interest.

[Severity: Low]
Does this documentation need to enumerate the supported filter type values
(such as anon and memcg)?

Users reading the ABI documentation might not know what strings are valid to
write into the probe filter type file without this information.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626001644.8582=
5-1-sj@kernel.org?part=3D2
