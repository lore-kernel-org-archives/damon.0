Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461053AF66F
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237683; cv=none; b=Tu3+q6J7iigu2AFq0K7vzWh5GbAprz30ejG+/FLGREvkSGQUkhkRGuSz2rJ5mqfPeHtFSKbImf0gCGgNNnXnRtpuef/C9yRKGd6HIt4ZUWyIbSBgvL47xlBB2+vZS09FHqKQeJ5IdNxZalk2t6L37SUV6tGyqMesft3wuI7Ysqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237683; c=relaxed/simple;
	bh=d0rSZZSc3lS+QRMWvpNMFoGSUcX39sOnbpPAyrjMpyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TUCM6Aw5T6VphxMKrbBBoq64yslkC3PqnbMDgH4k/63uE6p5TcKoj4hC9CRgl2FbhRkfleDlhJOysVW0WcOIxSh72CodPdD8C4tV8edckXbpXbtQLvxEeOgrRB3MjpOYzVTmZiT3anlqw+N+i2KNC+hQftE7iGkC38STl4101eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcaPgJD4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcaPgJD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820A01F000E9;
	Tue,  1 Sep 2026 04:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237681;
	bh=Gkmz5FcapO4KKToknTxhrxNNDtDWSc1qQsucDlhpogE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TcaPgJD428wfwrvAYWXlFPC42zgTiHN2m7oHZNqpacLxRQiojZaygejZUNUeyXij3
	 QV1En+0OPYMJdT/otmFORV4zP9a5XzujG3arszPDfsxE6jhS6mTyzcQGLSb2j6IMmg
	 N1TpGndz20OUX5YP4YH7hg8h3nBm70vf8S7e0w8ULruCs2C99kUGmbCsNW1iEsmYb7
	 8pASHz3qe6wCrgd13slLvpWlFAGMr95A8FXn41jlp9/ONSakiq+F3ssf9wSd0pF8Rn
	 jMClW4XN6W0mXfu6PZwCjvwfLac5v4qxLmeXyvVA5wLijKrePaOXIiaPnEt/99JNvh
	 tsVjukxI+eHLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/17] mm/damon/core: introduce
 DAMON_FILTER_TYPE_PGIDLE_UNSET
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-2-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:41:21 +0000
Message-Id: <20260901044121.820A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Introduce a new DAMON filter type, pgidle_unset.  It will match pages
> that have their PG_Idle flag unset, or the page table accessed bit set.
> In other words, it says if the page is accessed.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D1

