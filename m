Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480D4A92D1
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363147; cv=none; b=QYIgvrIafUgSJuf98H4qw3mwWv8b+Lqg7RL35+u/Hjo2vU5zKmahLoV8fEGppw5MI5Xf8f1d4x/kRPjBixHE2BtfHj+q5UcMruTgxkaiqeVWVJfwlNIZl1Mxrq8aaVWFgq9AGuux5CXwCUX4fzdxZ/aSUtLN4q9ilcqKxzI/lVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363147; c=relaxed/simple;
	bh=qLHWnBEOFjUrpzfP4yE/vh+2VmaJi14XWXyewY/A7BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlVNPeg6JKdEK4Puc48JXYKi6EuqTtkeJSkZ27DLxMpGYkrnJU7bN4TdX8cI4bLpRpaE/OjjePNM0Nr6a3UuXaLzxoCh6rsmZzhuzi0ed6TQTIz4/AMkVd6BPTSliyvKk1A16bVMQmO09sQrJyMOHzpiuz/2eezg7rMPTER2i9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iatb6HZ4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iatb6HZ4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf452def93so23171045ad.1
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788363145; x=1788967945; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J6CFSQBR//cpcDAomOpl3DbC5UldpOdeC10IA56wysg=;
        b=Iatb6HZ4CH/6zYLqOz8ROKV3dt2iO71/8+3uYkRGYpy5y0UN7F/xpj4PoI/Uoc5Sry
         fcP+H40gU/7z0rMkK+QLnhznpmrkBGPNUztqbjcXbFWVRUdMmgiAJHmsJ18eXu+ivRkh
         3TVPsZ3HQM1579sIKla16Zsw0zTbfgkIZsovLBpYkPXl9gvYSB9nrI0qZ/dtV2pcnkcm
         1b5ag1UYHzptjVEUCKaWvp1QBpf2t7i6tTJvdrJMCIqvf1W19ql4IvJJhJJgsXMxfvuR
         V/ec18DFtVWyQBmOoOitOiweIgsL06hoiJTUm4a+yo8/BI4N5JAoeyPl4gEdmkrm4b3q
         otEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363145; x=1788967945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J6CFSQBR//cpcDAomOpl3DbC5UldpOdeC10IA56wysg=;
        b=ldh6JlsQjq/Lxf6hjPCXnkXJpX0uF9u5XRhNphKu5FCc2addFCkhG2LvjMcqzIn468
         4ZF0G20AO3aMHyouRTr8Rg+Dpbi9LSFLP8eBZiWnp4W/wxFRMV8RaA/y73lC39hZuZgT
         WSAXwUlw4+huSfgTRkkR5c3csjRWN5BPBnn7C0bYaTKhpiXPHL8vCp9DS8d4d1TZKK8+
         Bkt7fs8xofTgX9u4Q2Q9DGrJJpGclrfusBo8CzimHUbjxRvlInyfVwq7Izc2OeIquied
         SuDWC2ilS9/DWEXmSsXHSx2WvkCOwlD8oRRispHm9JU7JiyQ/ASm2nDhGFG6yu3YEsDO
         xlwg==
X-Forwarded-Encrypted: i=1; AKwUvByJZqC+uZH/2nTNI7A9WkG8Zj+eX2/61LwgTjKkT1+t+QWmL3XA3lEkpDKNEAAyU30wMq0v8w==@lists.linux.dev
X-Gm-Message-State: AFuF++meayK2zglMGZ++tEZOZWWXXyyZ9fbK/k2br89/YwKYMHnsP0Oo
	rGKAFXo8ZRiUIrZCQmrDlYx1NGFBD+LFB9BNLWYaKA0GZkvXHNkZ8PPe
X-Gm-Gg: AYBFou3/wafqWB1EtsOc4tuX+6VbBaZGlOxGr5LYYRqC0UAAdVFkdCg1W7HDTlE5sHY
	/DaUamUIG3Y61PT2QUGa31HAVAhPfq7ymqqQxQTo1FJGvMQW8EdLob5R9ee9WXG0oms4lisLcWx
	zNUXoOXWC2HK702Ech3b9ZZIpW97tjTz0KKD3bPW4qTSoXE4XHarKh4KRyuLPP/+zLM46GTPtJp
	PJvsPRRccDOMKdAzGoz83Ya2K2B/StDXZgsiOmHWzJjjsrHB6oNhrmlgxT4pfwzwPTM6F3QwFBt
	bs1NAsp0LYXji3I3yi3SDRZWpMruKiiVO42MV/1VqIUvDNek4+yqfAMvAsVrbejAE/D1zChrF+y
	PwLaTsSPOne153/Nicjzw/WTspB2n5gh94FRL18ad/dJ6er9+VC0mYkGftyVCdrlqEr5E5UYe/4
	XkvLQdlVTCzB+j4skZPJwCIgrwAa9W1MjNeSE4U/NOYHL8tAIRce6fp80n2W0=
X-Received: by 2002:a17:903:1245:b0:2d7:1cbd:9ceb with SMTP id d9443c01a7336-2daf1342881mr28557975ad.12.1788363144243;
        Wed, 02 Sep 2026 08:32:24 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2daf43d41e2sm6944815ad.60.2026.09.02.08.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:32:23 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 04/12] mm/damon/core: validate number of probes in valid_probe_params()
Date: Wed,  2 Sep 2026 23:32:15 +0800
Message-ID: <20260902153216.4034305-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902054747.99370-5-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 22:47:37 -0700 SJ Park <sj@kernel.org> wrote:

> Each DAMON context is allowed to have only up to DAMON_MAX_PROBES
> probes.  The central place for validating DAMON probe parameters,
> damon_valid_probe_params(), is not validating the upper limit, though.
> Do the validation.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 4d28eb033fc4a..c010f686d033e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1420,6 +1420,13 @@ static bool damon_valid_probe_params(struct damon_ctx *ctx)
>  	unsigned char max_probe_hits;
>  	struct damon_probe *probe;
>  	unsigned int wsum, wsum_to_add;
> +	int nr_probes;
> +
> +	nr_probes = 0;
> +	damon_for_each_probe(probe, ctx)
> +		nr_probes++;
> +	if (nr_probes > DAMON_MAX_PROBES)
> +		return false;

Hi SJ,

Thanks for the explanation.

I agree that `DAMON_MAX_PROBES` is better enforced in the core layer,
so that all callers share the same validation path without duplicating
the limit in the sysfs layer.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

>  
>  	if (!damon_has_probe_weights(ctx))
>  		return true;
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
