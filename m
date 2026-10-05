Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF7370D7C
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190500; cv=none; b=s9d7FZ91GrEn7EeyiVJKPKTV+62b5ZPEkQSUF+Ebmpylo0RC8soO+2GreoLwnbbiyLKaKCmx8zNAwKqvkkcBDCBeytUDG5anPkM5U5Md7e4nfXafRS8ruCRLGFV1Ro0s2HG9SbkeeADwViDxTpb6dYpg/WMHT9vggpP9zLGwZhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190500; c=relaxed/simple;
	bh=Rhc0NVolVOk5d2mpmX+kF+RCDR1z5Xwctw9ErMUH/1g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WlaecxtTCzF5d5+XlM5LlbngTr+Qs4mqC6HqhbBdjXIiyaRemiVSlPWGsOH8GDE6LGC04syoQxyF0CjLubTZeMg3smPfFI+GeL0ZjaEaxb4hu+T+xc2GmbBudgMcQFwTw4LYucbCeL61HJpm5Dzu8rI8ybCIGyjjZ3iGlUZThug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxlOLjVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxlOLjVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD951F000FF;
	Mon,  5 Oct 2026 08:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791190498;
	bh=Rhcf/NaXaYt47WTBntX8Y49h3RTBwgP77gIRa9jUpao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxlOLjVF6AJLSc4pL2xdLb102XltgPbLIzOyi5eYUm3ODUbH/35vQsuBpCXML2JVp
	 xPbQyc+6qKo4ki++9HHlzQfWxPDFtf6kxf6apOApdAukuft9juOc8/Z4+Kcc7d6wUe
	 AmYQrletGueXV50bS1Y2npjkDUUDB4eca8D6wT82IyqV+Sl6JNedzAgfnTD2SrsWyd
	 dGctx4gKDCqDpt+NCOrKVigxJMmposqVO6UxDAvd+hloaGhTzk4oavDK5DM79pYTQj
	 GVG1e9gG+HKAPKdzURlColcZu3XhckgCfWCLzY5lAPsY54WWoixcTXfe4P5h+/sxQ9
	 /053YK1HOeLLw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 4/9] mm/damon/ops-common: use probe-weighted
 score when probe weights are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-4-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
 <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-4-b03452e137f3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:54:57 +0000
Message-Id: <20261005085458.5FD951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> When probe weights are configured (damon_has_probe_weights()), use
> damon_probe_hits_wsum() for the frequency subscore in damon_hot_score()
> instead of damon_nr_accesses_mvsum().  This routes the probe hits of a
> perf-event probe into the DAMOS priority score.
>=20
> Make damon_has_probe_weights() non-static and declare it in damon.h so
> ops-common.c can call it.
>=20
> Scale the weighted-hit sum in 64 bits and clamp the result to
> DAMON_MAX_SUBSCORE, so a large sum cannot overflow the subscore range.
>=20
> Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-damon-perf=
-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com?part=3D4

