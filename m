Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192954723
	for <damon@lists.linux.dev>; Mon, 25 May 2026 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674600; cv=none; b=Isj6S6Trch4xK7hgP8BIBWZcWbZScf3vFUeUiAzPA8ofYTDTV8p6Q9pblit64bpJWHeBT/VQh/NAQU/UDDL4odNNlOCDPXZ72Tgjs8GF9acMb6f+1xuRr3rXE7us05PXqcHCE41p0e+JqeTmLUJxzcsu+ReTXa5hn9irRtkEFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674600; c=relaxed/simple;
	bh=tvbe4seE81VJXCS/sV64iAFa1bGbqBGMfj6eA3O0mQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bgu53ohwlxlzfJgPNgzPxMn9oj1lsyeVEjdEQhVPkVdMXbB0MxdeWUwGkKh33ejnI8xiBQjK0QR/rAyH5bgybS5pGyUxxG3RUAh9kt6NaVBXxoi9xWnhfYXicc661t6EZgMykKnOGeujjpd8Qu1TshKHhqGmFdNVBVCgNLBIDAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DPhh/AfO; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DPhh/AfO"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-914bf8abeaeso196540285a.0
        for <damon@lists.linux.dev>; Sun, 24 May 2026 19:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1779674597; x=1780279397; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1dR+qUQ11esis+j6Iq3N8urMnTyCI4LYg4f+Ph15u8=;
        b=DPhh/AfO3xoCu0BmsYmPUSeTzD+6WddIJdiYd+OyACSDMnQAUiUL5KJ4EU+7s23Pf7
         OcOiVDyvghf2WRZne5/rOKhZL+rFhPk7tzrpSg/M0DFhrNydvr5lbjVln00pkoa4mESt
         mMROqUE+7+1h1+nYtYtTZIhlc9q7oqNpGpnpGghgOvFLeifeR48A0a5wFqehF9v0nRY/
         CmbPXFh0mmG3OqD++ziIdF8MCRZIG9jzE1VKuBtCb8uVPxwFNa3ML8b7YQSuddBcnq+f
         lJ7yHAynoQBmJVyrCVE/apTtI6IaudlKXNINp0SKc3e19ezm17Mx7h79qe8K527xZobU
         TqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779674597; x=1780279397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1dR+qUQ11esis+j6Iq3N8urMnTyCI4LYg4f+Ph15u8=;
        b=hCEZgd1lO+KSRwUQ06WXLAx5qJTeECrNXq366bQeKstO+JGgoo173z9zXiyVSTmvX9
         /r5qLJvWhKWwA+Gp1oQ/D7vl7IG6nBj8XzEjZeZkcHmfxa7yYyIH0XLip23l4UJAm9hI
         SY2PrbOXAy7YmYuBQ0wNSEuVnfB+Ex2dK7R9wq1WkIPB4CEfWTsVQ+rC1uHF1RuS3BKQ
         gV5GvGZmprxI0WUznfLp8AkuVPIepE598iCxdRSbZGddkyRFROPLfdt6W5TqoBLDSbh8
         lEv/z5cLbk5Wbw3gSIr1AMCeK5RvlxmDy/8IkNhXv6qOj5uNB/wznk5Q2mZxchIJ70yy
         hHBw==
X-Forwarded-Encrypted: i=1; AFNElJ/YCjKdrZvyZpmWZdsMfpbt4mee2LG3y7B7Fs6wvl2wmzaM5cuYUNvF3SyPS5SzWTfa/K1Eew==@lists.linux.dev
X-Gm-Message-State: AOJu0YxutXJTffzGIu5pzHIBklsUWlE5Oz5viR51gZBeitzUxP48DMgL
	TGQTKK4rRGZ3rI+zLSLHZphIm90Kci2b7Lb6DSrgq3ORvAVR/WqMGRSDXyPwupbO1cY=
X-Gm-Gg: Acq92OFqNgWyX7cCk8uiTM/xT7Fi87qY1mhzX1WdBhMsJPrPz6g0NhEtOlXuSLc1vas
	r7MfTKAqvZDtEFg941DlSE5BhL6226GrjsTypLJn5T+09JbkQ5cBCAPrqi0vC1DFWKTtqb1YEXu
	v+2fuJArqZFoY0mZyLaxXH7tMtrUOm9C7mFiw/i5sp9dx+3/KU2Pp7HFmSMKhmH9PGe/2XdyBo2
	n2YNonVtg1HQ9g/4jjfFVU9ZLaWMhqT/rrTeCirwc0SKwMPPjHlYyMbpMzm1PZKUwrZZfpXjrJT
	9ro2jPV9y0yw5QYFKosic/RYlH9DUYCmQbti1antMAeP6OJdwBNPtR6XKLdmnGHj1h7mwuqSRYj
	sodED+PqjO0iKL6lBd+7NIcn8hY2ec0rTFkAj/s9rXVPRowKkAZpllLOFwD/HlDEALvhS27WFva
	4RwakdxKzo7eKyyTr34rfrEzIWfVmwREOc5713BiLyiOTAB6WFi3Uz/E7NZ8RVaN4DR1gIZteqf
	1Y0HpTACgX8
X-Received: by 2002:a05:620a:372a:b0:914:c100:6a0f with SMTP id af79cd13be357-914c10072a4mr1391916385a.23.1779674597141;
        Sun, 24 May 2026 19:03:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm892777285a.7.2026.05.24.19.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 19:03:16 -0700 (PDT)
Date: Sun, 24 May 2026 22:03:13 -0400
From: Gregory Price <gourry@gourry.net>
To: Arun George/Arun George <arun.george@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com,
	gost.dev@samsung.com, arungeorge05@gmail.com, cpgs@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <ahOt4Zw66ukww2On@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <CGME20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0@epcas5p1.samsung.com>
 <1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>
 <ae_i9IlIndumJWN3@gourry-fedora-PF4VCD3F>
 <1891546521.01777455002601.JavaMail.epsvc@epcpadp1new>
 <afIKxG5mJZE6QgpR@gourry-fedora-PF4VCD3F>
 <1891546521.01777901881625.JavaMail.epsvc@epcpadp2new>
 <afmgJcFUjQLYxkb5@gourry-fedora-PF4VCD3F>
 <1891546521.01779449881859.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1891546521.01779449881859.JavaMail.epsvc@epcpadp2new>

On Fri, May 22, 2026 at 02:10:34PM +0530, Arun George/Arun George wrote:
> Thanks.
> 
> On 05-05-2026 01:15 pm, Gregory Price wrote:
> > In the scenario i'm talking about, a "write budget" is defined as a
> > number of pages that are allows to be mapped writable in the page
> > tables at any given time.
> > Agree. I was also in the same context.
> 
> I am trying to bring the device perspective here, and would like to 
> discuss a few corner cases and possible solutions.
> 
> As I see, solving the compressed memory problem statement has these 
> aspects mainly:
> 
> 1) Allocation control: private/managed memory concept.
> 2) Write control: write-protected PTEs, write-controlled use cases like 
> ZSWAP
> 3) Proactive reclaims: optional methods to ease back-pressure using 
> memory shrinkers, ballooning, kswapd, promotion etc. These methods will 
> be triggered based on notifications/interrupts from the device.
> 
> May be they are not enough to cover some corner cases for cram!
> 
>   I believe that this thin-provisioned memory infra is susceptible to 

I'm not understanding the "thin provisioned" terminology you're using
here.  Can you help define what you mean by thin-provision in this case?

> 'writes-above-media-capacity corner cases' (because of not handling 
> device back-pressure notifications in time) whichever methods we use in 
> the kernel. Even if we use write-controlled methods like ZSWAP and 
> pro-active reclaims, there could be corner cases where the communication 
> with the device could be broken and the write path is not aware of it 
> immediately. Note that OCP spec [1] says the device should mark the 
> memory location as 'poisoned' in 'over-capacity' writes.
> 

The intent is to use the low-watermark to prevent new allocations from
occurring, and the write-controls prevent writing to the device without
interposition.

With a sufficient watermark such that the interrupt is delivered within
some number of microseconds, that should be perfectly fine to prevent
poison from ever occurring at all.

Since poison is only delivered *on read*, the system can go a long,
long time before poison is discovered. From the end-user perspective,
this poison is basically unacceptable.

So either we can prevent poison from always occurring, or the hardware
is not viable to support in a scaled production.  

If you think a sufficiently conservative watermark + write-protection is
insufficient to defend against poison, then please let me know why.

> So I have the following proposals / options for this scenario.
> 
>     Option 1: Poisoned data management - This is about accepting that 
> poisoning of memory locations can happen in much more regular frequency 
> here than regular memories and we need to figure out potential recovery 
> mechanisms in host (not recovery of data; but recovery from the poison 
> situation). But I guess folks will not be okay with it in general, and I 
> am not aware of any workloads where data poisoning is tolerated (may be 
> caching workloads?).
> 

Given option 1, I would never put such a device into my production
environment.  The only reasonable action for handling poison is killing
the software, as the data is functionally corrupted.

>     Option 2 (preferred): Device assisted write budgeting - This is 
> about a device aware / assisted mechanism for the write-controlled 
> use-cases (Ex: ZSWAP) to know the 'safe number of  writes' that can be 
> performed to the device (Or allows to be mapped writable in the page 
> tables). This could be like a 'token bucket' algorithm, where the device 
> provides a 'budget / set of tokens' to the host. And it need to be 
> replenished periodically in the device communication code path; and if 
> the host does not find the token, writes cannot go ahead.
> 

When I say budgeting, I mean literally a budget of writable pages,
entirely controlled by software (mm/cram.c or zswap.c or whatever).

This has nothing to do with device operation / throttling / bandwidth
budgets etc.  It is simply a proposal of an optimization that allows the
user to say:  X out of Y possible pages may be mapped writable.

I don't think this would be part of an initial MVP for a compressed ram
service (regardless of it's cram.c or zswap.c)

> In short, the communication with the device has to be maintained to make 
> pages mapped writable. For MVP, this could be a simple constraint of 
> checking actual device capacity periodically to replenish write-budget 
> for CRAM. For other users of private nodes (GPU memory?), this 
> constraint may not be needed at all.
> 
> We are planning to send an RFC code which will fit into your CRAM infra 
> to discuss this poison management approach further.
> 

I'll try to get a new version out this or next week, apologies for the
lag on this series, I've had a number of disruptions and major movements
on the patch set since I last updated it in February.

~Gregory
