Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6482B361952
	for <damon@lists.linux.dev>; Sun, 18 Oct 2026 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792353483; cv=none; b=Y8K5zdOhgBPh5/OYfF1nwmkNbNmrcDep4zts/Q/oHd42no29Ur98ugyu0kNKGfeFpze/YrSp3MvARBd3RlM8GOyLOcHLsGiKg4UvekmP4y/VvhVyMn5+A7RF71XoDaJDEq0lLCGvsQqgnV/HfLoUwTo120qVxe7a7DJojfTUd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792353483; c=relaxed/simple;
	bh=n5dEWTCvml8selQ8PakWTHsJbUmgO1h/ViaGqSbGiSo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HxXzaLN/mo6mKYEtUCLYTY0Z708bkIFjhspRLcdM6v8EFvoo0pcOZdi+VxmXn4V7NmM2K77KPTUKKoEOsx1P9X8dToM+IfVwwIi0HBZ8aRArGWEt8e842z+Rkam8iL8Y0mq7/23AqyVKANW9NnB1DoYR0XMVRrbWTROU4+iradY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9hcXXIO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9hcXXIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7671F000C4;
	Sun, 18 Oct 2026 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792353482;
	bh=AIOucBP32EXAvdFmVl9jGmz89VxayFbvcT9hhk5+fL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A9hcXXIOPAqR1GxiAtBM2jlUUcTs39/OiWT8IquTXexRzR3ymYoeH/+spx2HABzRv
	 LvpkDUfyZcdQ9DuVW1MOAKUMA05PyAXOzr1njtEIq4nSl4+g5jkhAF0U+Ya9/GkfiQ
	 SHGL5PaRYeWaa/7lEHQUBGnb0MabnIPjTQN2fy/JHacWtKCV4Y69f6F8ErDFc5yVm5
	 1DCQG7yXg3ys0rB3c6gaTHRKEk8YW5HZjF5GQzeszPASD1ECnZwSTCP2RXjMValyhp
	 10r37YsWRvn/TC0lniRIrZof/8ldtXNdmpviaEA2nsF2tLPLfilcDvEvFIkuzycUOh
	 v6GyxwyMH4Y7g==
Message-ID: <sashiko-outbox-176355@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v0] Docs/mm/damon/design: document data attributes
 report infra design (beyond page table accessed-bit milestone 2)
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Randy Dunlap" <rdunlap@infradead.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261017195747.89961-1-sj@kernel.org>
References: <20261017195747.89961-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 19:58:01 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Docs/mm/damon: CPU cycle instruction sampling lacks target memor=
y address
--

commit a164f9ff38c8cd1963db3e0c7ea062dbc93135a3
Author: SJ Park <sj@kernel.org>

Docs/mm/damon/design: document data attributes report infra design (beyond =
page table accessed-bit milestone 2)

This patch documents the high-level design for DAMON's data attributes
reporting infrastructure, including the damon_report_attrs() API and an
example use case for per-CPU write-only monitoring using perf CPU cycles
sampling.

> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/d=
esign.rst
> index a465e34bb1d9c..1e699e3f8a496 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -433,6 +433,50 @@ monitoring.
>  Refer to the :ref:`admin guide <damon_usage_sysfs_probes>` to know how u=
sers
>  can use the mode.
> =20
> +Data Attributes Reporting
> +~~~~~~~~~~~~~~~~~~~~~~~~~

[ ... ]

> +For example, per-CPUs write-only monitoring can be configured using this
> +infrastructure like below.
> +
> +The user sets a report buffer and enable CPU instruction sampling report=
 for
> +the buffer.  DAMON will enable perf event counter for CPU cycles samplin=
g.  The
> +sampling callback will save the sampling time CPU instruction and the id=
 of the
> +CPU that was executing it, into the DAMON report buffer, using
> +damon_report_attrs().  DAMON can automatically adjust the perf event sam=
pling
> +frequency to minimize old report drops due to the buffer size limit.
> +
> +The user further sets a DAMON probe.  The probe hits for a given DAMON r=
egion
> +if a store instruction for a memory in the region that was executed from=
 a
> +given CPUs group exists in the report buffer.  As a result, the probe hit
> +counts represent relative frequency of writes from a given CPUs group to=
 a
> +given memory region.

[Severity: Medium]
In the Data Attributes Reporting section of Documentation/mm/damon/design.r=
st,
how can the DAMON probe determine whether a sampled store instruction targe=
ted
a given DAMON memory region if the callback only saves the CPU instruction =
and
CPU ID from a generic CPU cycles counter?

A sampled instruction (or instruction pointer) only encodes the opcode and
register operands, not the effective virtual or physical data address being
written. Saving only the instruction and executing CPU ID via
damon_report_attrs() does not appear to provide the target memory address
needed to match against a DAMON region when the probe inspects the buffer.

Even if the perf overflow callback attempted to resolve the target data
address at NMI time, generic CPU cycle counter interrupts
(PERF_COUNT_HW_CPU_CYCLES) are non-precise on out-of-order CPUs and suffer
from skid. At NMI time, regs->ip typically points to a subsequent instructi=
on
rather than the instruction that caused the overflow, and the register valu=
es
in struct pt_regs may already have been modified.

Furthermore, without hardware data-address sampling features (such as Intel
PEBS, AMD IBS, or Arm SPE populating perf_sample_data->addr or phys_addr,
which are scoped for Milestone 3), resolving the effective address from a r=
aw
instruction would require fetching instruction bytes in NMI context, running
an architecture-specific instruction decoder and address-calculation emulat=
or,
and translating virtual addresses to physical addresses for paddr monitorin=
g.

How is the target memory address intended to be obtained and matched to DAM=
ON
regions in Milestone 2 with generic CPU cycle sampling?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017195747.8996=
1-1-sj@kernel.org?part=3D1
