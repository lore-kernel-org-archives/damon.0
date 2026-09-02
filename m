Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6AF3859FC
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328973; cv=none; b=YjQseK44ziEfYf/AisQmWI7r1WTo7cijttCnab5ppwLagVjvHEyxQloKmqXpjnOJp73kLti8+Gdjq6o7IUrAE4pA1+Y+WKFtz6F0q+HjOKgbrQ5D+9dUFfUr8FwtPiN7Fim9BjucSIX3WINcJ435CZQCZnwFmSBtdIu6SdBOKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328973; c=relaxed/simple;
	bh=0WCqVlfx7s71XpnwtmIqEjqrLqXCQwdTPlNsEJ8p/ag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u38rK4LI9cWOqd7yfw/51ua+tV2YlCknIggf3z/INTF/BYODKyAtQot/Bredu+3U+a4JBGIsKgRI5QsQxv2UBR4tVoVrIbllRi/v0LH4Z7l5nU8hHo08rEifuXdfDOkNgmA5ak4P+mAlPXQLneeku8blxWtKayEyVbOiLpG+Sv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2dUTFIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2dUTFIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5711F00A3A;
	Wed,  2 Sep 2026 06:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328972;
	bh=vqr2JsarG/3Ap2qTym3RUaW2vY21bSnPJE1ufHWLIGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A2dUTFIowlVxwQ8Seu10L/zGsYNwdRbAfxK3lkOGEnGImFnKUN1+utH7a7CsMVvOT
	 yYRogUCxtoiYAi3XosnZqB+YTTbbmd+Ui8fPJK8/ITveB3I07aewCpZre1VYCKKx4+
	 ET8VFEoGivnLiaANJCMGWktmu/9fw4iVrK7cqKNXbaWlqINrOumgIRiHy1Vbc9lM7U
	 gEisYuSqlawDFLQq+QKynSYX2trEDStzxuEpVnYU43ETt7UVz6PCMtIkT/37YHP8Jo
	 +LBfYgyAEpKPeNR026KnOM7jDbpvoD/GOcKdwfHDYbTBU+JMvaMIiJNxHG4xKp00DP
	 RCdzoTQdPI+4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] mm/damon/core: validate number of probes in
 valid_probe_params()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902054747.99370-5-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
 <20260902054747.99370-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:02:51 +0000
Message-Id: <20260902060251.DF5711F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Each DAMON context is allowed to have only up to DAMON_MAX_PROBES
> probes.  The central place for validating DAMON probe parameters,
> damon_valid_probe_params(), is not validating the upper limit, though.
> Do the validation.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902054747.9937=
0-1-sj@kernel.org?part=3D4

