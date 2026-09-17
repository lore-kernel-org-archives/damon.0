Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F4A53CA71
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655163; cv=none; b=QpeGuwlI/4uxUuMB4DhPPewQtMkofp9iQcclfdGUTkMtC9XWq7YAZZTHQOHqozGibwWMtYtCvM5Hm59I3W8QPjZfgCvHJEUyTKFFDvLga66fJH/smDYQyEURNIMY3tiw1It+voaJ819+rCw67DNCVhz0WnRdcdAdBwEAaQfhyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655163; c=relaxed/simple;
	bh=p7c4sqtHiGyPHMsGXb4bXS0kV/VLaJvHfxwqDC/vsfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W6lYwvqr4vA9JvsiD45XKCuV+1QielC9Ptgut03olEgob21CYVx4Ra15MFw0UPEt9x4q9waqwDrJ9OvR31vYSTqcTQMe0qgGXDLO+kQFyOkkiHMOVyUqy/FeSC2vzCPj4Qs1dH+2+CZ2KA0hveubJtH3MB1jTQn0j1Jy+u1llno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIR8pWD2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIR8pWD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3474F1F000FF;
	Thu, 17 Sep 2026 14:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655162;
	bh=am/qXnYVG9iopazMizp0x5W/L9X/7oFhbE9r8LjEYAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KIR8pWD26ktruGeyMdWol4N94bLGd5gbFitWysYaLmgGwUSMpDKfIgJtfg47QmEli
	 8gH+QwpYCd/v60V4nCx3uUdP+3n3iA5IpqTaXgVZ355LydKfvRySWucKJUzD5lyiS+
	 Ks+SR3tvQjz9khjryZviFH4DgT3Ir+ZAZC7ifjpYGCiyf7/ZHiZLQrHDJo+R+cEr1S
	 poDTqqem7rZ11X7CxA/87FrRaxSWYVCjoGrwZE9N43DRWNQHK8fOsDnaYK9iiYDycj
	 aIE9aIChqamtcrc5gkcfua1Jl0gsW18ZKwVN+6SBW7KqBHWaWinHUF+mPJw3ZJN5LL
	 uqTGno0/mXxnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] Docs/mm/damon/design: clarify bp is basis point
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917142210.90829-11-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-11-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:26:01 +0000
Message-Id: <20260917142602.3474F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON design document uses "bp" for "basis point" in multiple places.
> Because it is not clearly mentioned, it is difficult to understand what
> "bp" stands for.  Add the clarification.
>=20
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/107dc6ba-697e-4b25-ba3e-8ce2499cac9a@infr=
adead.org
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917142210.9082=
9-1-sj@kernel.org?part=3D10

