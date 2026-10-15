Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB4438238C
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089029; cv=none; b=SpthnI6IC3Algz/ibf0eCSWY1m2/7xM6PJuADYpCnhWMava5z+7k5H80qXzxfmeMuDKyPlIENbt/Ls/BzzABB50ynKgBpkKYV4Gtwrhi998iOiLdD2J6KD5ECRjfU3Ah3PNai8L8ehO/pPwSpU8+xRjNgier9JxssSQ5aOP3rv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089029; c=relaxed/simple;
	bh=Rc5hvdjXN5v2GYEBfzJU6hozkPcJ7cKKYEMAljU0/so=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BQLD5hIZREZMVgFxI0iJptI3VouIn0paEPVfzzWn8Jb7DKYxwl+55XgxfFiIFD+RNpoJWPIQQcq7pjPUfRodZKV4dv8ijJHv7NTJ2F7FP4fUaHGt+qV8huMd9j+9jnHAa+J5Hs/FQnIyFESQ+0l9/Jze/T7DDE2uogzkjoOXgTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7A+u2qr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7A+u2qr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B3A1F000C6;
	Thu, 15 Oct 2026 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792089024;
	bh=IYVrgEYV4LvVMu0GaYKDw/2BI1zhMmlPXA1evpaEqkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I7A+u2qrbppwmlQm0jkr82IbnK2hFxxuDxm1UFYweFAO3GJ8Vg1Kss3h9F0GJ/1wn
	 zpA9411Q+9ebPzpeK5V+kbFAgyJgJ4y3Cf77yMsSJXJDeDFNIOQK2Ke8XNaqZQrOEP
	 a5My442BGdQXoufAL5FThDYSU8FSU3fUcDG5BQlmr3wMqme6ET62/OnxlBNgX2U0lk
	 OSylfqzHK1YVojlhyhETAbInqveNWjtS+60dh+g9dzdfhXo5HFFHYrJuB+OLHNFDIj
	 SUjBS6KQ+XTrcpayQJCyPZmL91JxJgOrjl+caZgnSxChQzJ9TCfoo7bywgQ8NegLXz
	 gYyFbQNsud4pg==
Message-ID: <sashiko-outbox-173299@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/17] mm/mglru: make folio lru referenced times
 count a generic API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-5-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-5-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:30:24 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> Pure code shuffle, no behavior change.
>=20
> Make the folio LRU refs helpers available regardless of CONFIG_LRU_GEN.
> Without MGLRU the refs bits are never set, so they are inert.  Move the
> lru_gen_* helpers into the CONFIG_LRU_GEN section.  This prepares for
> unifying the API for checking folio referenced and workingset status.
>=20
> folio_migrate_lru_refs() now migrates the complete refs count,
> including PG_workingset (bit 1 of the encoding), bitwise identical to
> the direct copy dropped from folio_migrate_flags().
>=20
> lru_set_refs_flags() skips the nonexistent mask bits when
> LRU_REFS_WIDTH collapses to 0, keeping the generic helpers inert for
> !CONFIG_LRU_GEN builds.
>=20
> Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D5

