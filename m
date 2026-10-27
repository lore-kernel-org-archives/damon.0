Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084686;
	b=faJBJewItuEXheO6PyPwgbHL5Pez471xtuxDIRL/1Chq8OD0ReXGMTwcjPsP2Oqai0H5
	 tj9bZ56ArKqBuFEl/ZAWVENMhXSKzK8IB94Jvve6PGC4s7AzfAtejieKS9TgH8twmIxsp
	 ZeEcmwtkJNwzHRGb+5DgvDq8+CjDn2TYjs6Au6bgpZORlcHYG6uTTTT0qyMfR5KYuwOdH
	 aUF65JaRacr/+cAaLOqZeSTZaS3RcmqYYraBvLUO8L6ajLz3Ec+Ve74AukrUKeh5VcNaR
	 YSXgboXeAL/5IHIX2kvA0zOVK0ZDdlqH3XKVxKnidvuid32J9P6MZ2iy/V9U2g6d9CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=5Fl5cl1odyHR+Q+dHl3S9B8sfH7/8NbuHWc+9QJ6hEU=;
	b=1BWUnXryKKeTUE7Q4VLyUV1uhCB44YskT4gOljZa4bmolkmk/yOCGS7FAAUBDj5FHA3g
	 BpKga8sqfYf2F1ACWllaHHePAPgf5QTyoPljaEOh09fEksv6btBn7fC0/fyXxE/tvKmBg
	 xbDog/0CA2MkeVkaq5NL69dCHr9c6Zuk4wlAasSJ6Hk7e9wkUGaMRGtDVUftOViGkz9fd
	 89Y+IL6BZiBesh1mcgCgksUoVKk8J63P9RnYphNcRWUGEKzD8qMDZwVYdlKXQb3bo+K8w
	 61QAGPtjnA4oqv9e2IT1Rkd09B5alcE8Bmrb6fqqopgFDt/6QewuWzdV6U1DVmkf67g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V7oRK7RX;
	arc=none smtp.remote-ip=209.85.214.194
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A989F606A31B
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 07:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A989F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V7oRK7RX
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2e987b4a710so2842135ad.1
        for <damon@lists.linux.dev>; Tue, 27 Oct 2026 00:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793084685; x=1793689485; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Fl5cl1odyHR+Q+dHl3S9B8sfH7/8NbuHWc+9QJ6hEU=;
        b=V7oRK7RXDuCqcHtxh6bFg5oSDyxlSDNwOe3c3g4aqg929l2MkRvTqSQNVHJace4Vbx
         CkpVcgurHPjenIkUz1o6zo0F5B0dfq7nOMt5EK5gGh7uWQruUmOlcwSDfIbFMn/R9sUi
         juywrqWXKV/SQUL64QtiDESKcMUTQoDOTbkOnPWHXRRo+G90rCKHDXg+c6uZ6yiRJ4RT
         C4h8QK5uKpGZbZT2vqTtvJHoqqzHGLcnbMAqNwBriIbBaADBLn9YOI62AubKCZlq+o5U
         ZXmv3T4nErkNR00gEQfvnb0hauU+H9PlGexEkCH19DoiQLlJ47O29KUYyEssU7Egs5jL
         lI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793084685; x=1793689485;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Fl5cl1odyHR+Q+dHl3S9B8sfH7/8NbuHWc+9QJ6hEU=;
        b=TA1sk3BrZPdN696kHcSEtCzC5QvbuvShLqTTFuBVlNKNlN81+v96vNi4pm0eUIcFEI
         iqHFWAxByZrhtIbMSdDjOGcOnvTrx5fqY/tz3ACRi7BpImPWColcL8Ry5c9mSBTxujkz
         H5r+X3FeyE4i3c4X6GijKIWdAtoWx7ZQQbEzkvaqZumHTy2cDhhgcQDRvCvN5kO/c70a
         kk+rdqFhMYf1IDe8X/yc4f1rKabGsYHT5HFm849fepH/rALAAjgCiPc/7KciP4yh6bup
         Wfn+DS7+aTf2ZHiiKn2DGStpW5mn7CF0cv0BFSqf/eeWra2r6j4kRUie8hq2ZYM496Xb
         8XQw==
X-Forwarded-Encrypted: i=1; AKwUvByAjC6S19bHkh/iMGTKjVGDhK0x9dFWOxHU+rUfAOdgmvWxFNYMFkg0PfwEfCRCfSoSI3b/AQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJGBHrmsI3cPtQIaI8UX/QrJ/Aq1NaNt9gCiC8v0GeD23Z7A3C1
	d1TG9CYkDBmiW+2vPWAuioKzzHDZKRqgvaAzhboPb8ZAja2UhCdZmYJx
X-Gm-Gg: AYBFou1bXVNtbUU2c97YTZjmiwcFMJb3ZgXTg6rnrt/6QEXzNShTs0lvX46cq6lr/w7
	uZK3wqGl4fE7LJ2iB/51ec7mPLJuoR59E7EVAKhAk8eNVXhyu5/48lXh38oE8tFPljZ+IYzepiI
	M48AgCsHzd2FVonmqf3spoPn68FEuWJ3/F+odYXgy0o4FaSetVp2+GDLLB3B9sJqF+Pbmw6XT3t
	QgycGecUpnX8oDPrVObw63LrFoOC9iXaVJnATxKST+2DeJYO1vpwXeI7UWgB01CS10fE+1Lk3ai
	WbEa6iMUPQhdz0E5JL9k1TQjUqjFyirKWkK9m8AvAw2lBrgeHEVEtMzK9M3CeJu79Ks7yC0hT6P
	p3v8LEOuSRDEtz1nr36MRsa6rB/SEpnzu3v43q711x64O/FN8JQAdlLSSDZieIYbn4/tiZH9DJw
	rK8GgyWrbFnIkZWmBz6BQeRVhJCOA1fZuaLTWzgZK/pEDSl+GYbRUBf+R+4UtorQnTQHVuxUkH5
	AEv6+zxg9jIvR3Q9dR7eLyge34XcN1Y/Dng+QgwTAH8/Pl2p2q2dxY5/va28wGQ51HvYrFOwg+z
	GxbJShXj7egWbPf7391aYc1B84Y+U4B3nFIX8muYyfWmymsQurj/
X-Received: by 2002:a17:902:f541:b0:2df:34c0:72fe with SMTP id d9443c01a7336-2eae402cc5emr11077445ad.35.1793084684710;
        Tue, 27 Oct 2026 00:04:44 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b7a69csm4484635ad.13.2026.10.27.00.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:04:44 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: Daemyung Kang <charsyam@gmail.com>
Cc: sj@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
 akpm@linux-foundation.org, bijantabatab@micron.com, ravis.opensrc@micron.com,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] mm/damon/vaddr: preserve migration weights above UINT_MAX
Date: Tue, 27 Oct 2026 17:45:52 +1100
Message-ID: <179308355214.2.6632342460755510671.damon-migrate-weights-review-draft@gmail.com>
In-Reply-To: <20261027035431.1007584-1-charsyam@gmail.com>
References: <20261027035431.1007584-1-charsyam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi Daemyung,

On Tue, 27 Oct 2026 12:54:31 +0900 Daemyung Kang wrote:

> Sum weights into a u64 once per migration walk.  Keep the existing
> 32-bit divisor path for totals up to UINT_MAX and use a 64-bit remainder
> for larger totals.

Tested locally. Looks good to me :)

Tested in an x86_64 QEMU guest; both the buggy and corrected behavior
were verified.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
