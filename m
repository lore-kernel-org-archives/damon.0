Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D7492E43
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050475; cv=none; b=heXxzsw0hqVule9+fRUjQ+q4LuTvL7oWAOQyf1ak0wClG1tVe+jZE9YHXJX8QTRwWaRs1cLzzPedCSPBUQQuEiYd+4Dhzzr2OLKT64rReWdV31pR+pLVZb5On6nMRvJ3gymsdD+ERcbCaJqXAfWx3aaPkIdUvro54/RSa4qkzQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050475; c=relaxed/simple;
	bh=BkJoRFI+Mzfq/Vd5u0YuagU7CKeRIMKtVJYh3X+fXig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZqxrUDJl+NFVcxDICWFtA50YsJTVSsNvrSiU1kMP8bU2DNnFOZtlvaCUIT6tuwiZIbIHDabDp98jUtGfc7iCDpMLifE8+BlbdLl+wzJjGbLJEDBw7WzSpGeuN+eto6BblX0F5Zlu8virzZo+gUxMmE2aJY6eEJEXdl6qYvrlEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bad+mdJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bad+mdJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C951F000FF;
	Thu, 10 Sep 2026 14:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050473;
	bh=Qow9gUOVKtz8ckfMvQjJEaBMPRblHsO2nHRHLGYZgtc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bad+mdJ2UYzGxe9B13UffQR1kx6Hhd9LVj4lfNorJ6hFt2z1nmmiQytTnaOqT1J18
	 6JZvYchfhrtfWe1pR8MCyP7T3WmJFEUvbHJH/Xh/mJn6/1/IiKgXVcztwpEOoP5VRq
	 CX2Aqq81O8AAqn4nCqsppLuNRUN+4SVsdrw0N1LZq3KMjCXNaIWnFfPxhDv6O19Yes
	 js5YBG10RHd4Wqw1Hcn/I7AflNJumUSCmLOgEMD0TLJzBdGcKvqhbEf9qaRYk/EVwk
	 OR390anHNRDsFh3eaz0Wv6IR+OQt1LV+GMPTfQ1+D5y/iMtI1Kvfhi08EQiYxx2uc6
	 5QBMcbZJm0dmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] mm/damon/sysfs-schemes: rename
 sysfs_filter->sz_range to range_{min,max}
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910141849.170896-5-sj@kernel.org>
References: <20260910141849.170896-1-sj@kernel.org>
 <20260910141849.170896-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:27:52 +0000
Message-Id: <20260910142753.68C951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON sysfs interface provides 'min' and 'max' files under the DAMOS
> filter directory.  The purpose is setting the general range arguments
> for hugepage_size like filters that require range arguments.  So far,
> hugepage_size was the only filter using it.  Hence sz_range field of
> damon_sysfs_scheme_filter struct was connected to the files.
>=20
> In future, we could add a new filter that can reuse the 'min' and 'max'
> files.  And the filter might use a range of a type that is not size. For
> example, probe_hits weighted sum.  In this case, simply reusing the
> sz_range field would make it a little confusing.  Rename sz_range to
> range_{min,max} to avoid such confusion.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910141849.1708=
96-1-sj@kernel.org?part=3D4

