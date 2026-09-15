Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ADC248881
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789453117; cv=none; b=hiSa4gyumXMW/xoiZYfV5fTW/dscUFGm+VGzG7hj3upotQ6kAOAhBLJPj1FwBY8cDL7WvyUwXKvr7YRQ5aEBESwbFiN64ZIVo9c6CdbKdgdtQ8fk87NkuUy77orS5bfqXP7Fwh3q6MR8qgnGruRzLi19JNmwenA2htXK2/ZlR4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789453117; c=relaxed/simple;
	bh=0hM6EGLa5n5kDsPQEl8d0vxVJ1ygtJaQsk1mX6SXM04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sMZDAcCKWGxfRSavtEbWzjlMIMmGitBOXEavKfMkw8NFDhQrHxjMPNXoIiT6XJfe8kgwYx0IkvwzAhqjpVCKw5UZFN43uKnaoRYdnoW1yjI3KvRIaihh3SFXrRrjQFceXCIgoZu6OIc1m0WkZozuG0/Ljy3DYxKHvi82O+xmoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLxHNTTt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLxHNTTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38AF1F000FF;
	Tue, 15 Sep 2026 06:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789453115;
	bh=0hM6EGLa5n5kDsPQEl8d0vxVJ1ygtJaQsk1mX6SXM04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NLxHNTTt8DWCU5may5/p0nNBrwYO0IBPFhkDv1e6zYXHiWE8+Daz5FEU2d2g22ijR
	 Gsdx323ja6uPqy5j4UWDPvXFtq5I8jvsLRYLo05F0JjkojhorPaSH39F6pDt55hjMy
	 wx3Z0kKSbQmpRsvdxbwgewZClNMlDwDUiucPy9nRSTxW+qt4VsyH6/gDGy9p+vOb58
	 ZbY/XBwWvVnYmWbR1n7PbL+Pkce+sQQkmkfJPhN3t26T4iFmFxka9Q8NCSZupWLcX2
	 JGQ2Ji9wtzOTP5PFjKwZAuKZMiEa3zh2frOAVNACb4/Ob+QWpHJWxiDBIK7SWVfK9R
	 LcTooqPJZovqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: score an unmeasured PSI goal as not
 achieved for the temporal tuner
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915060937.3423-2-kmehltretter@gmail.com>
References: <20260915060937.3423-1-kmehltretter@gmail.com>
 <20260915060937.3423-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 06:18:35 +0000
Message-Id: <20260915061835.C38AF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> A newly created or committed PSI quota goal has no previous sample.
> Commit a68878f83ae6 ("mm/damon/core: handle uninitialized
> damos_quota_goal->last_psi_total") scores the first tuning round as
> achieved to preserve the consist tuner's quota, since the feedback
> loop returns its input unchanged at that score.
>=20
> The temporal tuner sets the quota to zero for an achieved goal. This
> skips the first charge window and the window after each goal commit.
> Committing the PSI goal before every tuning round keeps the scheme
> idle indefinitely.
>=20
> Score an unmeasured PSI goal as not achieved for the temporal tuner,
> so a new scheme can run in its first window. Keep the consist tuner's
> behaviour unchanged.
>=20
> Fixes: a68878f83ae6 ("mm/damon/core: handle uninitialized damos_quota_goa=
l->last_psi_total")
> Cc: <stable@vger.kernel.org> # 7.1.x
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915060937.3423=
-1-kmehltretter@gmail.com?part=3D1

