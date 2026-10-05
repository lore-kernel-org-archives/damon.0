Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E748041B8CA
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190723; cv=none; b=Sc65y7bwtB9W8QKT8QT/T+Ke/at9Nv3E3ygIqkAUeaUbZZqCnPBAJzvIxTTXkYw+U4jzwE0i2JNHJQFYo8dnd1bVd/9tbIMn2nQOYHd7has3u7eHGzSBV1M1zMl0UTYbl/yKMA3nSqOyVoEDa9f67vrVT/MUIODIhh1bHf3D8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190723; c=relaxed/simple;
	bh=fNZvonwS26a+VwyUyKCjLk1yoJAe7c9/aFElKOVnHDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sa8qBwrA9FBaiwsXrNs6q+S/HyXQjpD0Wrq4oWR1uYG+bbOJbxKRQ+kaYrQRryo/g6KNxapeZ1dFk5T3a6jnHLhaiaxygOZ+PKmxS9JwUEqXYyjU2AUMtf2MvZMn27gU5L3xSsJ1FEfRS9ed+iuKxJq8OF7sQ73dPtvfb8sQw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV9cQBcO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV9cQBcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DAB1F000FF;
	Mon,  5 Oct 2026 08:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791190721;
	bh=ctByThK1XmTZvHYQIJPD8kIZ/y0vVnDbBn0OjlCI5nc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mV9cQBcO3Lyx3NFq1sEtU09a7AswCPCNA2X1mkWbittPAlegXSJfE13OXiIHBShW0
	 DFOeGTmE1DnNkV1/p6a9X/TKrCC+OOYuX+CInKxdIfxqY1ElkOKAQS5GQxe0HlAZ1K
	 cgjsng48i/Vw/NbpbDAPKy/TsjC911ubRmMKNoaWGO7xXyYP0CWGnFisM8oM0mJCwF
	 oCe8Qe7UNtkT2gXMoUe1X5l+v7W2kWccnReahb/tYUrpFc9Yt7aWYGZMltw07U+U0A
	 GOFkzc3jKi65McAYM1lhx0q6TPYScciW69onOCs1B3cwK8QLCfJXMkTyqtywFsQcnU
	 IYT2Lnl1vPgoA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 3/9] mm/damon: add perf-event overflow handler
 feeding the report ring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-3-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
 <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-3-b03452e137f3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:58:40 +0000
Message-Id: <20261005085841.66DAB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm: damon-perf drops valid memory accesses at physical or virtual =
page 0
- [Medium] mm: damon-perf setup silently succeeds even if PMU event creatio=
n fails on all CPUs
--

commit 8f5b12d04ef4011765be3438258e3b2a5a8d8eb7
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

mm/damon: add perf-event overflow handler feeding the report ring

This patch adds a PMU-agnostic perf-event overflow handler for DAMON. It
routes physical and virtual address access samples from a perf-event into
a per-context report ring.

> diff --git a/mm/damon/perf_source.c b/mm/damon/perf_source.c
> new file mode 100644
> index 0000000000000..65bbfe850e708
> --- /dev/null
> +++ b/mm/damon/perf_source.c
[ ... ]
> +static void damon_perf_overflow(struct perf_event *perf_event,
> +				struct perf_sample_data *data,
> +				struct pt_regs *regs)
> +{
[ ... ]
> +	if (data->sample_flags & PERF_SAMPLE_PHYS_ADDR)
> +		report.paddr =3D data->phys_addr & PAGE_MASK;
> +	if (data->sample_flags & PERF_SAMPLE_ADDR)
> +		report.vaddr =3D data->addr & PAGE_MASK;
> +
> +	if (!report.paddr && !report.vaddr)
> +		return;

[Severity: High]
Does this check mistakenly drop legitimate accesses to physical or virtual
page 0? If only PERF_SAMPLE_PHYS_ADDR is requested, accesses to the first
physical page will have report.paddr =3D=3D 0 and report.vaddr =3D=3D 0, ca=
using
this logic to silently discard valid memory accesses.

> +
> +	if (data->sample_flags & PERF_SAMPLE_DATA_SRC)
[ ... ]
> +static int damon_perf_cpu_online(unsigned int cpu, struct hlist_node *no=
de)
> +{
[ ... ]
> +	perf_event =3D perf_event_create_kernel_counter(&attr, cpu, NULL,
> +						      damon_perf_overflow,
> +						      event);
> +	if (IS_ERR(perf_event)) {
> +		pr_warn_ratelimited("damon-perf: cpu %u event create failed: %ld\n",
> +				    cpu, PTR_ERR(perf_event));
> +		return 0;
> +	}
> +	per_cpu(*perf->event, cpu) =3D perf_event;
> +
> +	perf_event_enable(perf_event);
> +	return 0;
> +}
[ ... ]
> +int damon_perf_probe_setup(struct damon_ctx *ctx,
> +			   struct damon_probe *probe,
> +			   struct damon_perf_probe_event *event)
> +{
[ ... ]
> +	err =3D cpuhp_state_add_instance(damon_perf_cpuhp_state,
> +				       &event->hlist_node);
> +	if (err)
> +		goto free_event;
> +
> +	return 0;

[Severity: Medium]
Could this setup silently succeed even if PMU event creation fails on all
CPUs?

In damon_perf_cpu_online(), when perf_event_create_kernel_counter() returns
an error, it rightly returns 0 to avoid breaking CPU hotplug. However,
damon_perf_probe_setup() relies on the return value of
cpuhp_state_add_instance().

If a user provides an invalid PMU configuration, event creation will fail
everywhere, but the setup will succeed without error, leaving DAMON running
without any armed counters. Should there be a check to verify that at least
one counter was successfully created?

> +
> +free_event:
> +	free_percpu(perf->event);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-damon-perf=
-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com?part=3D3
