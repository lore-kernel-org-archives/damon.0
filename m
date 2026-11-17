Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892054;
	b=aa5Ho0hPK91Fm3ZzFuaJB7jRxQWKzRpwsoi5Nhmm5+AQP1nvANktkjo7DLbheb7zGgII
	 7UM0mWuLt72QwGCzJYL+DKrthnNwjpw+YKRieWg0fSu0XA9Cpv760+b7M9btKHP3CjYRQ
	 I5APg0j64Eer+nkCjRrhbiCWhPt8MxLd1mWy+CenKImmWKSfEFx4Q1SCB5WPs9qEEPKjp
	 jFb/ltqQCONZyAIGmUZb49xpnWVXdd16+XzeTjg4kDjvhO2W0P8RtyPMH90NSVIoxmsId
	 9njpFk+q1YscdyreaFtFGgxQF3UZ5wVOs3VqUvSy1R6HJqYl9YydbkTm0uk5MmA1hFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=OTaK1OORIix+uAUUdAoZK7UrfRWre+LYMnS9mqriEQs=;
	b=4Ko0LqT6DwtY6tFT19Wpfau1ZIJ6xivyYXpyTGCZsGZvO5thDeRtp4fGVfnS60Ln7cu2
	 /DCJRgViv6siAUmR7HNZGSa/JDYfizs1FQ9WgkRn0zZe5Iy1UdWwF/zSjvQ0s3/9srd3b
	 NoNWxuxYoGBv3/9UclizM7pYoewg8dWFmjBgeOhTxNGk+1gach4cXbJOcAK6vHgw1wQBw
	 1mMYkMJeW0WRhuBPTXgIKK00yvcaHC88zeiODr+Uq6xlO/h9YXASxOWA9HOMZkl2DhZNs
	 osYNA/AAObmUmMlXxQEhP0uQoaOLq0ERpTPaRTRlyPO3+Qrai5PE94DFwmwJsEiChkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Ur9osPtf;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E2606A31C
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 05:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 462E2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Ur9osPtf
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so5508606eec.0
        for <damon@lists.linux.dev>; Mon, 16 Nov 2026 21:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794892053; x=1795496853; darn=lists.linux.dev;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OTaK1OORIix+uAUUdAoZK7UrfRWre+LYMnS9mqriEQs=;
        b=Ur9osPtfc8rsSRda9JEiInCYIDCqGFWN1t7g6SvbzPcbjdAYpV+KV65fRtV6usEFeG
         oUpNkEc7eri5hsfzxeskC+JW/SYbe2+Yu0uV1e/zSK6wJRrpt/+XtB7OgaZFZQ13iKns
         RzE4MddgexoLORdXGTsUJ0fM48Nb2h0xEh47A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794892053; x=1795496853;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OTaK1OORIix+uAUUdAoZK7UrfRWre+LYMnS9mqriEQs=;
        b=Srh0S/9CPML4K7tnKsvmBfQyohcHQHfRXn9VBKykc3IRVrWY1FA+u9OXL0AQEphz40
         NOXvkY5gP537qxH/dsYYNya2KpR6kvTr1F27GC0dtfRmGmcWzg3l7Zu/ACIMtuG8Yqrg
         PCoiw8bb5r1jjqC5pPgQGpTeYDNu71ey4GwiiU4qObWOizTwJF64zojxL3DPsQWjnbGB
         Oeo0ZeR05/5Kj0hrAbWeXs9yMOQ8OEIkXj9VgvpKHtNEedkBH5QtkyYd/wOXFjXgLOtx
         CbxYVzmvJip1J7VTn4fMTYmRTsL85Uzkv29qDy94pDiOD4Q+cNXMEy150einAo3O9kte
         6D2g==
X-Forwarded-Encrypted: i=1; AL+hErGZSNGEpye05QmncFoYA2W3jDbUqWmuXmF7+cNaK1H+LhcdmhcDgG9HY9qaWh95yglMOnqhNQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9It+V+ck9D1Jh8o9ttRWPeAMy2L6j0M2Fd/7Co8tj/KLMIr1/D
	Yoysfn0t8N1AX40bRfpZLzWt1boGv4dnR0sfqNkPvhTQEV+AO1MPfd74B9wyQ2b7qw0=
X-Gm-Gg: AZFdTZe6+Exvl9CO0N7MCGOEgYcF1FbkkQO7B/i3u1yuJeeYlv++cCmSaFDJXO/Baku
	SC0QWeQGyZDf8L7PoNUKH8oVQ8EJBcDMZlK25DV4xEFNZnIP2piZpCe/PNk9VGh8JG04Hj9M03p
	I4tYdvVk1Y1FxqxYcOt00R1L6LIj18dlJ4YP8kT+QsIGB1X8BH0A9znZ6gjt2rQF8k/HYtdtnGG
	QG40TxY/nQzXAtCsvbwlbryMmcTZe2RKdWAHdlFsS/rsalyTMrUjJ+e2/MszacB9jWvf5U7y71o
	b3HThj2lwRe7SY995Z3PJfCBZ65dNRLWfsLQF6VPL5u+qZFCTssM/pzaSuVloYFmEbpI7VB5+xP
	SjaJjE4x015gsYgHoKhVVtUweGQtAl5DAVTmJoz0quBzi0ZrJm55IEr8JPRExhG9/IomjPtw15U
	L+eDqp+4/MetjQtWvxDXDFHmbzS/YpJ6Gpg2K6xzDSpFPhaqKQQapxFxrEXM65eNXRKT+VMeye8
	OCuQnjeRU7cX1ltJYBRdNcPvQX/PFp5hCH0JL39TUQzXFEDjkTarCd0an57OGC2eCKjfc6sClft
	KlofOn/otoyWBtKZQfvGJczA8d4I2VTiu6mdUuxH5ZbDf66wimYDTZ6YWIMjMQocehesH7qW0WW
	gHk2QxdAsDf8VjZzUPQrvxJvszm3JRdGKfohZfGZ8XLjOdc7/v3v4MwUW3LuH/VrxTfVmuRDTn6
	ua2V1K6sCL35JlFi6lOKwlwkbr3Pl65KNEqxz5AhxlWqqFadQ2AKFxj5MxpbrTfCds
X-Received: by 2002:a05:7300:cc82:b0:36c:9b35:5d46 with SMTP id 5a478bee46e88-379681c811dmr12718279eec.26.1794892053330;
        Mon, 16 Nov 2026 21:07:33 -0800 (PST)
Received: from [172.20.0.3] ([172.56.235.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38116afd7f7sm3833544eec.17.2026.11.16.21.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:07:32 -0800 (PST)
Date: Mon, 16 Nov 2026 21:07:29 -0800
From: Chris Down <chris@chrisdown.name>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, yosry@kernel.org,
	mkoutny@suse.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
	nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org, ljs@kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 1/4] mm: zswap: fix shrinker count for the root memcg
In-Reply-To: <20261114002822.1043378-2-joannelkoong@gmail.com>
References: <20261114002822.1043378-1-joannelkoong@gmail.com>
	<20261114002822.1043378-2-joannelkoong@gmail.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <avvhESdjPdJ2lDlf@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Joanne,

Thanks, I've reproduced this and the results are definitely much better now,
in that with this patch it now writes back pages for a workload in the root
cgroup under memory pressure.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Thanks!

Chris
