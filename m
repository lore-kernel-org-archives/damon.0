Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8E3358B9
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135558; cv=none; b=XW9hHf5aFUleYoWZQMqTd3GeyPt0qozFc/YOi9E8mfcTfK73xfxEpbpQA2YD0UMxMpf8ZY1le9INXQHiGycAVmlFKV52WcKTEohgBEPwd+4Z++Sf5Lw/nlvMSLM3+Dp3yCownlcKTD4Kbds92fCg8xS/Mmv2g+/Jn0L9gQgJW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135558; c=relaxed/simple;
	bh=y/KOiFq4cMfrkslbXs6cqyDY65ouZSXlNzOunUXM4pA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K/JQEtANn/xC/aH7v1uMSQleDLUxhCQt2QxyNY9iFBNSp6gP2BJSzARpySBxKWF4rDOVgEieBJXhQHJr3hfXDI10BLPAmLzQ6GPQzVtgGXyM0yIFA+GpyAc4bO8pesTRUB5j6szm4dJzBrQhXbW9ch+C/RU1xvOdu9COBXrYZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph4qtP7P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph4qtP7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173F71F000FF;
	Fri, 11 Sep 2026 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135553;
	bh=YkNUIN49uxysEx3kFFq5qsfhhuZLOrXc17JlnvuVo04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ph4qtP7PXNBNSawdX6wKuzfMleDQzpoldv58eveAnmxZYBSmcNmy+hKaG7zuUw6qf
	 Ozal/BLDgi22wvLTQHCRmCnEZGNnvhyBJlnEYlPgubN8Jjon9s7AH8Lb1j+fHtdBDF
	 EWtEp3Wn0Qwjd/B6O/Zy04MSPq7a3Ijsz9XHCt7drBcPtuoi45uGJjpT7M2tOv1mfv
	 BaTKJemIOElo1Ex9subpFkMXA8kZyQbZJvgJL+WgtoFIxRPhVmDY+B5zllL4PeRFPj
	 5tNQEKxsoVy1a/h3z5sWS7mpZtRffCScwCuj2o8kOLwVCOLk2EQ79IW4/L4mej54c/
	 yuUnSsYBpgvkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] mm/damon/core: extend probe_hits_wsum() for
 moving sum based calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911135510.96914-3-sj@kernel.org>
References: <20260911135510.96914-1-sj@kernel.org>
 <20260911135510.96914-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:05:52 +0000
Message-Id: <20260911140553.173F71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_probe_hits_wsum() is being called only in aggregation time.  In
> future, it could also be used by DAMOS.  In this case, since DAMOS uses
> its own apply_interval, it could be called in sampling time.  Then using
> the not yet fully aggregated probe_hits could result in suboptimum
> outcomes.  Extend damon_probe_hits_wsum() to get the weighted sum based
> on moving sum to prepare the DAMOS usage.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911135510.9691=
4-1-sj@kernel.org?part=3D2

