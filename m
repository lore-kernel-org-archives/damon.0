Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7551E46C4C2;
	Wed,  2 Sep 2026 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346845; cv=none; b=rCylKvemaR4OoVkb2ZV83qa7iGKLUO/h82H5b6ZmE1jAveLtx9LbgRtM1ArJAqpLYnC+qVfVC6xiljo+3pUj8gstg31T40SzY2+c/uzQUXAxcsGHlbZjAGNMeAvSxwIVKpkriaNSFcq+FoKtHL0a/Db/8t6C+QUSYAXTXBGXLLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346845; c=relaxed/simple;
	bh=W/oLfg9h+r2vmGTsRj02d3UTlghMHxeJO8f3cyvk4xw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DItY5MFqoEq2pvMuxpLijF8yR39GB0ggiRsnz5NIBlV3Nv0Xw20ZjhRf2czbnp/ZbWZNJKgIItD26U4EAo6e5M3013bWharbXHI2XxKaUS5HKE20ZxpHbLXNWuaHNE8GWUq9hHnQCJiD0E3e2A9BjHb/jVQYvRWn101IkVh6tkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXMmq7Au; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXMmq7Au"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D51C1F000E9;
	Wed,  2 Sep 2026 11:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346838;
	bh=W/oLfg9h+r2vmGTsRj02d3UTlghMHxeJO8f3cyvk4xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IXMmq7AuDoj0kK890IZbtWK1zUvVxvh6AyF7YLP1iGu6ko5B0+H2VDgamWIpB/nCU
	 bbApycJYA/PVuH9CToO1Vp3MZ/ffPweYg6xJOCTIzz29RrFvkCv0o5M8fbnFYgZoJv
	 O3R/VfR6leujCScKeveV+uYvODth5HbNgOPbeHmT6XPnjYI8YBh7BMvecTcbzfYWR/
	 fPo9KgfLZG8Cehsu6muH2TVuObEkp2YDOY+INGimJLFhaS0TLCkpIYsn2jkX5K+InZ
	 dDT4b3AuouooQE2ua3esduHPck1TOfM+zjI80kfoAdg4d7Ffn0OO6tXRmLqeqsmdvS
	 emueUmbAFN8Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/11] mm/migrate: move LRU batching into
 migrate_lru_folios()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org, dsterba@suse.cz, "Chuck Lever" <cel@kernel.org>, damon@lists.linux.dev, "Jeff
 Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>, linux-cxl@vger.kernel.org
In-Reply-To: <20260902-migrate-refactor-shivank-v1-8-9dcca87669c4@amd.com>
References: <20260902-migrate-refactor-shivank-v1-0-9dcca87669c4@amd.com>
 <20260902-migrate-refactor-shivank-v1-8-9dcca87669c4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:00:38 +0000
Message-Id: <20260902110038.7D51C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The NR_MAX_BATCHED_MIGRATION limit is specific to LRU folio migration,
> where the batch engine can keep multiple folios locked at once.
>=20
> Move the batching loop into migrate_lru_folios() and rename the per-batch
> worker to __migrate_lru_folios(). This leaves migrate_pages() responsible
> only for dispatching the different migration classes.
>=20
> No functional change intended.
>=20
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-migrate-re=
factor-shivank-v1-0-9dcca87669c4@amd.com?part=3D8

