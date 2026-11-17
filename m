Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892060;
	b=dxkdZuAxSBvim72FHUVu11o5u2AAsm/ou1v4kjomCi0cASk1tOwX7K86ZcToSg9T5DaE
	 NXUy6xTq0PXqSy6CLcMrqc6YZpotvs4GgQpIaAiaYyFjejuSvlUBtfPjiwZSlQ1xyrlCM
	 LTEu96vhjngNUz4Z6NGidrTfvLcPIpbA4VZGQ3FMzet3n1oc6V5NJJCi/rMYAC58/wKCL
	 jabnC2/slqPgcQU3BFVkVG4o/yPRTbd4e61dFB25OYoQ3ivNRtHmeLZgdORbmSsmtypTf
	 HfDdZrLVCWH+z54suSoJDKPHYTcwgs6gYFjx2BE45Q+k26sr9OzL2goRVpiVecB2Akw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=ADwlNPhiE/91inMKJBN21Al9f4VOhautzJBcYAYagsw=;
	b=HzcWrzWZ6WKVJceWxAfVtxW/LrWzVOBnKe82LRtV83auTPea8D/g6nYW50D9I6Wj6Qul
	 okMlpz6D4EBVgH8bhuV9Y/Fb1R/jpYk6pvYrkwZECi7m7HAK1Fawf8a140Z/3F9TqS0vG
	 HPlD8mA8gOVMWV+1RBgRc8pm+RZyu4gF3Dy9KjH5Fl7ZmBr0a4rYsWDZRA9Tw6IpF3TAi
	 B1bt0eBkSxgl11CUjxAxoXbWtT0fdQ+KWQb90bVBphuQL0S/zMTIAZfPIRX3oO3uUULAZ
	 SLbfD0sLEe20gRWNgWgihSqdVetbzscJ+YAmmtv2eSd7qoNFBj9Pzdq4Xxwnr2n4x/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=tVYI3ay2;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8AC606A31C
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 05:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E8AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=tVYI3ay2
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36f8cdd30beso7053034eec.1
        for <damon@lists.linux.dev>; Mon, 16 Nov 2026 21:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794892059; x=1795496859; darn=lists.linux.dev;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ADwlNPhiE/91inMKJBN21Al9f4VOhautzJBcYAYagsw=;
        b=tVYI3ay2zwSAG4AMKX0WAzyWfLZGqJsK1nZutUau0Wv0YqtWaTxAibMAG3AssF38JG
         +qLsu3v0GLi0R41AKc7YhXTr4vxLxhA3/p+i2RSntvXjoSgMrtt8aU9AoHOGzVm2d07T
         6n/gWQj8S9ueqGBw54n3IE2zLwbItWOVpSgtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794892059; x=1795496859;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ADwlNPhiE/91inMKJBN21Al9f4VOhautzJBcYAYagsw=;
        b=ZxRkzReTIKblmb+hL/6At7RlsvIo6Cb4QeroZMYqvjvVKud0+BGkyvHG9BR4heGCwS
         hVqr1RsMGy/aAkW2yFSpbfu5pw1RCVpWcHCBqqE1aC4Cd1hwuNy/S0Rxbwi4R7wP/pTz
         2TM8ibwFETtgQ3vQil9t269/fUJOq0dYn+p+SmjY0+AvZsk9tneFE2K8kxLsNUwUf+ac
         w+UMgfeF5Q3T7h3RxJfR7Anf7YrP/XcWeMB+U3hj1ibbxFCdNzxCvgqr6DTogpj+0C9W
         RxIus0cmnpEZCwtiORjgTPdqAQH7KV1AnH1wQJHrTfxsDHzN/OPl7GhmgI7bsH2SO0at
         jQKg==
X-Forwarded-Encrypted: i=1; AL+hErHvkTVW5j4IU87I+StSezcQh7Htzd3Z02JuuoTsQ0PK2C5f4CxauXAIFtDPCcW8skevfRQUkw==@lists.linux.dev
X-Gm-Message-State: APuU4Z81D6WPxM+ddV9qNq/ha2tlUUX6KxvGGqJfE8Sky9LOFw5qlmMq
	rcgNbKsDHqfP/xXeWvZCaWMhOYQBtsc8kl1MZli4fDuqcBvvLpAapoBKkgIDnfpQWDs=
X-Gm-Gg: AZFdTZfJSApNNGJOoqJJnOqBNo/w5OrqBCkdBX6iwMjJvrFv3EnHLt/gJKsU8ZqmbQA
	gR/7akMgORLyls41e1Yk5UkBpxOQxOCpNamI9naxbxCFt1H7cd/TyUhmNfr287Wfhb7fvCorbdR
	AGLDJ7gv/bfjDKArintUuEfukUzUFY6AyUfp1GMsFxv5J8sbLhXoxXjYRmpfU+I0ajQ8D13fXwz
	pR4TmvbGtmIAsF/5IDrzZxnTGNdaBk8/o8werxRG2MZk0j8zMf1PJ25102lyR+a+3O/RyWSUhzt
	uBrP0VlXuUF6HTOwlvy/sAzmK2E3o9ZFv9EzSx3NUhvpOHO3058ohhdyVbVZQdtwok9JVaXx/yP
	7k0QBwqQ54HTD+rdOwRY7qf0geJUJZrc08Tr9fQ1+YYeoU9tGM7UWkjMKESxk3mYmpbByyFj45g
	oNmswhfER2ldMtFwanib9gfR+5MQqw/scEWSJjptUCMT72IWmkr8djsIyCOaebVRj9siAsmQzdR
	+6ULCBlJJCK7C9/gpgyegPC1bD0RiNqT+8GEnGOVtLeKfA0eL7kCdP29+eBAu/iTXvFVW2IqxP/
	RpBG+spQ8P044RvV4QtYj750lBSF+BREP/D5z6o3DVtSCfa2F3XeNbfpB2A4hZRzIQ1I9eOIKkm
	GfbRKv4fQGXegCv5IQhUib0M7+0HTLdJgkg9MRhem9vJXrwjhEGM8+Vuj84LavEKWVlUrVV4kLO
	p+05VcCGGt6ZDW4BkzbYbDVOawdiBBGVYNfVBLT850kyX9HoftSn49yAww9ZD+1gv4
X-Received: by 2002:a05:7301:4d16:b0:36a:1d6a:596b with SMTP id 5a478bee46e88-379675feb32mr13056956eec.29.1794892058695;
        Mon, 16 Nov 2026 21:07:38 -0800 (PST)
Received: from [172.20.0.3] ([172.56.235.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-381a55555dbsm1325716eec.10.2026.11.16.21.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:07:38 -0800 (PST)
Date: Mon, 16 Nov 2026 21:07:35 -0800
From: Chris Down <chris@chrisdown.name>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, yosry@kernel.org,
	mkoutny@suse.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
	nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org, ljs@kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 3/4] mm: workingset: skip the root memcg flush in
	workingset_test_recent()
In-Reply-To: <20261114002822.1043378-4-joannelkoong@gmail.com>
References: <20261114002822.1043378-1-joannelkoong@gmail.com>
	<20261114002822.1043378-4-joannelkoong@gmail.com>
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
Message-ID: <avvhF41RlOQSYFq6@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Joanne,

Joanne Koong writes:
>-	if (flush)
>+	if (flush && !mem_cgroup_is_root(eviction_memcg))
> 		mem_cgroup_flush_stats_ratelimited(eviction_memcg);

Not a big deal, but in the v2 thread you mentioned you would try a
mem_cgroup_flush_lru_stats_ratelimited() helper for this, per Michal's
suggestion. That still seems like a good idea given this skip and the one in
DAMON rely on everything read after them staying in lruvec_use_node_stat(),
and at least speaking for myself, keeping the root check close to the list
in memcontrol.c makes that easier to see. It doesn't need
to hold this patch up though, and I've tested that refaults in the root
cgroup no longer flush, so either way:

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Thanks!

Chris
