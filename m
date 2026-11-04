Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755051;
	b=f/bJJdM/xFihLwianpng5QcznRMygUl1foZ/uUJNm9sPJxcDZ3lfyhZRwkZE/elnpwqJ
	 sj9olBW6o9GCtF7APKuWlwsW2XU5rLmmQ+lkKkP44KAkz5XYQ4kvWquqyYxyOG8UEcsTP
	 PCufDm+KTcXgzLnwqKjP6HzJE7kBA2rOCUUdUWaQFbheflOtNIOPL4pDVEZUxIDVPMiIF
	 HOPnmpHPkfY/8xiPFxq8R27Zx2gyc0zGKg0FGV2JNiHjGXTsKSJoVrD+07LIuQ11c8VXJ
	 ZlWP6z5a3YbsBpXxWNIxIBrK9a8qxHKeud1CzWRv0tsJL53ojYPmDz7TpCTp+XNTJnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cm1ZQLsGovKO+P8QmmyFaPVIQNh00JlvvBw/TqlEjIs=;
	b=l8Cz9v56mt0qJtCiAvILRTSZnFWjwy3FBlaEYQBX4UPKH/Jh8N0Ya0cFJNs7xsm9uxlp
	 mKr5dasBTbUTSgWSU1m/aD2lsjAxqqb10Z0dbgwJfwOWM7RSnHz14m/MQz5q068fUELJo
	 WsaxOUVEMRTMYMJ/fe5Krq7IvtuO9fO6ylHPTIigbCOFT4LYsbOJihQ62DN/yTgSgLG/r
	 V4nWbtkr7Dx7Peb+wF8BuF5XYp9R7CeAyMOEySGDiU/hkEkmH5FnYw+qJsf7DYPnmuVmY
	 TeXx8/Sgtu+e6hH9mNnMJde5b9xXj8FjEOuCLu3Go36q1x6ymonubSpJoEBFYsJWArQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cUgYs1al;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDCC606A326
	for <damon@lists.linux.dev>; Wed,  4 Nov 2026 01:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEDCC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cUgYs1al
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e9d7791b00so1184405ad.0
        for <damon@lists.linux.dev>; Tue, 03 Nov 2026 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755050; x=1794359850; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cm1ZQLsGovKO+P8QmmyFaPVIQNh00JlvvBw/TqlEjIs=;
        b=cUgYs1al/snZVRRnlnWfX71NegwUMczbetga3QHn4v3NdQP3ywbHnp09rxkuurW+GV
         g+UljSystAcUkYF/HlgJoyeM0tXm5+o+9jP0YURNLXpRIIL6HnZccbkt8EKKk1d8I7x0
         +RZ8Qat+bZtzmb3hhW4mgQx1gl0VT1GrLX+KcQeLNzFFI4/ehJO2WXUAC2a0SpGRQvPI
         TgoU5tEFtrBZleXuuQaPGxsKxyxtgaFlBvdp/Q/JmiL4ReiGEfKHnPUg0LdMPgSwmbO2
         hZJs4IpdnoPx2qHxqrS+YFVstQpZWecmEvqYgE+BFzzWxDGiW5K1rOQPdAG3drNs28KN
         75Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755050; x=1794359850;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cm1ZQLsGovKO+P8QmmyFaPVIQNh00JlvvBw/TqlEjIs=;
        b=pXKJJb3bHGnnKxq6RSrvO576YXwoEch6k/2o5Gu1ic+pTsmS55i5LXsO6G1xkcv3vy
         o5IXieR/FzQ2ZXsdjgn05uX5P+14P7zEyS8QZlbNizMu20EEX+skICmg/Jh9SZpEexbk
         0+98pTJx+js/BrKgCly5aObzs4OGqGSTmMiE6ofjdJMphuOR4JVjK8chCZ9XTEbSByjA
         aa2bTda63xFFjzaOgCAM1gi3cjX7L0kldR0DkCQgxB5CsCo9Xn5hNvF+MnUOsPQVUN3T
         rHkmGlw49mOQ4+qA/4URSBvNVKHTGox+dv86D8pMfnJEyQhFbxjBdC+SrZZ5ClOJOwtg
         DiOw==
X-Forwarded-Encrypted: i=1; AKwUvBxJyVP5z5ucw2BNSAoYt4+4eA9zHpe/WYTBsV8CZBr3UTkHRwF3qInP9RbBaLxBjjPN6ZbN6Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ORPcHQ3uQLn/XCdBqg0UhsiRQCJPE5RhWyT2ZChgKZitgW4z5
	m+S5oJ29M4+QBEkGaHpLXl/jsEfUZyYvD0numMNDjEyV6XI0ow2KmdCv
X-Gm-Gg: AYBFou3Rs9q/Oorjl4lypmwVcAFfFKdjLFUVQeydMhZ34TtQfUypUvj0VnfcOPhY9IV
	X/QoUUj8wQWk2PUAcqjlcUyP20fWbcKdv8eJnFavUzJHmxzFwjSEhMizAqiDpPry9r8cObEXmw2
	kk0Z6B7i0/Q9OxLorlkxuSU6x9/yHbMlmSp19Dgz5X85QCRfZaWom1WGCXet9+c5IkO7l3EJ8RW
	BALbx6hw5WoaN01Z0Uc/ZjELTRLAqvL1gbesmkLy2OU/D0+hJeHvX5A56MfZ6vzwSEE03HfyU+e
	3c4TiaMXlR26YEL+Dh603S2wwxtlTAS+a8oHPtCAKIba1G74hlSyjDJxDUfBrhpfLIsHDhaeUax
	dsaJbrO3Ejk6PKfthRkgJ3DpUnvkslX0YZolpZ/96giet9ibYaiAXn9Hi520BC5dr4IE0kKraAM
	LsADAYkMeHsjDh3G7QXuf1o2r8dL9C0p3lm9RhAhvHnir+nrHORNAPxhz8UWTLM1m6YeZvKBDHX
	XoQyywSedjUvazD3j3YinkQEP8dgPwgCgffjVgqRBjiCqYf7v7vhbBpCdPt1q2+e55ewiYH2240
	XlxEjlqEcYu9iu8rYK8q/w6FeDEoUFGYvvJffXRcngo=
X-Received: by 2002:a17:902:ec85:b0:2e9:6788:937e with SMTP id d9443c01a7336-2eb364d1716mr124879085ad.42.1793755049997;
        Tue, 03 Nov 2026 17:17:29 -0800 (PST)
Received: from [192.168.52.49] ([2406:da14:ac0:7d00:a5cf:b1b:97dc:3084])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed091ce09fsm741905ad.68.2026.11.03.17.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 17:17:29 -0800 (PST)
Message-ID: <9bb64032-09ce-4ddf-81cb-206bb85b9be3@gmail.com>
Date: Wed, 4 Nov 2026 09:17:24 +0800
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/core: reject empty access pattern intervals on
 scheme commit
To: SJ Park <sj@kernel.org>, jm5905938@gmail.com
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 error27@gmail.com, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Liam R. Howlett" <liam@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>
References: <20261103145319.88120-1-sj@kernel.org>
From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
In-Reply-To: <20261103145319.88120-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi SeongJae and Aveline

  Thank you both for the careful review.

I appreciate the clarification that DAMON simply executes what

  the user configured, and that this is more of an input validation

improvement than a bug fix. Perhaps I was too aggressive in framing

it as a bug.

thanks

xiaolei

在 2026/11/3 22:53, SJ Park 写道:
> On Tue,  3 Nov 2026 18:54:18 +0800 "Xiaolei Wang (Kaihong)" <xiaoleiwangxiaolei@gmail.com> wrote:
>
>> DAMOS schemes accept access pattern bounds with min > max (e.g.
>> min_sz_region > max_sz_region).  No input path validates the bounds:
>> damon_new_scheme() stores the pattern as is, and the sysfs ul_range
>> stores are plain kstrtoul().
>>
>> At runtime __damos_valid_target() evaluates "min <= x <= max" for each
>> of the three pattern dimensions.  A reversed interval is an empty set,
>> so every region fails the check and the scheme silently never matches
>> anything: nr_tried stays zero forever while the kdamond keeps running
>> normally.
>>
>> With such a reversed interval, damo starts normally (rc=0, kdamond
>> state=on), but nr_tried and nr_applied stay zero forever and the target
>> RSS does not drop.
>>
>> The same holds for the watermarks thresholds, which must be monotonic
>> (low <= mid <= high).
>>
>> Validate the access pattern and watermarks at the beginning of
>> damos_commit(), through which both new schemes (damo start) and online
>> updates (damo tune) pass.
> The documentation is not explicitly mentioning about the inputs (min > max and
> non-monotonic watermarks).  But I was thinking it is not really difficult to
> infer this behavior based on the existing document.
>
> If my understanding of the documentation is not wrong, I find no problem at
> accepting the inputs and just behave as documented.  It might look silly, but
> who knows the users have a creative reason to do that?  As long as it is not
> causing a harm, just supporting it is better for both users and code
> maintainability, in my humble opinion.
>
> Pleae let me know if I am missing something.
>
>
> Thanks,
> SJ
>
> [...]
