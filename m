Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4574754EEA7
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088844; cv=none; b=nhdPGNKg6oLaupLUelw9TbokeMQ/X5DRuNwc89xPqwgGTKEtOYRTg5TfPlzKSui5XwBF4NPle5rFSZoMREqB9W+6Z26HhIY6r9lGUK9UvBn33suN6Apo45+ltNqDO7We4v+ERqmJz9AHN7mk5ODp+C1c7PKRxHjuVnbXO4AuAKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088844; c=relaxed/simple;
	bh=SXV2VYt5L2/Or2Pf0GxGTH8Cqi83CipT/N028Q2xvig=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nOecYLx2tW1Ta/J5g42I1T8R2OIv9cc3NnOfh+HPTm+J/LNnjmu6Q/pS1FomU4z9EpmWELX58bAxuHHdQgS9uHlfeO603SymuclyV7AWtxb5TNu4rahBCCPP/s9vaJOEo27mAwdTZsW1+yr18c8/I/b6RBeTBm8UlUHap7HRAMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6GANF6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6GANF6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7455B1F000C5;
	Thu, 15 Oct 2026 18:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792088840;
	bh=SXV2VYt5L2/Or2Pf0GxGTH8Cqi83CipT/N028Q2xvig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K6GANF6drZrf5H8J7E4JjlZq0TATAz14OpSdRmtXbtk9cykA44P5x0T/+tR9UQ7Sz
	 6BQ0XWrDeSuF5s4oUjo3CfXoCIloBUjiVI0FbZ7TB7rkLlZJViEPe15W3OHpRhvFw5
	 3fRrFBvikbi7FDOmzu77mWe4bFLIyOl9T7rSn9EvjvA9DeRM9Lwcvx4+2dEVr/wCpT
	 kkjcvJaWBdI5CFp+HH07z6wlxc7DyAIfPePamVQgHbqKOvetGQsWrNnupBEQ/3icB2
	 +vUS056jLDJTbY8fbZ9Vyzs6gtIophRW/O8iPX9tLCpq7nRt7GQsP9R6O/KwJ99Qqk
	 s8XErFCEpOHrA==
Message-ID: <sashiko-outbox-173288@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/17] mm/damon: convert to LRU refs based operations
 for MGLRU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-9-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-9-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:27:20 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> damon_pa_pageout() cleared PG_referenced directly, which under MGLRU
> may corrupts the folio's refs count in later commits. That flag is now
> bit 0 of the count (LRU_REFS_FLAGS).
>=20
> Reset the count instead under MGLRU.
>=20
> Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D9

