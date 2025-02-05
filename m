Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F1317E
	for <damon@lists.linux.dev>; Wed,  5 Feb 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759605; cv=none; b=NpdKgMFA3wg+ON2uUOA2CKTYfOmSqD1A7gtjqnl1FlCuL00nm2UkKAddck8wdwkH3YupoHuVnOBWkEnNOVmnIp4B1kgasn1oNB9wYyINyLG3OlNVUoNVsI4MZaoRMyw3rndF5pj3WIzBbVAMIgzIzZj3l8m/XthqxI+M0ABX7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759605; c=relaxed/simple;
	bh=U2ZC06V4StUAOAJVwW0Sg0jao7Eq+HS66CDIElSHxlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ri9jSJNrBZ2lbmsSKoqd0mZboXxNyh2ASHfQ2N/vcqzfiPJq3rV81T67+AEhNK9aNiZ34HKE38myAwDoEMfZS6imFYYDXJyR8eS2hvQ3ioOZcP/6EW6stZoJvynEbgyFIeddLbGk0SpbKpTi9k0DSGWjGyeZYehVNF1mgI7mJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX8hAxYJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX8hAxYJ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so66804345e9.1
        for <damon@lists.linux.dev>; Wed, 05 Feb 2025 04:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738759601; x=1739364401; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ltB9TyBs08dtxZcaIPjt3x1qkR+0le8ozw65U2rCkk=;
        b=fX8hAxYJPw2ZWPvSSQ+awIJ4TsQ1MyBJS942OJ++H+q9p10w2rHWeY4Lg8tcHi8vAL
         5gJjXv8Uz8zWumUOjNYMw1/FEy2+T2p+l21+/TN68pFi4zVrexkvCejKScUlcLFt0x7T
         lCqy4j334uh8+F+yMpZZQ/yYwB45Yt3VW97q+nBm/26wHn0Mcw/bXbwgcEzmh69mBnpe
         4MV+CUW1+7N8+9H50Oqv20/bni3utAMzdxOcVmY29E9FBb0cT7N9NpVbq99yXHPFLx/+
         y7O7y26XVFdu8/vAzUtwFBdxLIYslscmXrmTrXWX5n5bWD4yPPPYKDaBJqkBSDB7rcz2
         /5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759601; x=1739364401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ltB9TyBs08dtxZcaIPjt3x1qkR+0le8ozw65U2rCkk=;
        b=rMRX85krwffHyFn7pd/rKPErbSoiRhoifWnuawBqLQuG2b2po+X/TeZRCrJBztNCW8
         NfEO0UPAAt5eU5KduT0K1OUojRbkhXIn4ePSEUGF4zhylzmPdD+iMb3zAKNI4a+vx7Mj
         yz1PEwwQHTIbDZYAsrpE+hU8jOyz6u0j7MsOYEAyq73Mmy01RPi/hE6K20XAdq26c3Ya
         EiRWRXqwstih/i4Y7LxVJKNE0nJA1gyZyX0oTOjL/7xiDbOPmbxj+ZrDbwo1oswrfIVe
         zKbjIyAvh4/llkvAhSGZjjpMI+1eKzeuJxNVJHJk3Kb71buG1GQ0dAld5vKTgcHNS+dM
         LqWw==
X-Forwarded-Encrypted: i=1; AJvYcCVhhdkvkZkLybUDm3/FBBv8ecnt2ExuMdxSWPAj2AoFBVJy+ujgQlDEl2RRvzWIAMCcZJydiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVWmjJ5JfwyqbpP3n5KArFn20vT1jWsA1rfEJHsCsPZA57jDr9
	oNpUEyZuD8PdISzjUELqb4nSMcyJccKVGcvXq21HgWNn6NpQwOpM
X-Gm-Gg: ASbGnctUOsTM7SppPRpXWnCGowAM5ZgT2cQMjFd0TbjufSAIB3ZYTdeGXyPtsLvOuIS
	lh3jFT1VHK9Q2QO9xNSneCxhMhF5uR33WepxbJtMPF3vdtRxYA+SJTRLyMcn+mAf2gJm6Hzazqt
	T5+SSWs1pJeyceuT7A7tc9MJ78POB1BsTg9TWG4k1AXeGomV3bqH5tBobImZBJfhmaA/dit63gc
	t+enbCPLwtNHcelZXf22K+8ZaPAyjlSg00tAH/GiOFS8o3SrZQRcNOIq/sHuVHCWCFo80lhOrAj
	grbm5u6c0cQW6LBAArZvAth/mP8ENv2uNrXwUQ2fD9fzu4ZYIqDmh98BD0Qf7SfsrVv2iIgm6X+
	jEqCl443Y
X-Google-Smtp-Source: AGHT+IGUTz7JZSLp0iQi943sH/cebjl1yb/z1NmxScfZEo+A38fdKrvVQOXjG/YFt4geiyj0Gcxeuw==
X-Received: by 2002:a05:600c:511c:b0:434:fd15:3ac9 with SMTP id 5b1f17b1804b1-4390d552079mr17792715e9.22.1738759601013;
        Wed, 05 Feb 2025 04:46:41 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d966faasm20648715e9.23.2025.02.05.04.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 04:46:40 -0800 (PST)
Message-ID: <c1902ae7-4664-4891-baa0-cd895aa62fce@gmail.com>
Date: Wed, 5 Feb 2025 12:46:39 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] mm/damon/paddr: use damon_get_folio_in_region to
 obtain folio
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 hannes@cmpxchg.org, david@redhat.com, kernel-team@meta.com
References: <20250204230634.2577-1-sj@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250204230634.2577-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/02/2025 23:06, SeongJae Park wrote:
> On Mon,  3 Feb 2025 22:55:29 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>> This is introduced for larger folios. If a large folio has subpages
>> present in multiple regions, it will be considered multiple times.
>> This can be when checking access
> 
> I think this behavior makes sense.  If a 2 MiB address range is known to be
> accessed or not, treating DAMON regions in the address range as all accessed or
> not aligns with the DAMON's region definition and makes sense in general, to
> me.  Note that DAMON's adaptive regions adjustment mechanism will make the
> DAMON regions in a large folio to be merged in near future.
> 
>> or applying DAMOS schemes. For e.g.
>> in pa_stat, folios split across N regions will be counted N times,
>> giving inaccurate results.
> 
> Nice catch!  I agree this could be a problem.
> 
>> Hence, only consider a page for access check/DAMOS scheme only if the head
>> page is part of that region as well.
> 
> For access checking, this seems wrong to me.  This change will unnecessarily
> mark some DAMON regions as not accessed.
> 
> Even for DAMOS, this seems not very optimum.
> 
> 1. DAMOS will unnecessarily repeat PAGE_SIZE skippings on second and later
>    DAMON regions of a same large folio.

Hi SJ,

Thanks for the reviews! Just a small point on 1. below, but most is addressed at
the end.

If needed, we could add another arg in damon_get_folio_in_region to return the size
of folio if head page was not part of the region to skip by that size instead of
PAGE_SIZE.

> 2. If only a small part of the large folio belongs to the first DAMON region,
>    and the DAMON region is not eligible to the scheme, while the second region
>    is, the scheme action will not applied to the second region.
>
> Also, I think this problem can happen on vaddr case.  Hence, making the change
> on core layer makes sense to me.
> 
> That is, let damon_ops->apply_scheme() inform the caller (damos_apply_scheme())
> how much bytes of the next region should be ignored at applying the action.
> Due to the complicated implementation of DAMOS core logic, this might be not
> very simple.
> 
> I think the additional complexity might outweigh the benefit for following
> reasons.  First, adaptive regions adjustment mechanism will make DAMON regions
> in same large folios to be merged soon.  So the problem will be not significant
> in common case.  Second, any threads could collapse any parts of memory into
> large folios while DAMOS is traversing DAMON regions.  So this problem cannot
> perfectly be solved unless we make DAMOS' DAMON regions traversal exclusive
> with any large folios collapsing.  Which would add more complexity.
> 
> And given DAMON's best-effort nature, keeping the issue until we get a simple
> and effective solution is ok to me, unless a real significant issue from this
> is confirmed.
> 
> Usama, what do you think?
> 
> 

So the reason I added this patch was when testing out the series on a VM that was only
running a C program continuously accessing 200M hugepages, DAMON was reporting more
than 200M of hugepages everytime, it was usually around 206-208M,
but sometimes quite high. I have added an example at the end showing 266M of hugepages,
which is more than 25% off.
Since this is page level attributes and not sampling based, I believe we should report
accurate results everytime, even at the start.

I think it makes sense when you say that adaptive region adjustment will make the regions
converge, but without this patch even after 20 minutes of running, I couldn't get 200M.
With this patch, I get 200M everytime.

I agree with the points you raised and I thought of the same when trying to come up with
this patch. The reason I did in both access check and DAMOS was I thought its best to have
consistency throughout on how folios in damon regions are treated. I think the solution
for this is probably some compromise between simplicity and accuracy.

I think we have 3 ways forward?
1. Try and improve current patch, where we ignore the folio if the head page is not part of
   the region, for both access check and DAMOS. The way we treat large folios will then be
   consistent for all cases, but there are other issues which you highlighted above.
2. Only do the approach in this patch for DAMOS schemes, i.e. use damon_get_folio_in_region
   only for damon_pa_pageout/mark_accessed_or_deactivate/migrate/stat.
   We dont do it for damon_pa_mkold/young.
3. Only do this approach for pa_stat.

My preference is going forward with option 2, as we wont do pageout/migration/etc repeatedly
to the same folio, but I think option 3 is fine as well, so that we atleast get the right
stats. Let me know what you think is the best way forward?


[root@vm4 src]# cat /proc/meminfo | grep -i anonhuge
AnonHugePages:    204800 kB
[root@vm4 src]# ./run.sh 
heatmap: 44444444888889888887333333332222000000000000000000000000000000000000000000000000
# min/max temperatures: -1,610,000,000, 366,877, column size: 25.586 MiB
# damos filters (df): reject none hugepage
0   addr 1024.000 KiB size 203.875 MiB access 0 %   age 7.500 s       df-passed 0 B
1   addr 204.875 MiB  size 5.949 MiB   access 0 %   age 200 ms        df-passed 0 B
2   addr 210.824 MiB  size 16.062 MiB  access 0 %   age 0 ns          df-passed 0 B
3   addr 226.887 MiB  size 37.480 MiB  access 0 %   age 0 ns          df-passed 18.000 MiB
4   addr 264.367 MiB  size 10.316 MiB  access 15 %  age 0 ns          df-passed 12.000 MiB
5   addr 274.684 MiB  size 4.426 MiB   access 10 %  age 0 ns          df-passed 6.000 MiB
6   addr 279.109 MiB  size 5.688 MiB   access 15 %  age 0 ns          df-passed 6.000 MiB
7   addr 284.797 MiB  size 648.000 KiB access 15 %  age 0 ns          df-passed 2.000 MiB
8   addr 285.430 MiB  size 56.000 KiB  access 10 %  age 100 ms        df-passed 2.000 MiB
9   addr 285.484 MiB  size 504.000 KiB access 10 %  age 100 ms        df-passed 2.000 MiB
10  addr 285.977 MiB  size 844.000 KiB access 5 %   age 0 ns          df-passed 2.000 MiB
11  addr 286.801 MiB  size 3.305 MiB   access 5 %   age 0 ns          df-passed 4.000 MiB
12  addr 290.105 MiB  size 6.281 MiB   access 0 %   age 100 ms        df-passed 8.000 MiB
13  addr 296.387 MiB  size 6.285 MiB   access 0 %   age 100 ms        df-passed 8.000 MiB
14  addr 302.672 MiB  size 1.211 MiB   access 5 %   age 0 ns          df-passed 2.000 MiB
15  addr 303.883 MiB  size 1.211 MiB   access 5 %   age 0 ns          df-passed 2.000 MiB
16  addr 305.094 MiB  size 840.000 KiB access 0 %   age 0 ns          df-passed 2.000 MiB
17  addr 305.914 MiB  size 364.000 KiB access 0 %   age 0 ns          df-passed 2.000 MiB
18  addr 306.270 MiB  size 844.000 KiB access 10 %  age 0 ns          df-passed 2.000 MiB
19  addr 307.094 MiB  size 364.000 KiB access 10 %  age 0 ns          df-passed 2.000 MiB
20  addr 307.449 MiB  size 8.484 MiB   access 5 %   age 0 ns          df-passed 10.000 MiB
21  addr 315.934 MiB  size 8.488 MiB   access 5 %   age 0 ns          df-passed 10.000 MiB
22  addr 324.422 MiB  size 772.000 KiB access 0 %   age 100 ms        df-passed 2.000 MiB
23  addr 325.176 MiB  size 1.133 MiB   access 0 %   age 100 ms        df-passed 2.000 MiB
24  addr 326.309 MiB  size 224.000 KiB access 0 %   age 0 ns          df-passed 2.000 MiB
25  addr 326.527 MiB  size 900.000 KiB access 0 %   age 0 ns          df-passed 2.000 MiB
26  addr 327.406 MiB  size 3.961 MiB   access 0 %   age 0 ns          df-passed 4.000 MiB
27  addr 331.367 MiB  size 5.945 MiB   access 0 %   age 0 ns          df-passed 6.000 MiB
28  addr 337.312 MiB  size 1.867 MiB   access 5 %   age 0 ns          df-passed 2.000 MiB
29  addr 339.180 MiB  size 824.000 KiB access 10 %  age 0 ns          df-passed 2.000 MiB
30  addr 339.984 MiB  size 548.000 KiB access 0 %   age 0 ns          df-passed 2.000 MiB
31  addr 340.520 MiB  size 2.141 MiB   access 0 %   age 0 ns          df-passed 4.000 MiB
32  addr 342.660 MiB  size 2.617 MiB   access 0 %   age 0 ns          df-passed 4.000 MiB
33  addr 345.277 MiB  size 1.125 MiB   access 0 %   age 0 ns          df-passed 2.000 MiB
34  addr 346.402 MiB  size 984.000 KiB access 5 %   age 0 ns          df-passed 2.000 MiB
35  addr 347.363 MiB  size 660.000 KiB access 5 %   age 0 ns          df-passed 2.000 MiB
36  addr 348.008 MiB  size 768.000 KiB access 15 %  age 100 ms        df-passed 2.000 MiB
37  addr 348.758 MiB  size 192.000 KiB access 15 %  age 100 ms        df-passed 2.000 MiB
38  addr 348.945 MiB  size 1.098 MiB   access 5 %   age 0 ns          df-passed 2.000 MiB
39  addr 350.043 MiB  size 1.102 MiB   access 5 %   age 0 ns          df-passed 2.000 MiB
40  addr 351.145 MiB  size 768.000 KiB access 0 %   age 0 ns          df-passed 2.000 MiB
41  addr 351.895 MiB  size 516.000 KiB access 0 %   age 0 ns          df-passed 2.000 MiB
42  addr 352.398 MiB  size 2.258 MiB   access 10 %  age 0 ns          df-passed 4.000 MiB
43  addr 354.656 MiB  size 9.039 MiB   access 10 %  age 0 ns          df-passed 10.000 MiB
44  addr 363.695 MiB  size 38.391 MiB  access 0 %   age 0 ns          df-passed 40.000 MiB
45  addr 402.086 MiB  size 16.457 MiB  access 0 %   age 0 ns          df-passed 18.000 MiB
46  addr 418.543 MiB  size 2.168 MiB   access 5 %   age 0 ns          df-passed 4.000 MiB
47  addr 420.711 MiB  size 3.258 MiB   access 5 %   age 0 ns          df-passed 4.000 MiB
48  addr 423.969 MiB  size 124.000 KiB access 10 %  age 100 ms        df-passed 2.000 MiB
49  addr 424.090 MiB  size 32.000 KiB  access 10 %  age 100 ms        df-passed 2.000 MiB
50  addr 424.121 MiB  size 1.469 MiB   access 5 %   age 0 ns          df-passed 2.000 MiB
51  addr 425.590 MiB  size 380.000 KiB access 5 %   age 0 ns          df-passed 2.000 MiB
52  addr 425.961 MiB  size 752.000 KiB access 10 %  age 0 ns          df-passed 2.000 MiB
53  addr 426.695 MiB  size 1.109 MiB   access 10 %  age 0 ns          df-passed 2.000 MiB
54  addr 427.805 MiB  size 54.031 MiB  access 0 %   age 0 ns          df-passed 22.000 MiB
55  addr 481.836 MiB  size 23.160 MiB  access 0 %   age 0 ns          df-passed 0 B
56  addr 504.996 MiB  size 194.918 MiB access 0 %   age 9 s           df-passed 0 B
57  addr 699.914 MiB  size 118.688 MiB access 0 %   age 11.500 s      df-passed 0 B
58  addr 818.602 MiB  size 199.594 MiB access 0 %   age 15.300 s      df-passed 0 B
59  addr 1018.195 MiB size 1.006 GiB   access 0 %   age 16.100 s      df-passed 0 B
total size: 1.999 GiB  df-passed: 266.000 MiB
[root@vm4 src]# cat /proc/meminfo | grep -i anonhuge
AnonHugePages:    204800 kB


