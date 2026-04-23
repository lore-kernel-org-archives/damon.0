Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBAA219303;
	Thu, 23 Apr 2026 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776907321; cv=none; b=cJTLsfmyr+2kt2C8m6kSSgdE/228E1pOIMagm828GYYfELdWLhu2YADmDsshUfr4JFuEW5mOWrPWa3scJRVUmp5o2GG8mCfjXChRa52TsdMAiXNuJnpB3pPIUQJ6NAqqFelhoYUQNK+blsY0A60q+2AOylvqfIK+Twi3vFbnetQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776907321; c=relaxed/simple;
	bh=EnCedkb3XVDzVcvu88jL0boWfgFwhTeskY/8A0Dc0t8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MjYT/w40f7eE2MKit/rJgL/TboFVB5yg23mV6q4y/iCVvKp4nqXwG+EKUP2GVQ6HZ44zS98zaW9lkvLVzDiWJ7FgtUPobuHmpbWF+BcPqifFMTYdL3Egr+nev0NYWT4leNtbyOFeZWJ8ZvesXNwuy+oTTFZwXO/BXLHlPmLUWjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rArPaMxG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rArPaMxG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955F7C2BCB2;
	Thu, 23 Apr 2026 01:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776907320;
	bh=EnCedkb3XVDzVcvu88jL0boWfgFwhTeskY/8A0Dc0t8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rArPaMxGAc2U4eTAMO3jWoRf4LeT2bd9MnEBOITAcLo8eq6m1tpFiG0C5yjQ+EaNi
	 8cjy4a08fEu3Ps9FPUXXmlNUsC34i+MK0+JiP+GXHAoxdeHKSwUslDaf81YOwwjDKH
	 XwGYXOo9smbyQ1SQpXJIk33tREaDGK3PJfgVc76i4g/l9fNG7b8ZjAmhJOXgZ6pswb
	 E5P8nXF87R0gTFKQSxsNejOh6tGPPIGtUr6d6dlwcWa5iUCC74SlqKhLYIEgvMQ83F
	 /Qci6t4CL4P+V+UlxzGSJ0c1BevsfkvX9OZEkvMrUQRjiL++0KjlR8xH4So2+Km6hK
	 +3Yx+PUZMM9Cg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/4] mm/damon/core: add code borrowed from
 report-based monitoring work
Reply-To: sashiko@lists.linux.dev
To: "Akinobu Mita" <akinobu.mita@gmail.com>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org
In-Reply-To: <20260423004211.7037-2-akinobu.mita@gmail.com>
References: <20260423004211.7037-2-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 01:21:59 +0000
Message-Id: <20260423012200.955F7C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 2 potential issue(s):
- [Medium] Stack bloat / stack overflow risk from `cpumask_t` allocation on=
 the stack.
- [Medium] Data race and potential torn reads from lockless assignment of `=
cpumask_t`.
--

commit 9c32a9c6100e762865883bc9bf4b2272ccb6dedb
Author: Akinobu Mita <akinobu.mita@gmail.com>

mm/damon/core: add code borrowed from report-based monitoring work
   =20
This commit borrows code from the report-based monitoring infrastructure
to support perf event-based monitoring. It brings in struct
damon_access_report, an access_reported field in damon_region, and the
sample/primitives sysfs directory structure.
   =20
Link: https://lore.kernel.org/linux-mm/20251208062943.68824-6-sj@kernel.org=
/T/

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index eefa959aa30ae..c19556f2af3bb 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
[ ... ]
> +static ssize_t cpumask_store(struct kobject *kobj, struct kobj_attribute=
 *attr,
> +		const char *buf, size_t count)
> +{
> +	struct damon_sysfs_sample_filter *filter =3D container_of(kobj,
> +			struct damon_sysfs_sample_filter, kobj);
> +	cpumask_t cpumask;

Is it safe to allocate cpumask_t on the stack here?

The size of cpumask_t scales with CONFIG_NR_CPUS. On systems with a large
number of CPUs, this could consume a significant amount of the kernel stack
and potentially risk a stack overflow. Should this use alloc_cpumask_var()
instead to dynamically allocate the temporary mask?

> +	int err =3D cpulist_parse(buf, &cpumask);
> +
> +	if (err)
> +		return err;
> +	filter->cpumask =3D cpumask;

Can this lockless assignment cause a data race or torn reads?

Because cpumask_t can be larger than a single word, this assignment may
compile into a non-atomic multi-word copy like memcpy(). If a concurrent
sysfs read in cpumask_show() or a DAMON commit operation accesses
filter->cpumask while this copy is ongoing, could it read a partially
updated, torn mask?

Should this be protected by explicit synchronization, such as
damon_sysfs_lock?

> +	return count;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423004211.7037=
-1-akinobu.mita@gmail.com?part=3D1
