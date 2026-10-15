Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8C4414DF6
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088754; cv=none; b=vCXfDz+Uh9XRFdWx2XiS4C0vVmf8JJmtWu/cszeYLNx7p93CFQWy98O8x2nKbG5CzvJs4KnFRGxbeqIyG1fSS86WMqPLXuqLlYTVrixSJy1UWu9lyeYao6U0UD2tMJmnvZSa1n6USEWAEY3Idc+pBut2aqCNRNvoVT27OcumL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088754; c=relaxed/simple;
	bh=KggVFQ87tJZmDMR5jBL0BGUciCu4EuN1LGshga6cmQM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uis06USMB09M/Y4lHm7VWgTi3/glqX+qQjpjDIghKrsmIuL1uIrppDp4Zmi8eJEApgAlaeAnVjK/rUUTj9tLp+7uoubesdsdRggjq/YopPRtCotwkeGMHwT02dfgCcPJYyk9ZoiYyMBxaFmngM0ADckJlaHhMT6UzSlEDtcif/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAvdAaqI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAvdAaqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D581F000C4;
	Thu, 15 Oct 2026 18:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792088748;
	bh=G19PJQkwopd0S/BCO5Z119xcAcEHbSrhjba7orcMpyg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iAvdAaqI1YK7xEFGouYXLgOuoe20PGCUqBYDtzc8k/xeG5acvKyyD14Zy8mabMuFM
	 2vXWSwnIge8gFxKFGP69XwcMOinyWueXSiLxIdqjZKLpjjlAfwYYj2OKTlkvGyi1hw
	 WzyIoTgDFDRzUtUbvwoiiXhD/+YUTkR5uBG1XhhM6GBaj2of6FYzrNA+rl7jMDtbq9
	 nGqT3flZN5bzaq2HLAJTkPHvLYrO6O7wXVIfr+jK8VidRetjx5iXTM4lS1j42INOhB
	 nYrIJgFvSsAFDNtKFWgMwEhnh5txG6J8y5eWb4ZmwcxdOxThd4PFrgWmS2hJ6z4BcU
	 l1tjOrayhBgRQ==
Message-ID: <sashiko-outbox-173284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/17] mm/madvise: adapt for LRU refs based
 operations for MGLRU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-11-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-11-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:25:47 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> For the active/inactive LRU, madvise clears PG_referenced so that one more
> access is not enough to reactivate a folio, and keeps PG_workingset on a
> folio demoted out of the active list so its refault is still accounted as
> a workingset refault (PSI).
>=20
> MGLRU keeps that history in the folio's refs count instead, which now
> lives in PG_referenced, PG_workingset and LRU_REFS_MASK, so writing to
> those bits directly corrupts the count. The two hints want different
> things:
>=20
> - MADV_COLD resets the count in folio_deactivate(), which also moves the
>   folio to the oldest generation.
> - MADV_PAGEOUT caps the count at LRU_REFS_WORKINGSET before handing the
>   folio to reclaim_pages(). The hint marks the folio as cold, so the
>   eviction shadow records the capped count and does not inflate the
>   eviction/refault counters of the hot tiers that drive aging, while
>   folios at or above the workingset threshold keep their PSI
>   classification.
>=20
> PG_young is cleared for both LRUs as before, so the referenced walk does
> not count stale history as a recent access.
>=20
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D11

