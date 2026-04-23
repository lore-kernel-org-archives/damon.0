Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B03033DE
	for <damon@lists.linux.dev>; Thu, 23 Apr 2026 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971321; cv=none; b=XYu71Fsbc6ATCZ84y5D1MdxMqYNB4DIoj7fYOMLnDJPduRTiOOuiP28c4BwunhbXeRw35CIjLFtpA1/BRcqhFQjwhj5Q5T8Sx69F5Dt/KcF1J0xZzdoyf7UwxUXN7FA6DuChIr563xOaeHR6rSoLoXOtjn5LBR25AaVIjaRtW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971321; c=relaxed/simple;
	bh=bpBONxt6+MwDToL2TcBk7NWE5qUqcDNiQ/EKUiLEf4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LjdYH+NpVJAmbEtRqjdDju56NRiwU1UPpd7lEJYboUQhUDUOudeQBsl/308UiyegdZxjRA/OQw4C3W/nfV1tBfv8MvZdzZrv6YkICv0tqyk634aGqsa18cGK3ZJPSpp7aua6VNSm3WneimRJOV4rjqKMCitAo8PCLwzczl5PEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf15ehp8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf15ehp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821E4C2BCAF;
	Thu, 23 Apr 2026 19:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776971321;
	bh=bpBONxt6+MwDToL2TcBk7NWE5qUqcDNiQ/EKUiLEf4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Jf15ehp80LMvtRiqY80JwhVuKX/QbHNC0v63VHC+8ShEHXn1yfgNDCd1jpDzR1BeK
	 lBbcxxJBYZalWyGC2BekBJ2RFXj5/05ToKdbM7GfmattVPBheYkM5xGNFyBG7uleeh
	 sl0zquZDfnilnblay1Dx8Ngas24LiHh/qf9fxZ/AR6ibybwzL5Pei9x3WFHceLS3JH
	 k/h0u6zAy7FxHqXrplctlDckOeIQiUY5OaNVqjKeDlVZ0ogXgmftiF3WujCAcJmFBX
	 p4F5Dfmv1upxi66n6VEUk83xBTCe20S7bofbKh86gXdlouX9sX+iyhxoTlbfUvqNcD
	 ROCFoJjt0Zuog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon: introduce damon_rand_fast() for per-ctx
 PRNG
Reply-To: sashiko@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: damon@lists.linux.dev
In-Reply-To: <20260423122340.138880-1-jiayuan.chen@linux.dev>
References: <20260423122340.138880-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 19:08:40 +0000
Message-Id: <20260423190841.821E4C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [High] damon_rand_fast() truncates the sampling range to 32 bits, prevent=
ing DAMON from monitoring the upper parts of memory regions larger than 4GB.
--

commit 094f8506b34920335d2088d576411d78378a8a58
Author: Jiayuan Chen <jiayuan.chen@shopee.com>

mm/damon: introduce damon_rand_fast() for per-ctx PRNG

This commit introduces a lockless, per-ctx PRNG function for the DAMON
sampling address hot path. It replaces the heavier get_random_u32_below()
call to reduce kdamond CPU usage on workloads with many regions.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index f2cdb7c3f5e6c..0afdc08119c8c 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[ ... ]
> @@ -843,8 +844,35 @@ struct damon_ctx {
[ ... ]
> +static inline unsigned long damon_rand_fast(struct damon_ctx *ctx,
> +					    unsigned long l, unsigned long r)
> +{
> +	u32 rnd =3D prandom_u32_state(&ctx->rnd_state);
> +	u32 span =3D (u32)(r - l);

Does this cast truncate the memory region span to 32 bits, preventing the
sampling of addresses beyond the first 4GB of a region?

If a region is larger than 4GB (which can occur with large anonymous
mappings or physical memory ranges), the explicit cast to u32 will wrap
around. For example, a 5GB region would result in a span of 1GB, and an
exactly 4GB region would result in a span of 0.

This would cause the PRNG to only sample addresses within that truncated
span, leaving the rest of the memory region unmonitored. While the previous
damon_rand() implementation had a similar limitation by passing an unsigned
long to get_random_u32_below(), could this be updated to correctly handle
64-bit region spans?

> +
> +	return l + (unsigned long)(((u64)rnd * span) >> 32);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423122340.1388=
80-1-jiayuan.chen@linux.dev?part=3D1
