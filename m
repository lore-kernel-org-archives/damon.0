Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C037204E
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319605; cv=none; b=X8p/IkJ4lxGQZP//69n/NME9iZgSVOcWebZRQFeC7DGIPxJLQnumqJ10Pup1l6NWLYKOXYE9UP4Fxwa1ciUbAIysGa0Oyw9+FeTjUDlkF52bq6Qe4SlFf3gRHm7YV1XUeQsK1Lr8754vS+znr7O3DHAzrIbjexJIyQcNAlGEuu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319605; c=relaxed/simple;
	bh=T9oAejETIGPnjTbRQZA+COfl2vVugC8zVq10jYcVBB8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XxC+JbS2lJLT8xut/3O1QCqsG1wMy36CRgM0VYNJEfaMFaSw6ceuLe9MLrp6Q+BXFalTBINZi6sp7bTqy3VjBF2rvyKWk8pHEHru6eniKKHaCtyBJpJ0aNZwbwSivVXqFhK+GCVW7JoX9jBCNY2eU0/4Ce1Y2B1U6mZoiokSgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZK/qy+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZK/qy+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC8C1F00893;
	Sun, 13 Sep 2026 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319604;
	bh=eq5q0fDF33MCBZKMzGRHFKKHAmSSD0mIvJoQ3m1Ti+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dZK/qy+fR4RFvU41OW2nPgNQmDFsLDZ7kQ83Od2uaI2SgETFsjABMvzdb9CtEijDu
	 D8jXS5S5yFWxiG2f0u1+Oqal/qAbLiLo7LuM7nMA6k3jxTiaf9reiI40qcqwVrPqKe
	 L2T7tOGf03wLha2tKl6L676bcMlSsZeP2FfDAzIvK8aSTYbiEU4UkAfdhiOPSOp6QV
	 odOW9Xoih2Z6rByPUpWlDKkXVPXS9Ux8YQVEJH5FnNNJ1KoF7DL8uMjHufPKZsY5nw
	 9XQim4bbe2vGB1gfBccuyZFw/sTSJrJdszbLCeWdvZ/+DVicSbA/QB9NvrVKBugy1s
	 Fpu/qqbPAFDlw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 8/8] Docs/ABI/damon: update for hugepage_size probe
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171133.102366-9-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
 <20260913171133.102366-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:13:23 +0000
Message-Id: <20260913171324.1DC8C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> For the newly added hugepage_size data attribute probe filter, two new
> sysfs files are added for the size range.  Update DAMON ABI document for
> the new files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171133.1023=
66-1-sj@kernel.org?part=3D8

