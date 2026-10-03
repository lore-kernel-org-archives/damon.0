Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA6444707
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062553; cv=none; b=sf/oL7ue/MLt6X3V5cboYv5gQ+StcIbMH0OyFgzvp9VmJOduchPDymln3hGZgZqF9cDTti4VIR8wFRYvBXmg+xWwEoEa1bgjk9ZwQQUR3Gu4MWHBtLVJija4Obg6q1b6fZOg5qR+lf1UAYO34M5wOoNEMe8z60CB466kBv0vjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062553; c=relaxed/simple;
	bh=beE0e5VF5bYrL0x8J/aWo3xD/z4RbXbNVlAAQKjMXv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bpXsY2nYEesZDEfdd/l2xiX6cv31BgU3O+2UZQV8wuK0fEPTINiSf9Pzdlfp9bV3q4Jp1pMHnn5eAB1OYbwebztIUPlzdS6ojZeuoVaf7g5QZ+sgVUmMQaDwj/3jsVoF+S9hyUcPDhoV5qA43NAT12rkHzoUcAwBYAsV/52VeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxCbh2Az; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxCbh2Az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0761F0089B;
	Sat,  3 Oct 2026 21:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791062551;
	bh=pXDMTnS3NhSzdxrZ3tpjR+kHHjoEV9Wng+hHx1SlNcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OxCbh2AzGpOoOZ7jlKbDErxBGtscL6Uvv7+NlYLihcDAExcuOQj7l1sxEMEUJyA3a
	 497h3dkwgSQ41+DIx86nuNOlH1Kk0kXkHQQA2sbPZeCgc+64XUjSs3ErAJ8e4LH3eq
	 4T+wlyJExgoB0B6QUOiUbpveLkRKAtWcZ/df/xTHzz3nMNvSOiw5FD+x6MSlFbeu51
	 jsirbthHP1JMrdPp7xotSqC7FDHszS3wqOX4MVGLOKYNPtAXXXXQ+KPZQT3AyTJM7C
	 s2IxBkOQNtn5cgOHZjopF5+SMwfJhcf/CSFQ4T3JKMQNBxII5jhSKX7zrB452EUUtv
	 G28Bjh1tdtH3A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/9] mm/damon: add perf-event overflow handler
 feeding the report ring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-3-0f00417b41bc@gmail.com>
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
 <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-3-0f00417b41bc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 21:22:31 +0000
Message-Id: <20261003212231.7C0761F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm/damon: uninitialized memory read of data->data_src in damon_per=
f_overflow()
- [Medium] mm/damon: off-by-one bounds check artificially limits max probes
--

commit 96712c62a34715ea96102373f3c70dda9da07873
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon: add perf-event overflow handler feeding the report ring

This commit adds a PMU-agnostic perf-event overflow handler that feeds acce=
ss
reports into DAMON. It runs in NMI context and translates hardware overflow
samples into physical or virtual address reports using a per-CPU ring buffe=
r.

> diff --git a/mm/damon/perf_source.c b/mm/damon/perf_source.c
> --- /dev/null
> +++ b/mm/damon/perf_source.c

[ ... ]

> +static void damon_perf_overflow(struct perf_event *perf_event,
> +				struct perf_sample_data *data,
> +				struct pt_regs *regs)
> +{

[ ... ]

> +	if (!report.paddr && !report.vaddr) {
> +		this_cpu_inc(damon_perf_samples_filtered);
> +		return;
> +	}
> +
> +	report.is_write =3D !!(data->data_src.mem_op & PERF_MEM_OP_STORE);

[Severity: High]
Is it safe to unconditionally read data->data_src.mem_op here?

The perf_sample_data structure is allocated on the stack by the PMU interru=
pt
handler and only partially initialized:

include/linux/perf_event.h:perf_sample_data_init() {
    ...
    data->sample_flags =3D PERF_SAMPLE_PERIOD;
    data->period =3D period;
    data->dyn_size =3D 0;
    ...
}

If the underlying PMU does not support data source tracking (i.e.
PERF_SAMPLE_DATA_SRC is not set in data->sample_flags), data->data_src will
contain uninitialized stack garbage.

Should this read be conditionally guarded by checking if data->sample_flags=
 &
PERF_SAMPLE_DATA_SRC is set, to avoid feeding random access reports into
DAMON?

[ ... ]

> +int damon_perf_probe_setup(struct damon_ctx *ctx,
> +			   struct damon_probe *probe,
> +			   struct damon_perf_probe_event *event)
> +{

[ ... ]

> +	/* Compute probe_idx by walking ctx->probes list */
> +	damon_for_each_probe(p, ctx) {
> +		if (p =3D=3D probe)
> +			break;
> +		idx++;
> +	}
> +	/*
> +	 * Probe indices are 1-based (0 is the zero-init sentinel).
> +	 * With DAMON_MAX_PROBES slots (0..DAMON_MAX_PROBES-1), valid probe
> +	 * indices are 1..DAMON_MAX_PROBES-1, so the 0-based list position
> +	 * must be < DAMON_MAX_PROBES-1.
> +	 */
> +	if (idx >=3D DAMON_MAX_PROBES - 1) {
> +		err =3D -ENOSPC;
> +		goto release_owner;
> +	}

[Severity: Medium]
Does this bounds check artificially limit the maximum number of allowed pro=
bes
by one?

The array has DAMON_MAX_PROBES elements, meaning a 1-based probe_idx can
safely be DAMON_MAX_PROBES (which translates to array index
DAMON_MAX_PROBES - 1).=20

If a user attempts to configure exactly DAMON_MAX_PROBES probes, won't this
check prematurely return -ENOSPC and drop the final slot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-damon-perf=
-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com?part=3D3
