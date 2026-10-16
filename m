Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3236E470
	for <damon@lists.linux.dev>; Fri, 16 Oct 2026 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161811; cv=none; b=m+qCk26ldkMrpzVVneJcUTEhVbrkJqy02E/2ZhpPT6xvtt6eE5zSBk4bqUT1qRiLT0yI9X+eJBnmXn8SsG5Yg9dRglYXRdtbaS/c0dQHuN0GYgV8o0xN2VnQQ01xpwg/0sJ77k+CEYY6nMbcre7HNtEdar/yj7fDIPUOBv1D9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161811; c=relaxed/simple;
	bh=FEpOej85a0YwOHzzsWrsCPJAkWEyE6LeK8ybAsVp6kQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eVKytQUV5LZjhhbdG9aBex9MCjd2L8KLll6mqMSOgISq2ZIPnW9S09g/+k33yJuIkiBxlsIh4B3TyCMs32f2xb+wT8Ztt1VFwEfztMUo9Bs27D3mrDuonTpqr4CCOSq27/55RZ69MjHJbk3boKTnfcUsEB4aqpENHTdxz+wjqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXKsSMVk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXKsSMVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4961F000C4;
	Fri, 16 Oct 2026 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792161810;
	bh=FEpOej85a0YwOHzzsWrsCPJAkWEyE6LeK8ybAsVp6kQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OXKsSMVkKRrkAyGZPut/kOZeBahN8O48YIH40jWWvcbSZpGNKi9umrKxfK9rga0C8
	 5F1i5iK8QvwL4EjlBgGpMZ9b+/IDJff9/8gVij+VGUxTKTs5/OEIYqgbWUCL6xefZW
	 QLGCwfj03WtqpWsAfswqw9YhqlZT7fzZ+IFchF5fnQbdynxdV95Qkvreke9clf1nor
	 FOCQ67j/crPPf0r5hAH5s4LHxDRoosOQ1+HXeYyDSgvPvnDgc8LZWgBDvdeW+qzodW
	 +D9UKGpYKAM3xA0iRX+VitGGeK34OTup1HIt3eISabzVur9dLOFa2sLwnC6zzTowVw
	 8aInXYBi6bVbw==
Message-ID: <sashiko-outbox-174473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] mm/damon/core: Remove unnecessary
 zero-initialization in damon_new_ctx()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWRyaWFuIEh1YW5nIChMZW5vdm8p?= <adrianhuang0701@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016143733.320-1-adrianhuang0701@gmail.com>
References: <20261016143733.320-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 14:43:30 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_new_ctx() allocates the context structure using kzalloc(),
> which already initializes all fields to zero.
>=20
> The explicit initialization of passed_sample_intervals,
> next_aggregation_sis, and next_ops_update_sis is therefore redundant.
> In addition, they are later initialized by kdamond_init_ctx() before use.
>=20
> Remove the unnecessary assignments to simplify the code.
>=20
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016143733.320-=
1-adrianhuang0701@gmail.com?part=3D1

