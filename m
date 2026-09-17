Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2995724E4C6
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 04:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618410; cv=none; b=gdw60Xq2p5f8g/bh63hHgx1CuLT8wmYEEiTmhWuQ/fTa8H0SiWRmnm66UrB98LysyKvxe3by5A/hUBUHLVfOuk/gE2vsba2FQjKg+FxHNjLg7eHoIljACL9cCZpqtYe8yB0uoi/rtDQ/57hWcP/54vIV/e6SRuunG1u+B+xSLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618410; c=relaxed/simple;
	bh=qAjmzQOkudNDEGTZ1QxXxRznb+lc5DGMJhwArAn4v2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CPm4kkngBpI2nF0jThMqPIJHNqMOm1t1V0OzjygIacKL3lWECE0k4pnIGyg8/W6PiiETRDfAaoplUwkTQ2/bTtC+ztaaVYUo8PGOEU+SPR+rZh46RFat26qKTEPsq/tvMGfBw5Ck4o0wZhu6Sjo0/9euS8KBEUFrFH/ft+oCags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxPz/ppx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxPz/ppx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E751F00898;
	Thu, 17 Sep 2026 04:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618409;
	bh=qKssEIGWnmjPYyz6xTJmEXS0aqDYDt7y6eeMFQy9yqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fxPz/ppxuhh/3KcxzL2QavW2ctNZAWTlZDCeoI5/vceVteHNnIfCFv3KszJ+M0ypo
	 Kb4rSE8lXmV/3o0Wf3+tTKtgF7dCCMU99pdeQaJ1Lnr4DA8CSfAakVUD36JvT1vReU
	 w8PVys3GU/rFvvif6uT/yJdh+r41Wzk1wqJmOL13PUvAILENc/eUm8160RYoiPmQ4o
	 0VwQNcL9CSE1HnXNabudDKycEZViDjqh8G9HYZpGZUsV0T4pLcNg879JwBuqavront
	 dQYItg70ZuoZX3aFW4ryMbfAMTJHI7Vw7bEFNozwqY7VrsaqASNvjseshZe2Ci0/XW
	 oSR5pc/VvLcQQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 04/10] mm/damon/core: set
 damon_ctx->walk_control_obsolete in damon_new_ctx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917040537.107341-5-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
 <20260917040537.107341-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:13:28 +0000
Message-Id: <20260917041328.E2E751F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_walk() should be called for a damon_ctx context that has
> successfully started at least once.  That's because
> damon_ctx->walk_control_obsolete is initialized when kdamond starts.  If
> the rule is violated, an indefinite wait can happen.  There is no
> existing violation of the rule.
>=20
> damon_call() had a similar rule, and it turned out keeping the rule is
> not easy for damon_call()'s case.  Hence, commit 8023b5f47e09
> ("mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx()")
> added the initialization in damon_new_ctx() and removed the rule.
>=20
> Keeping the rule for damos_walk() is relatively easier.  But having
> slightly different rules for similar functions could be confusing.
> Sashiko, for example, repeatedly asked questions about this.  Do the
> initialization of walk_control_obsolete in damon_new_ctx() for
> consistency.
>=20
> [1] https://lore.kernel.org/20260915011614.102342-1-sj@kernel.org
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917040537.1073=
41-1-sj@kernel.org?part=3D4

