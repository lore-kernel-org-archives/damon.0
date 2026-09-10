Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA023EAB0
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013116; cv=none; b=F5+TuYNJp/yBoO5c6X0u3NcZG0XBZ2YSXqCfI7Mo6ILrTCZz/JaD4HXlcscZkBgf0aq/rkRwT5Sx3gVaUF4zE/aPuW6rY+2cFrz6ojL5wEvZVbh9xeguuByVza8PkiwB8RWPjt5a9ES4XOeK01vOrbf0gDywZfS1/XG0psyfxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013116; c=relaxed/simple;
	bh=Ew9KD7Pa1dXXZ2YQbZG0Z7EVquVbT1E21n2T1LZEc+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kmbJwOUsGGVYXDX/HdbbMHrZmlyDWGlLmAkfe0ZPEHS3sY6T/MTYPozHxOiGTomkKBiIZ3zH0ctYXUi0V/UsEI2+QEst7KD4IQGKfPIprPghG2VD+wiEr9PL9oxdXLz/9VoSh7vk/iVi6l7v2rkl03k90l8lrsyo9BzEEj2xE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBiEQUDr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBiEQUDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4DA1F00899;
	Thu, 10 Sep 2026 04:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013114;
	bh=Ew9KD7Pa1dXXZ2YQbZG0Z7EVquVbT1E21n2T1LZEc+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eBiEQUDrJtn01MxGPP5EnkrsHqs2f1j4Z7rD71iUtUNIRvGiy0brmR6RYNIM46iRK
	 ko+9Y+BXXPMBKB5qQCTScnNbFmGECs3hA5lI69ad8lyZH2pMiug2o0eCusFjdIuEHD
	 YGa1STMeLW86yZy7sn9bm6WFL0HySrJ3573loBEeb+wbC0RFdzH5V0koGfFE8ZW72v
	 rlh1ZZRPsws2m+EzhiisfCgVLFCgBND7gQcqe30l/VJavYF5rVMjINI/33yhV9CimL
	 wh+/sWHIsNmSGoTIXQkYVj4zd3geTZXYl5B0hygkr05x71Ve4CbGDPmygIqn794LH2
	 +838bnSSkLaMw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 7/7] Docs/admin-guide/mm/damon/usage: update
 for probe_hits_wsum DAMOS filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910040319.147037-8-sj@kernel.org>
References: <20260910040319.147037-1-sj@kernel.org>
 <20260910040319.147037-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:05:14 +0000
Message-Id: <20260910040514.9D4DA1F00899@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040319.1470=
37-1-sj@kernel.org?part=3D7

