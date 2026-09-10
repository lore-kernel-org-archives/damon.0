Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5E4BFE90
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050512; cv=none; b=MUHsyuPrbtHgtPSLhgUVccBmQEGBQg+v6BQuSv7GAsLLhojSFqRGLDTMnWmAk0rfrrpFj9BRVE/yLvD6IFnKdJWXyfTDwixdtZugSDXorWqenrUQG+sGO9+qib21eLM6lgTeqePZrau6Zyvf3hgDNoei7CO0AUM1VQkyL93RGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050512; c=relaxed/simple;
	bh=VBp8j4KDKMi07SQ8j6Nw6T11GT6CcZ21Ew96rRD6b0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dS/QaeR5d27Hr0wuRoUa6mOZbh6ozob6YY3r9SE6TjTSNl3Y1XqWd4feqoxX2CjH7uaZRPLkWl7fF3WM8O7IZbAFHkupX14wd1d67YA6WxNl+hkPhZjGThZhYegHEUuLPRUT52mlW7ty8eFq2Uxl3C80pmAC9RDkv0UrNrMcB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz+rpSeq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz+rpSeq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63A31F000FF;
	Thu, 10 Sep 2026 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050511;
	bh=VBp8j4KDKMi07SQ8j6Nw6T11GT6CcZ21Ew96rRD6b0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gz+rpSeqzdDiPhXv2gvXOB8jP28P27zwGgOkjjQp6AUjH5ubbfDxCik/TSJ3M+DG1
	 NFTo/4DIk6zu31722I9DnDRXIH7sLSHEfpFwdjCNQmq7pj/K3o7b64saGjiHS7eTDk
	 WVtMmhpXsbbPynxOjf8DMVtN6c3ck3R5Qm10M4B06ogfRWdQMKNMjWgWJiPYbJUJp4
	 p1fxxU3L/Wr7eOlYAnGVLxNiYJ9Xj4SClfFnS7FoAmqYQzdAot95my6eW7PpVEcZxG
	 qPQDagy++9KXeiY3EQM8VBffzRfOTbz8ScCeS2dYo+Q1h0s9L7LPAOGq6J43EYnGUu
	 LLEBvgTR/Efpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] Docs/admin-guide/mm/damon/usage: update for
 probe_hits_wsum DAMOS filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910141849.170896-8-sj@kernel.org>
References: <20260910141849.170896-1-sj@kernel.org>
 <20260910141849.170896-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:28:30 +0000
Message-Id: <20260910142830.C63A31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON usage document for the newly added probe hits weighted sum
> based DAMOS core filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910141849.1708=
96-1-sj@kernel.org?part=3D7

