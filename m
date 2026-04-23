Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046D1F3BAC;
	Thu, 23 Apr 2026 01:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776909505; cv=none; b=XK/l/YpvGEX9R6vqj9sKcnF0vtcDG/Hfus26/P1rGoudEO+D9duguIhppqzo3iqz8U6UJyb4nX+a5w9fuV49SlxD6rjYl3EHh7TUZ3Yu3NndOyAPpIfP0qtN0Mdr4PcAb4CyRdnd0jVNCFzZxaRcP6R9pOonT+iYxINuCvlxzB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776909505; c=relaxed/simple;
	bh=7qjVSZ0y4uK92gP1+iWZIbutBMCD1ZuX8IfQRVeuMcA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZZFWs229CKCLX+oGDcosjV6OCbX8d24xh9vv35CG1ZJkkG+wqZLHwvwI+6J47NGi9E4OOI4d1y2EaA79FyG7pd++ANxIlNNBwJkTq9q8mP0zb8zXg6zZYTYzsPHWTEH0rrClN8qZJgnBcLFQrs7NvQ/2H9YhYNGXyzgLLuCjr64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYXFXZHt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYXFXZHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81098C19425;
	Thu, 23 Apr 2026 01:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776909504;
	bh=7qjVSZ0y4uK92gP1+iWZIbutBMCD1ZuX8IfQRVeuMcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qYXFXZHt9BIJGmlM8yS6HZJZegeIcTuWzgKcuUHTPK61SwiOe1u81Y60UCAavNTcN
	 EZXWfI/BkrJhzuy6JaUmB5Zpyn0ofKyRRvXdiqtzcUWPAqNrM3ZExlCauLOzqIGJlM
	 EubceICP5U4qKblcM55gl3k72da0dlgsf0Zq7CeihzJSuSwvfSyGmM6b6KmzVclcUx
	 0Lb8TXRNp/Nma+y+j2/b4EJt+aM2MtjYdihMeWBZJw/ggsuRfZE3ngedV/f5fpxs9j
	 /nFNOA8GdHPYsJd9vciXNxxRQA0EKFsLcmyVLsdvM5fsQo7h7YMQKwHhOAKFXzffpW
	 zO7UMxc7kgRwQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/4] mm/damon/core: add common code for perf
 event based access check
Reply-To: sashiko@lists.linux.dev
To: "Akinobu Mita" <akinobu.mita@gmail.com>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org
In-Reply-To: <20260423004211.7037-3-akinobu.mita@gmail.com>
References: <20260423004211.7037-3-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 01:58:23 +0000
Message-Id: <20260423015824.81098C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 3 potential issue(s):
- [High] Memory leak in `damon_perf_init()` when `perf_event_create_kernel_=
counter()` fails with `-ENODEV` for all CPUs.
- [Medium] Unnecessary `PERF_SAMPLE_WEIGHT_STRUCT` flag in perf event attri=
butes arbitrarily restricts hardware compatibility.
- [Low] Linker error when `CONFIG_DAMON_VADDR=3Dn` but `CONFIG_PERF_EVENTS=
=3Dy`.
--

commit 97617fb5ae7981867a46207cd14a68c3cbb4813d
Author: Akinobu Mita <akinobu.mita@gmail.com>

mm/damon/core: add common code for perf event based access check

This commit creates the necessary infrastructure (structure definitions,
functions, sysfs interfaces) to support perf event based access checks
for both physical and virtual address space monitoring.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index a52b2962aa22a..220b105482daa 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -2933,6 +2990,7 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
>  	unsigned long sample_interval =3D ctx->attrs.sample_interval ?
>  		ctx->attrs.sample_interval : 1;
>  	struct damos *scheme;
> +	struct damon_perf_event *event, *next;
> =20
>  	ctx->passed_sample_intervals =3D 0;
>  	ctx->next_aggregation_sis =3D ctx->attrs.aggr_interval / sample_interva=
l;
> @@ -2945,6 +3003,15 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
>  		damos_set_next_apply_sis(scheme, ctx);
>  		damos_set_filters_default_reject(scheme);
>  	}
> +
> +	list_for_each_entry_safe(event, next, &ctx->perf_events, list) {
> +		int err =3D damon_perf_init(ctx, event);

If the kernel is configured with CONFIG_DAMON_VADDR=3Dn and
CONFIG_PERF_EVENTS=3Dy, will this cause a linker error? The function
damon_perf_init() is defined in mm/damon/vaddr.c, which would not be
compiled in that configuration.

> +
> +		if (err) {
> +			list_del(&event->list);
> +			kfree(event);
> +		}
> +	}
>  }
> =20
>  /*
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index b069dbc7e3d25..1534372e7637c 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
[ ... ]
> @@ -936,6 +939,161 @@ static int damon_va_scheme_score(struct damon_ctx *=
context,
>  	return DAMOS_MAX_SCORE;
>  }
> =20
> +#ifdef CONFIG_PERF_EVENTS
[ ... ]
> +int damon_perf_init(struct damon_ctx *ctx, struct damon_perf_event *even=
t)
> +{
> +	struct damon_perf *perf;
> +	struct perf_event_attr attr =3D {
> +		.type =3D PERF_TYPE_RAW,
> +		.size =3D sizeof(attr),
> +		.type =3D event->attr.type,
> +		.config =3D event->attr.config,
> +		.config1 =3D event->attr.config1,
> +		.config2 =3D event->attr.config2,
> +		.sample_freq =3D event->attr.sample_freq,
> +		.freq =3D 1,
> +		.sample_type =3D PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR |
> +			PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC |
> +			(event->attr.sample_phys_addr ? PERF_SAMPLE_PHYS_ADDR : 0) |
> +			PERF_SAMPLE_WEIGHT_STRUCT,

Does this configuration need to include PERF_SAMPLE_WEIGHT_STRUCT?

The overflow handler damon_perf_overflow() doesn't appear to read any
weight metrics from the sample data. If the underlying hardware PMU does
not support extended weight sampling, could this cause
perf_event_create_kernel_counter() to return -EINVAL and unnecessarily
reject the configuration?

> +		.precise_ip =3D 2,
> +		.pinned =3D 1,
> +		.disabled =3D 1,
> +	};
> +	int cpu;
> +	int err =3D -ENOMEM;
> +	bool found =3D false;
> +
> +	perf =3D kzalloc_obj(*perf);
> +	if (!perf)
> +		return -ENOMEM;
> +
> +	perf->event =3D alloc_percpu(typeof(*perf->event));
> +	if (!perf->event)
> +		goto free_percpu;
> +
> +	perf->buffer =3D alloc_percpu(typeof(*perf->buffer));
> +	if (!perf->buffer)
> +		goto free_percpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct perf_event *perf_event;
> +		struct damon_perf_buffer *buffer =3D per_cpu_ptr(perf->buffer, cpu);
> +
> +		perf_event =3D perf_event_create_kernel_counter(&attr, cpu, NULL,
> +				damon_perf_overflow, event);
> +		if (IS_ERR(perf_event)) {
> +			err =3D PTR_ERR(perf_event);
> +			if (err =3D=3D -ENODEV)
> +				continue;
> +			pr_err("perf event create on CPU %d failed with %d\n", cpu, err);
> +			goto free_for_each_cpu;
> +		}
> +		found =3D true;
> +		*per_cpu_ptr(perf->event, cpu) =3D perf_event;
> +
> +		buffer->size =3D DAMON_PERF_INIT_RECORDS;
> +		buffer->reports =3D kvcalloc_node(buffer->size, sizeof(buffer->reports=
[0]),
> +						GFP_KERNEL, cpu_to_node(cpu));
> +		if (!buffer->reports)
> +			goto free_for_each_cpu;
> +	}
> +	event->priv =3D perf;
> +
> +	return found ? 0 : -ENODEV;

If perf_event_create_kernel_counter() returns -ENODEV for all possible CPUs,
the found flag remains false, and this returns -ENODEV.

Since the caller will receive a non-zero error code and free the event
wrapper without calling damon_perf_cleanup(), does this leak the memory
allocated for perf, perf->event, and perf->buffer?

> +
> +free_for_each_cpu:
> +	for_each_possible_cpu(cpu) {
> +		struct perf_event *perf_event =3D per_cpu(*perf->event, cpu);
> +		struct damon_perf_buffer *buffer =3D per_cpu_ptr(perf->buffer, cpu);
> +
> +		if (perf_event)
> +			perf_event_release_kernel(perf_event);
> +		kvfree(buffer->reports);
> +	}
> +free_percpu:
> +	free_percpu(perf->event);
> +	free_percpu(perf->buffer);
> +	kfree(perf);
> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423004211.7037=
-1-akinobu.mita@gmail.com?part=3D2
