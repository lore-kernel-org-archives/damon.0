Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6905908A3
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655212; cv=none; b=rizlRfcKAawxi5VI83PaEiIPiloUxG86JjT1IhdEcM0Ng2h2QK1QIqOzcaQQAQae4qQscC1f57bpWcm4yCcVmgSWxZHj6EqlR4crR2bv3HaqPpMwhXaIjwTme/upeR8FKGIbSznfcum1/1YzISRnarq6Xo9MPtzPlkUMtVJggbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655212; c=relaxed/simple;
	bh=XXipqus7daTCtNsvLSKu9gAYH/aCrVsugHF/OBLc9s4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hs9rq93zdctQABEo4aas0sNQOjEjFoHihM8C9IXkXnlEWpqYpUNBldBBvp+gfbekVJxciok0cKwUdqnHF+KUZ6kaQMlq3LZagPI7lJX9JUAQClzE8HgyDD9/ainrLfeG7N1sCn77VgY2MTs14TVOFCcSXiBHi+vQJdqbtA1xjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1z8GE0B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1z8GE0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CFD1F00898;
	Thu, 17 Sep 2026 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655210;
	bh=fbw0WQwDqdFydb1LWrY3rlTWT0m7svcI3k9I4BxFCl8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H1z8GE0BGZDd/+PE2tXFTGEu7vuL2/y6KEUcZVWNHSUYDVhdsjS70cg4qJd4j50P8
	 d31QZYSlVgQn3uPBvUoh87QAksd6P4WgSOblvrPXfRvqHaN1Y/CGyJUSYPQuK/XwyP
	 2TiNVtOjGySJlirrukcZb1enOfKAG+HwQxTH8XF/tfFGrE6/KDjuTvWo62HYrDazF4
	 4YsyOmdtcEFtT2LygOwrAZJyE63mAgyYAvgSC7jeu7rcirNJ5ijq/WVlhyrnzl29ht
	 sw1/5GtOPo3Q7F5sb/MH6Mp7rMA4Fb53aqDdceaKLIOCsGOu7n3zfoeKWunCTha2oQ
	 5KJCn4A7xOFSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] mm/damon/core: document
 damon_call()/damon_start() race hang issue
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917142210.90829-6-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:26:49 +0000
Message-Id: <20260917142650.22CFD1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Let's suppose damon_start() and damon_call() are executed in parallel
> for the same DAMON context.  Then, damon_call() could show
> ctx->damon_calls_obsolete set while ctx->kdamond is unset.  If
> damon_start() sets ctx->kdamond before damon_call() starts the
> cancelling, damon_call() can indefinitely hang.  No DAMON API caller
> does such parallel execution of damon_start() and damon_call(), so the
> issue doesn't exist.  But who knows what will happen in future.  Add a
> clarification comment for caution.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917142210.9082=
9-1-sj@kernel.org?part=3D5

