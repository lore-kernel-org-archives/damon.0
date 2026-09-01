Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28E2367B63
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269560; cv=none; b=necP2Z8PJnaFvtWHjy/XinplVBXIiVJhMvsuu/VtGYgQu+lZUMc3JELli/o9oDHTMvU9SuYehcouq51A+IK700+pPXBluKdd3nYWlrM7ZQO3Pe1Alr2q844B6nAK5UyaGfh7zb2u7YbSTkgFnn9aWNRJVFO8gh6cv7ApM5wxWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269560; c=relaxed/simple;
	bh=PfWKkeUbFm/6Tebsq9POGDPF/PhwkM56l44v+WKJHyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FPjSjBYmBaUKywEpTTo65sxYHnQo1eLpzWZ0WtuhbvO1anP8CWD4+mrcv2Cyt0316YlzCzflGmjigjMDfG+CBKBP2Adl/CWXxRYIDNKEO70IKuPr4PKeT4lcUtYU25GmZQyRJ8DaTIvDa332zMCPhFLuRgHDueGXMGy68RIK/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkW1LrHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkW1LrHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EDE1F00A3D;
	Tue,  1 Sep 2026 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269559;
	bh=N4aEyET/oflYkYxeICA1Y+CseDOaS/4EDAimuOBPjcw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PkW1LrHYln5LKICFgUDa1MXz/KGAbX+hChVPBtGona/tXAZ4GZBeVMy6kuGCtYxKK
	 vq9Iwc8d6a3IHsnBBtZjSQgI6wmnhX74pIc7baM8i+p0lrmmAVEKl0Vk+xZRaW1AnW
	 QXocK8qlapoXN1dhYpQmkSaMOizLZVPXu15Ik4BWG+ozQCGwUTRuJWpeXNb0AHmK84
	 U31+4c0nUdASvfGOmCK7RL2tPyx+4EMwkJCWFGqmL/t5xMIamt5HAcjoWCYfl1o5L8
	 mLZoxp2nPnd7sxOljB9Rq7APu7Z7xm3g15elMzxYh9YaVWgTGPu2v86IEAv2I61ocj
	 XWys785L2RhoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 01/17] mm/damon/core: introduce
 DAMON_FILTER_TYPE_PGIDLE_UNSET
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-2-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:32:38 +0000
Message-Id: <20260901133239.56EDE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Introduce a new DAMON filter type, pgidle_unset.  It will match pages
> that have their PG_Idle flag unset, or the page table accessed bit set.
> In other words, it says if the page is accessed.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D1

