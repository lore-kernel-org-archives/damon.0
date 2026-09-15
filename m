Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668844160F
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452941; cv=none; b=RXy0MdWwkofQHKRDgmf13Gzrq6n3KgceNA/ifURnLEJoDw1rhmd54fY3pYHPGKIjKYyp+XPDOXp1xyoSc5t8p7NHF4f4s/s36hWoOLp5eY6AFiGshrN9vqdozQvlLUHWoHONT4BhyGKFERm21QHqbjzgmzvb5Ja2+vk9YdBNnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452941; c=relaxed/simple;
	bh=7GH9/eighyLvTspG4hp4V/XUggSVcIWA2CCwhiMDfkg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n9HxbFwmcXlw0cqG+cLHEtesSoDrs0eOFk4Ixv3lAbdbKOgUi277I+hXuVobNviOQsOlsDXrdpgmgMt8l/2z11AGC+t+WJlLzn+PC/GQA7E7evRZkWE1ZfKT3SNe5I6QHoLF5qHB2bV9V71AmBoSNtOFm4Le+dSoDWzkAZWvTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B41gvzmq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B41gvzmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C561F000FF;
	Tue, 15 Sep 2026 06:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789452940;
	bh=7GH9/eighyLvTspG4hp4V/XUggSVcIWA2CCwhiMDfkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B41gvzmqk3zLyCgE9upeueyWj81cO9YY5R4nzpw6xxajlyQ7s9BLRP5RTrZPLcvSl
	 owrgAKhEhA4woQaANika1Eeh2fPGmFZdx6a92zuu6MR5OB7w5R38vvqRGd2Undii6k
	 JdNkcrUhNIxsH6O0mXnS03QuNcj2Ifm6sugJvx4H9KKpBsZx6r5PFNfLoaVyk/EAOO
	 d/bGKcfs988x27gU9dw+AIGdFdW/HbIxZ10UJqJ48XXz2b907hYkyoTRdsvTt0r4M4
	 sCv4FVMIs+xHvWRxgpYAwhCb2u5242rPtsxb9YltkWlOvgdPV/J9OJ4NAIXaOiUBg8
	 4UxB3K0f80/Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] mm/damon/tests/core-kunit: test PSI goal rounds
 under the temporal tuner
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915060937.3423-3-kmehltretter@gmail.com>
References: <20260915060937.3423-1-kmehltretter@gmail.com>
 <20260915060937.3423-3-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 06:15:39 +0000
Message-Id: <20260915061539.E8C561F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Exercise a PSI quota goal under the temporal tuner on its first
> round, its next measured round, and after a goal commit. Use
> ULONG_MAX as the target so the goal is not reached during the test.
> Then check that a measured round which does reach the target sets
> the quota to zero, and that the consist tuner keeps its quota over
> an unmeasured round.
>=20
> Without the previous patch, the first and the post-commit checks see
> a zero quota.
>=20
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915060937.3423=
-1-kmehltretter@gmail.com?part=3D2

