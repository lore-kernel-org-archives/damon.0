Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078262FC037
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838736; cv=none; b=DveuimekD/FGmnczqMCDNFgImOgERkZv8sgjYhekBE9rfIa7YlKW6xm5BOHnDJuvI/JPcu8NMXVEdKqm7sq+r1X/Jl/9t7fSCQl40u4nFIWdCbPCz6Qip7qesWnFFqWDkUisvp2/Y4vhyQBueusiXDMdi5hRiX93vYNOFv88Jrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838736; c=relaxed/simple;
	bh=M/Oupt3WUWIiJ4S96GOFkMBgOEMrMs2GO8SpZuLNvmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cW4NR5IImaVq2PVV09qAYHEkDGWu1HlGqAunIe05zG+irBzG5AFN7mezT03kVsjKGpd3yoN240UbvVQLHjOoKkd+kiOuozCrH5oEJv7ErqXgFfZZThGjSuvg6Mmey+5+wB7rU0yCRxfv3W++cq9OmrVdCB7vnsVR3v4W1LVE8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgA9Q+j9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgA9Q+j9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C117D1F000E9;
	Thu, 27 Aug 2026 13:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787838734;
	bh=IsXnPgd6RVEEDsA4JMmzIkxIV+4GTD4ySFThJ+vJPG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OgA9Q+j9WuuzuRVgVBY0E0W7hDfNR1Sfcu7wElwzRw5FrnR5Rehbvm10WXCKLGFPy
	 OU6AzBoZ9tuebWkEbFIv/TzIvSrSqPn58n10VcXYVanm03S96G5UaCBtaAluQRjTFb
	 G8pjGEs09R1TOVgzlXJ30WVmyGLQIaP/ilxexgt418Vzrfba6gJ7loUVAYmdYo6mEj
	 dsoKlMoLor17kymLIxU4/qLhDDcH4Cp7sKj1EUB/e2U9FUu7CWkSgNFxdpuTb3RR8R
	 dnCNqWqiwf7SWVi2RZ340E4suGWunKRmzE21eTH3Xz6UyOAs7wJa6L/VHSnLOzud6y
	 9ZI6Wh//gyBVw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 3/3] mm/damon/sysfs: set next refresh jiffies
 per sysfs context
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260827134429.123023-4-sj@kernel.org>
References: <20260827134429.123023-1-sj@kernel.org>
 <20260827134429.123023-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:52:14 +0000
Message-Id: <20260827135214.C117D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> When 'refresh_ms' is set, DAMON sysfs interface periodically updates
> auto-tuned parameters and DAMOS stats.  The timestamp for the next
> refresh is initialized when a DAMON context starts, and updated in its
> damon_call() callback function.  That is, each DAMON context updates it.
> However, the timestamp is a global variable that is shared with all the
> contexts.  When there are multiple DAMON contexts having different
> refresh_ms, the update frequency will be changed, depending on the order
> of the contexts.  When there are multiple kdamonds, it will be even more
> chaotic.  Fix the problem by having the timestamp per each context.
>=20
> The user impact is not very critical.  It does not leak, corrupt or
> crash.  The update will not be faster or slower than the lowest and
> largest refresh_ms values of the contexts, respectively.  The user can
> also manually ask the updates on demand using kdamond state commands.
> That said, clearly this is a bug and can easily be reproduced.
>=20
> Fixes: 9fd7bb5083d1 ("mm/damon/sysfs: change next_update_jiffies to a glo=
bal variable")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827134429.1230=
23-1-sj@kernel.org?part=3D3

