Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72C1EB9F9;
	Thu, 10 Apr 2025 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744323910; cv=none; b=qvpuypjngmYqz3zXKQWmNPAuAKK2lpFElfDJ6rNIzZufObCzLvIEeHzfKgkY07reR4kmonBCchBTwYiTfyMEt1RF+OIiAZuEcvxCdTwZMNpSep0SlYYBWDaUF8ARmTGkgTxZGcLcIQe0Di5arL7PA/DIj8ZfFgxAvOFtm2lyuSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744323910; c=relaxed/simple;
	bh=04ZPtX3eXEebxQjDnxpW8aE/sotN77rxW/2eO5XyZEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MejbPlAyZjXgv+Cg1tNV3y6BA7PN9urbmik/5UCXsAXdfpUk2n40rrwou6BlP1wWOl55WMqYhoV1dLklRlCbWT7lqXCEtuGgMi6mCI4roSvDRVst/kcNzOdJohR7bypme9ejSFVI3UL7FSwfFnfZtxFiD0hVlvAtpsUyD0R+1Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOYYI1TY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOYYI1TY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD27C4CEDD;
	Thu, 10 Apr 2025 22:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744323909;
	bh=04ZPtX3eXEebxQjDnxpW8aE/sotN77rxW/2eO5XyZEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOYYI1TYkLvEr1EcRrzFAKQeJR/LHWVDUdkTfW4Th7xtBDbhtF7PaAfDSioPVuSqC
	 S0RkcJU2iyN4fBnywfdVE68NezmnbXVcbDvKCCEZ3CqkYc4V0GwcoylV1qC8J72N/6
	 UdCz0fifthYDLna/AbAPQJtlCQ7Wy08keUlWeWll/E2/9YqvxwlRpYaDPyUxZLYUOk
	 wNAZmdRRpcEGxTfsm7DBb0+3DUEhASQQIV5EdowZNG5c1hxvHSiQFF1p/VXPMumOUk
	 F53Am2iVSPyi7SGRabBEnLxjYe0SbT1oQm5GMwA7EzFIid2B+PohaGkkiT//RhvcyG
	 gERmaGST0kqyg==
From: SeongJae Park <sj@kernel.org>
To: zuoze <zuoze1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH] mm/damon: add full LPAE support for memory monitoring above 4GB
Date: Thu, 10 Apr 2025 15:25:07 -0700
Message-Id: <20250410222507.56911-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <75e5f32d-a824-44de-b9b0-a2d58dc2c45b@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Apr 2025 14:28:23 +0800 zuoze <zuoze1@huawei.com> wrote:

> 
> 
> 在 2025/4/10 1:36, SeongJae Park 写道:
> > On Wed, 9 Apr 2025 15:01:39 +0800 zuoze <zuoze1@huawei.com> wrote:
> > 
> >>
> >>
> >> 在 2025/4/9 10:50, SeongJae Park 写道:
> >>> Hi Ze,
> >>>
> >>> On Tue, 8 Apr 2025 15:55:53 +0800 Ze Zuo <zuoze1@huawei.com> wrote:
> >>>
> >>>> Previously, DAMON's physical address space monitoring only supported
> >>>> memory ranges below 4GB on LPAE-enabled systems. This was due to
> >>>> the use of 'unsigned long' in 'struct damon_addr_range', which is
> >>>> 32-bit on ARM32 even with LPAE enabled.
[...]
> > I think another approach for this issue is adding a DAMON parameter, say,
> > address_unit.  It will represent the factor value that need to be multiplied to
> > DAMON-address to get real address on the given address space.  For example, if
> > address_unit is 10 and the user sets DAMON monitoring target address range as
> > 200-300, it means user wants DAMON to monitor address range 2000-3000 of the
> > given address space.  The default value of the parameter would be 1, so that
> > old users show no change.  32bit ARM with LPAE users would need to explicitly
> > set the parameter but I believe that shouldn't be a big issue?
> 
> Regarding the address_unit approach, I have some concerns after checking
> the code:
> 
> 1. Scaling Factor Limitations - While the scaling factor resolves the
> damon_addr_range storage issue, actual physical addresses (PAs) would
> still require unsigned long long temporaries in many cases.

The current behavior, which is using 'unsigned long' as the type of the real
address on DAMON operations set for physical address space (paddr), was just a
wrong approach.  'paddr' operations set should use proper type for physical
address, namely phys_addr_t.

> Different
> system with varying iomem regions may require different scaling
> factors, making deployment harder than a fixed maximum range.

I was thinking the user space could set the proper scaling factor.  Would it be
challenging?

> 
> 2. Significant Code Impact & Overhead - Implementing this would require
> significant changes with every PA traversal needing rescaling, which
> introduces computational overhead.

Right, no small amount of code change will be required.  But those will be
mostly isolated in operations set layer.

For the computational overhead, I don't expect it woudl be significant, given
region-based controlled and minimum overhead design.

But, obviously doing some prototyping and testing first woudl give us a better
picture.

> That said, there remains a necessity
> to use unsigned long long to store certain variables in structures, such
> as sampling_addr in the damon_region structure and sz_tried in the
> damos_stat structure.

I want the core layer to continue using its own concpetual address type
(unsigned long).  sampling_addr and sz_tried are core layer's concepts, so
should continu using 'unsigned long', while operations set should convert those
appropriately.

> 
> If I'm misunderstanding any points, please correct me, and feel free to
> add any additional concerns.
> 
> As an alternative, we could adopt a pattern similar to other subsystems
> (e.g., memblock, CMA, resource), which define their own address types.

The example cases directly deal with the specific address space, so their
approaches make sense to me.  Also DAMON's operations set layer implmentation
should also learn from them.

> For example:
> 
>   #ifdef CONFIG_PHYS_ADDR_T_64BIT
> 	typedef unsigned long long damon_addr_t;
>   #else
> 	typedef unsigned long damon_addr_t;
>   #endif

But in case of DAMON's core layer, it should deal with arbitrary address
spaces, so I feel that might not necessarily be the only approach that we
should use.

> 
> This approach would avoid scaling complexity while maintaining
> consistency with existing mm code.
> 
> What do you think? SJ, I'm happy to help test any approach or discuss
> further.

So I still don't anticipate big problems with my proposed approach.  But only
prototyping and testing would let us know more truth.  If you don't mind, I
will quickly write and share a prototype of my idea so that you could test.


Thanks,
SJ

[...]
