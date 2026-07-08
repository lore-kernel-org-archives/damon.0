Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A73D9695
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520017; cv=none; b=jgOSWi/XF7Oyy/6zUJvNOuWOOTLRFq1To/Cq0lMagXom8lHf8JpBCgpLeEzUL/c455ffrKra1BjEdpX18RFhQkSidwtpJON5zcrIFFMKDPxJK2/t+7oZPtwZBB3C1HeqdHSz/RKgz9+IgH2Q80tctGW36iTnY3/RzoarvGtn6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520017; c=relaxed/simple;
	bh=m08erqJDm7lOHsIJ/Rc04iwun/8pqyt9xqN77RLNvqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ImrG050HatAS20qazEADPfGoFZVkNhXMK/97xdeBPsSan679vcSzbTj+CiZaLsX5h6mAPyu83BhF0VqqiLR2xOqT07d/gPPifjYc+HhPxSqgXYGvCL3b/W05Mfmhn7Cglma9/Es5zTRho4K7rnkVyu5iHFSaZ3FhGAupvco7/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsY9m2xn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsY9m2xn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33741F000E9;
	Wed,  8 Jul 2026 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520015;
	bh=8jDPjWyOOb4QDStDfIi5SR7p9VWi4aEjw9Ng7yw4Vic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gsY9m2xnRbhpSC7Oh/7u65THV6FJezPaqC6X+tVgT8SYoh8fCJ2zl6q7u1CNQvVPt
	 Jvnk4GwyJabvYThQTuq8poFkl3Om+aerbZWFX3WBL06xhxETKJdCBHg+8mA8BtKCS6
	 WuwqAj0IjS5dd643BwJRcpBL0aVpzbQjytaOjdCZDEiCE3Q1wm89wRKMTyroSNeWUf
	 y3+0G1UbrvNKhksDMksDyb6eK3VhCajj3Dl5RSRjI93f4PI2JG1Up5DMY5ncZyN/1t
	 F93J6VfUSlZEZ8wLMaKwOaHwBqrr1w1/02HhhtTD7cN+TpWyRqfDc+623eeL/Y2P3E
	 eaj6pVNPCoCWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] mm/damon/core: remove comment and test for
 nr_to_bp() divide-by-zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708135359.122587-2-sj@kernel.org>
References: <20260708135359.122587-1-sj@kernel.org>
 <20260708135359.122587-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:13:35 +0000
Message-Id: <20260708141335.C33741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly references `damon_nr_samples_per_=
aggr()` instead of `damon_max_nr_accesses()`.
--

--- Patch [1]: [PATCH 1/7] mm/damon/core: remove comment and test for nr_to=
_bp() divide-by-zero ---
commit f8fbcab0a03e83756cdeec775b4f0bc25f753341
Author: SJ Park <sj@kernel.org>

mm/damon/core: remove comment and test for nr_to_bp() divide-by-zero

This commit removes an obsolete comment on damon_nr_accesses_to_accesses_bp=
()
and its associated kunit test. Previous changes guarantee that the interval
calculations will not result in a division-by-zero.

> The comments on damon_nr_accesses_to_accesses_bp() and its unit test
> warn it can trigger division-by-zero when the aggregation interval is
> zero.  Commit 35d4a3cf70a8 ("mm/damon/ops-common: handle extreme
> intervals in damon_hot_score()") modified damon_nr_samples_per_aggr() to
> always return non-zero.  Hence no division-by-zero of the note can
> happen.

[Severity: Medium]
This isn't a bug, but is the function name referenced in the commit
message accurate?

The commit message states that commit 35d4a3cf70a8 modified
damon_nr_samples_per_aggr() to always return non-zero. However, the function
that was modified and used to calculate maximum accesses is
damon_max_nr_accesses().

Could this description be updated to reference damon_max_nr_accesses() to
prevent confusion for future code archaeology and maintenance?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708135359.1225=
87-1-sj@kernel.org?part=3D1
