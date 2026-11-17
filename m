Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892058;
	b=CpZB+41wFmujBbI8QbTnflgunNd6ZDKS8yXuOVTo7dnd1cE/4nasqGHceqBXjII5pQle
	 AljOqeP07jkxlLa/xLChDDtLRKdoBj2KOpbgi33TDdaJP+sIkgEp0qdDlpIdp4Y9y5nM2
	 O3I/gjjHf77aa+xLjXDLhhFi0xw85b+J6zQSViSNU33ML9Nb/Im7iNiSyPeHMd1Zrb2wS
	 lhr/EclvF3ydRwqRw2aZ9f5CDbb3yVSrSetm/7IKMaAUV5pL15N8nsThSXGmYyyl2wBwu
	 U6fbWmtIo65Dk18XI0NSP6ExrX0zOzEChjRr7Ia158moxHC4+vkt0uvEUMcss1skJ5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=pSTje/Yh5JU+r8doUCnbpH2HQ4u+A7cqXKEYIOCxoqE=;
	b=Mib/uC94R5fwS05/7EbGC/003rq6o8Kl4AWnw83ccJF0u4Wgy169Bt1yc/anr+aUkMMv
	 w3vo3r0ngp6b/3EhQbjr3HPLRpswwk7Tx5mMbJA+6ZwIhxM6rXc9J330nd9JtnRXNvGVc
	 EzJKuobtZ27zMHPFnpZceqPJApckxBMXS64KUnZEbAAGJTf6V+rLJxtwKL7mTVLGkI89x
	 SxFFmpvKBoSc7AFWWyjnbIm4TJMVJ7VKJznh0yZJRiM2FgSE8hBe2Vg8V/lZAUBS2Iz9+
	 Iiro6jwCIJLpcs4a9hel8j8ihW7ywJ8+w8lVJNKHe7Z1Kl0Ozr9sVMpCaAL696bV/dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=DcvpCRRq;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC2606A32C
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 05:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5AC2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=DcvpCRRq
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-38190551625so231983eec.1
        for <damon@lists.linux.dev>; Mon, 16 Nov 2026 21:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794892057; x=1795496857; darn=lists.linux.dev;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pSTje/Yh5JU+r8doUCnbpH2HQ4u+A7cqXKEYIOCxoqE=;
        b=DcvpCRRqE0iCkXuToqQrq0L8GSlAIbkWA+th8tNiQynSvEZDdFHjwgJrjv9lV3T8sd
         M1eEzlO4HIP3C3sGHxBFxNzFkTYZzKto9/YJSADSRY3nDODd4DZ7Ga7kc+iog4ip33BI
         j833xCD2NJR6GMEVuIjny6vjuLHfpAKxHR0mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794892057; x=1795496857;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pSTje/Yh5JU+r8doUCnbpH2HQ4u+A7cqXKEYIOCxoqE=;
        b=UJJVowO/NXtEDo7Y5YmnlUq2Jpnx3e9jp0WIcqpUYkT5MEQfO9YBgOplT5N5DUsIH4
         ta4e3/GFfqvcpZCXnTDhdZIV+Bom0KRN1JcuKrn5D0nfUVBX1Decf4q0bC7rg+wG8KYR
         uPJRWVsVIVb8+SV5lo5mS7tI53S7mFEtmsl/5mTqXkSK+eqss3ZKVUF6NxbW37z4RXaU
         lSI7x7dkVZBXeNPXIPbLvbsJ24wazzBY0noGLJAJUwdqJUY1zG8qBv7jFfoBnW74uyHa
         rIDXJrY5ta9TxA4bPg4zG45bU3c2jOBhfIYN0UCBJbBkAep4JksJ0JMGqzYWT7YhOKp5
         916A==
X-Forwarded-Encrypted: i=1; AL+hErGJFww6MNiOsxdLzYWkLmE6lamrXUqdqn+3AeJA5+WjDrYLrww8o/LSbJJ87qizh5mzDozWEw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8msVQQzAca6P/9MNwRuztmu84mnXaMXhj1jI20s5zQwCoHJJCS
	hONY9ZGAzOLMkG2i+ut+2q4MWfxynMZvQcMu0lJvp/Qsfwc48LOvQ758y2FumjE1cP4=
X-Gm-Gg: AZFdTZdy5s26HKCR26O2PXLOdIK5HMJEtvCeumYOAePeWQEieTWbNdopzorua4+0vwB
	lHiMAbFmqcTB9uvHQbhUHSFy3kONp+8FVtwZ7nsgX1McxhO8IcarmOSd2RtxQS6ErUE6ZshQ6+X
	6nywQ8QI3H39VWjnNaX3xgKjmQvoSU3rAeMdDq0hPMWjlIikybNE6dtlBG0UnZJBakmnKail6bh
	zcLyjiAoBN1KiuG7hhsnQtP5NFexozjMLuCvjpFT9Mt629uyV/alL1T2ueYGYRjHNc8jMBLrUBv
	VFe/jzbkjgfO3YVoTC1c4dSJtSyTTphv+QifeLgCQuEBVSjqWnPxh1WjftoUznTHMjPmTswRuo5
	a3vfK5Si9JxE4CgpIeCoeEMIePUCkQj0JcSDth7NUU1klUAVQlhKkkyToV+z4u/de82Fjcy6iOZ
	JrpN4ZYElv8OFt1NHI5Ccvt9ugTXz2BLTVNJkpI++1FJckaaYm42xmA5QMlAPXv/e5/UoZkzH07
	oa0PHTy1F2eUX3dnZ7NvefcwO4b0kVBNluiot5kvWPU6MOzqApPCqIVdbF/bkzpLfnIMUO4yMpP
	8oMfwkSs+tH2uHhg/xg9ITjMhnCcm8Fy/envP0781/akdT7uKiZSWO7RQ6CkJPTYzuMK0iKYNz8
	49WJSz/VVpQPwfWzoqtoBx4iAudQ5C8tvla3x4EpyDcg/Clfzduxe829N7Yf3wUs566uvrRGQuh
	MNgucX8xpKZ0jALKn8JSgCiRXb0ZWK9Z8gXPbk1fbpz6R/hGhXBo85XTBv4vjN2C2o
X-Received: by 2002:a05:693c:2a16:b0:369:fa21:ba0b with SMTP id 5a478bee46e88-3796721cfc1mr11998596eec.33.1794892055979;
        Mon, 16 Nov 2026 21:07:35 -0800 (PST)
Received: from [172.20.0.3] ([172.56.235.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3797f98b9b2sm37051807eec.6.2026.11.16.21.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:07:35 -0800 (PST)
Date: Mon, 16 Nov 2026 21:07:32 -0800
From: Chris Down <chris@chrisdown.name>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, yosry@kernel.org,
	mkoutny@suse.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
	nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org, ljs@kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 2/4] mm: memcg: read root lruvec stats from the node
	counters
In-Reply-To: <20261114002822.1043378-3-joannelkoong@gmail.com>
References: <20261114002822.1043378-1-joannelkoong@gmail.com>
	<20261114002822.1043378-3-joannelkoong@gmail.com>
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
Message-ID: <avvhFAxBcPk5Q6pW@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Joanne,

Joanne Koong writes:
>The exceptions are the kernel memory stats (slab, kernel stack, page
>tables, secondary page tables and vmalloc), hugetlb, and
>WORKINGSET_NODERECLAIM, which counts reclaimed xarray nodes (slab
>objects). Their node counters also count memory that isn't charged to a
>memcg, which falls into two categories:

This still describes the v2 denylist. With the allowlist, the root memcg
also keeps reading rstat for NR_ANON_MAPPED, NR_FILE_MAPPED, NR_SHMEM et
al, and some of those differ for reasons outside the two categories here,
like swapcache being counted differently in the node counter, for
example. Could the changelog say what is on the list instead? So that
would be the stats that only change through mod_lruvec_state(), with
everything else still reading rstat.

>+	case PGROTATE_ANON:
>+	case PGROTATE_FILE:
>+	case PGREFILL:
>+		return true;

NR_VMSCAN_WRITE isn't on the list, but prepare_scan_control() adds it to
WORKINGSET_RESTORE_ANON, so once the root flush in reclaim goes away,
root reclaim would mix a live node counter with a stale rstat value.
Unless I'm mistaken it should go here as well.

Once those are fixed, please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>

Thanks!

Chris
