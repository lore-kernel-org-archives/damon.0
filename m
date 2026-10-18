Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C56D1F936
	for <damon@lists.linux.dev>; Sun, 18 Oct 2026 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792354097; cv=none; b=RUS57EpsUzjDHmt0fcYNtFbgrtjiHRq/3ALCOe9LVTtXeWR8UKIFxM35h84GXoeZdBYV1krCzw93lqy+PJYuxdhzwPVvLWGZ3xbdD1ueleVr6zKECwyhXHiXF2nvrb0puO/1zb8/pUV4SOf4v5TdzymJTu2uLYJAHT/Xf2o56K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792354097; c=relaxed/simple;
	bh=3V3EO8Rc8T9oaEiv1JN6yzm5codjVawR21T6VlJqg5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iI+0duVy1ESG4CRsojNTgUO6jEPXVdnP8KE5PG62Dm5ojuiKTbwMzOBpv0SEwbLhbvVqJ2QWYRwIEAkA0irElKc4JBB/5SpL/e2MR5yrg/S564C+tKrSgis7jF6GwLKaPahenGaE6ucpRbDb3mvdOoc/IBv7ze5pmBHdYdqCWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYrw+Arw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYrw+Arw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1341F000C4;
	Sun, 18 Oct 2026 20:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792354095;
	bh=tlkddqdAROiRGtBl43BIyKikWb29hcRgIJuoZ3xSrwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XYrw+Arwcvzq/EsCN6eKmsckq5E/DoFzU+yS4r/hk6yMv5RzrlgBRCINUKu191WX9
	 Pk9TErECOu1oWqPRpJuEIu3WhpzXv8PFDIPZvU5kcXG7PnzbP2Gp4kqsm3GLYOp3A9
	 Nr2eOw1vJJNMBsLcm7g2lTwHIflnKbSdE06yaazATy/2u8+fKSy/81zLLzNwcL1lJ1
	 y/YGY8B1x/81en3l0oE4wpi9/YSVkR5lXhOgiZILdIlyDfNGAbrRARmKhzdMMxt9aY
	 ZKJAMrW13oeQe5yIcYMOSsHLYM0X/p6k2epZwzTjXj9mEEI2bFiZ4n3eF5G+MwUUSW
	 8MnJJ0PydVy3Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v0] Docs/mm/damon/design: document data attributes report infra design (beyond page table accessed-bit milestone 2)
Date: Sun, 18 Oct 2026 13:08:07 -0700
Message-ID: <20261018200808.379209-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-176355@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 18 Oct 2026 19:58:01 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Docs/mm/damon: CPU cycle instruction sampling lacks target memory address
> --
> 
> commit a164f9ff38c8cd1963db3e0c7ea062dbc93135a3
> Author: SJ Park <sj@kernel.org>
> 
> Docs/mm/damon/design: document data attributes report infra design (beyond page table accessed-bit milestone 2)
> 
> This patch documents the high-level design for DAMON's data attributes
> reporting infrastructure, including the damon_report_attrs() API and an
> example use case for per-CPU write-only monitoring using perf CPU cycles
> sampling.
> 
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > index a465e34bb1d9c..1e699e3f8a496 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -433,6 +433,50 @@ monitoring.
> >  Refer to the :ref:`admin guide <damon_usage_sysfs_probes>` to know how users
> >  can use the mode.
> >  
> > +Data Attributes Reporting
> > +~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [ ... ]
> 
> > +For example, per-CPUs write-only monitoring can be configured using this
> > +infrastructure like below.
> > +
> > +The user sets a report buffer and enable CPU instruction sampling report for
> > +the buffer.  DAMON will enable perf event counter for CPU cycles sampling.  The
> > +sampling callback will save the sampling time CPU instruction and the id of the
> > +CPU that was executing it, into the DAMON report buffer, using
> > +damon_report_attrs().  DAMON can automatically adjust the perf event sampling
> > +frequency to minimize old report drops due to the buffer size limit.
> > +
> > +The user further sets a DAMON probe.  The probe hits for a given DAMON region
> > +if a store instruction for a memory in the region that was executed from a
> > +given CPUs group exists in the report buffer.  As a result, the probe hit
> > +counts represent relative frequency of writes from a given CPUs group to a
> > +given memory region.
> 
> [Severity: Medium]
> In the Data Attributes Reporting section of Documentation/mm/damon/design.rst,
> how can the DAMON probe determine whether a sampled store instruction targeted
> a given DAMON memory region if the callback only saves the CPU instruction and
> CPU ID from a generic CPU cycles counter?
> 
> A sampled instruction (or instruction pointer) only encodes the opcode and
> register operands, not the effective virtual or physical data address being
> written. Saving only the instruction and executing CPU ID via
> damon_report_attrs() does not appear to provide the target memory address
> needed to match against a DAMON region when the probe inspects the buffer.
> 
> Even if the perf overflow callback attempted to resolve the target data
> address at NMI time, generic CPU cycle counter interrupts
> (PERF_COUNT_HW_CPU_CYCLES) are non-precise on out-of-order CPUs and suffer
> from skid. At NMI time, regs->ip typically points to a subsequent instruction
> rather than the instruction that caused the overflow, and the register values
> in struct pt_regs may already have been modified.
> 
> Furthermore, without hardware data-address sampling features (such as Intel
> PEBS, AMD IBS, or Arm SPE populating perf_sample_data->addr or phys_addr,
> which are scoped for Milestone 3), resolving the effective address from a raw
> instruction would require fetching instruction bytes in NMI context, running
> an architecture-specific instruction decoder and address-calculation emulator,
> and translating virtual addresses to physical addresses for paddr monitoring.
> 
> How is the target memory address intended to be obtained and matched to DAMON
> regions in Milestone 2 with generic CPU cycle sampling?

Good question.  damon_report_attr() will save the register contents and pid
into report, too.  And the probe in kdamond context will decode the instruction
and get the memory address.  For physical address, it will also do the page
table walk of the process of the pid.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261017195747.89961-1-sj@kernel.org?part=1


Thanks,
SJ
