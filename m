Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC295135A53
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787019100; cv=none; b=lIA9Q6raeMC20Kz4bgLtxe2ZNOwOhGZMnBzm+TgEYgtMapI40zgrOV6AoAISL0dHVNHrUJEgJ8NihMz0kDSIWC+zsumMgn5K4Isbwkw4N+u/fYe98F85hThgOV7mkNkzps9yOB+l2W53QEWLyiAacBqRXIzA3GKIfyUO6u91UgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787019100; c=relaxed/simple;
	bh=cBiwTBZrAgukmAmaLFxBjWKI4vo35hmU7XEgmsr8Wwc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sz/Li1nloNEmyzbnkbBFS4ufyhfEq7MEfZ0OhU0J6Qq++dPbKSQwnYWF2U97Uye6i+XKmuLaKRFrmTDufN0Q3UIEDY4282bXygRV2gho3tvtikrmD8mNEO8ZX4pDn+ylbBkWEjvxHZpz3vNIQn/8L1a1yvrs8g9hna6cfJGcvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVTDJkWE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVTDJkWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6671F000E9;
	Tue, 18 Aug 2026 02:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787019099;
	bh=/eH/183XRnBysgG3pNNZhtR5jAbvv1qjvMXgsFDYDtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XVTDJkWEh2QMoSdsT7qUlnIpo0Z8hNq//+B8BJFQ8sl6dEot/0XxY4m4MzTNxVc1J
	 EsUwZKYLWXge+p8M/Gc/vzIPP3j9SITcX6qBn1MtCObsAPULspZhpc4rfk0du4y5Tl
	 7BZUJiLtmjCHeHHGtzb1UW2tEjhA6xxRTs4FJr1ZXcmYhakHMbfVVtvoAmhqGYNYtm
	 3AZNOjW/fjDnNtDSNIRxLjj5mn6cviXf2IXiqrmvb1eZ18thqt/etNvJrTrAxgn7FO
	 /SF7P1swCHYv8k7LA2FssWI0epJOP2nm30Hq3t83qDMbGviPD1Rz7d7bHed1Fy56jV
	 SD6jLz2gXvxFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/ops-common: factor out
 damon_putback_folio_list()
Reply-To: sashiko-reviews@lists.linux.dev
To: dayou5941@163.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260818020650.2844354-1-dayou5941@163.com>
References: <20260818020650.2844354-1-dayou5941@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 02:11:38 +0000
Message-Id: <20260818021139.1F6671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Li Youhong <liyouhong@kylinos.cn>
>=20
> The putback loop is duplicated in damon_migrate_folio_list() and on the
> invalid-nid path of damon_migrate_pages().  Factor it into a small helper
> for readability.  No functional change.
>=20
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818020650.2844=
354-1-dayou5941@163.com?part=3D1

