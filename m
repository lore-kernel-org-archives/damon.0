Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B9558FD00
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655354; cv=none; b=OF7au+9GEWo0+MzDc77wQVUQUSZLRM+mdfC3/XZpZxv1CU4jroiZsdMisyYab9QSpcbjPOC7e/+yZpYtfrm8O6UuuVr4H1hGS97xd6lx1/R6RiV7bRx6q0aoI5A/T+oLAlRs2N7FhGBAnZcOHpBUAAmdeh4s52EED03eIHmLuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655354; c=relaxed/simple;
	bh=4LQwynQuWXkSgLfRcpqqvYT1wfxx3P9crY0UVZe9ABY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I2UUNYsmhY37U8tVon+JX5rOuoEcl81/MJW79KWh41aiHjylQcI7BvdtYRmgmsqCeehPchdLHGVNC/dlc9m9wYNSI0/fdQQnzbFCgmK6COFYPmkADwPbsLg795fWHru0mKjpJPWHvsDjsiEqNyVgb6V5lSNLvl732b937N+F9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIoBq0V6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIoBq0V6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095C71F000FF;
	Thu, 17 Sep 2026 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655353;
	bh=z7AWmY2GkCLitTvPSdTo2VzZmoyqYddxaWF9Yan9vss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fIoBq0V6o8vVUr7AePzdz5FOr7U78D8txfn+TDis+vUf5kLGI54AuzEPc3uqzddHx
	 aSWYNrHRP/b6slkXKQ+NyLwMrP3FnMbASD/VOWuEMUe3b/hpDv4LpsCZ+xh77CltQe
	 R2Q5vQHvslIXBr9maFGxP9tCUcLEftcX20Em/zuJK+yJxw7ntcf/p9KyM68R14lcJA
	 7CkCTMstTlWEyZnUXdQSTgCkV9ExYc6esQuR3BHwsSsqqr0udFtQ2ruaKRT87BPqfY
	 kPQWKybvlcRIpHsgR9Xgp77dX5ou/hJgGODREq9V133K9LDw5Q7KOJqETiCDGvnIIg
	 MJGcXEGIhYwSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] mm/damon/core: set
 damon_ctx->walk_control_obsolete in damon_new_ctx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917142210.90829-5-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:29:12 +0000
Message-Id: <20260917142913.095C71F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917142210.9082=
9-1-sj@kernel.org?part=3D4

