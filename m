Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF840D588
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190610; cv=none; b=VYz3VTNWomxkBvcvUA/rijJLxbeOcEJFsen9VCZL185cxE3LTSeKN0PbtDy+Pr1YvL2ln+gYl167V/GmiASsW7jU6qwstL3c5Qp/S4wwaT4A1BSQNMcjmZRLSpVRkZo4iPmOFlWLDLDc5I8fo0RgWArwYLTbjF07z+g5Kc22amo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190610; c=relaxed/simple;
	bh=eQ3rm1GO6AE/9FMoyGOJS23xI9mskNvgfYmsBIYdL7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eaJVfr0vM2KZIeTqfG7UO69j5l3U6saWLnhZVj1cIav90QORKpdzpjYqOqajOYQ7zRw6+qvtZaEb4Gzx4wT7jbMdsi4asC5m7lfG7ZiBFir3r3oIFsfJfX5VAUBUUUBQzdjdQQgXdQ7cxN3VmIOzyUYxTJdqxDvFOMBAGrSkHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZbmRyE1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZbmRyE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2C91F000FF;
	Mon,  5 Oct 2026 08:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791190609;
	bh=NM0EDRqBFkSKtk8pVsrBmvdsv707aMseT8ftw+6Wzjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CZbmRyE1tzCLqFYN4cXdulVGSAlCyAwxD20h5ov4bupze1Ze7iYEulX0fPNt1KFtD
	 UbutSt21tZA16OTrDZD+riUHz362TE/Pwc2qoxaMLNMe0VzrVEJNYZUj1pZG1nMODK
	 WTfx4je40CpxWc6BDZsfczuXQlV1c2tV9mz4G/nstdI23mzerZOh4nzvhz182Gjd6a
	 LISnKgfxNs2o/4pNlJP737RIhxpwLKZewWazr4w5zNeAG4ijAWZtxz9HNi9gkHDoKc
	 85rWhg+bU36tqXkdpDStz+QPj32rqVNxXdsfL/C6w4965N/LpePN+ACxonE4FvVCD+
	 Du7bTjvDkwtEw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 6/9] mm/damon/sysfs: expose perf_event prep
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-6-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
 <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-6-b03452e137f3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:56:48 +0000
Message-Id: <20261005085649.3F2C91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Wire the DAMON_PREP_PERF_EVENT prep type added to core.c and
> perf_source.h into sysfs, so user space can configure a PMU-backed
> probe entirely through the preps/N/ directory: type, config, config1,
> config2, freq, sample_period, sample_freq, wakeup_events, precise_ip,
> sample_phys_addr, sample_weight_struct, exclude_kernel, exclude_hv and
> single_instance.
>=20
> For example:
>=20
>   echo perf_event > .../probes/0/preps/0/prep_action
>   echo 8          > .../probes/0/preps/0/type
>   echo 0x100      > .../probes/0/preps/0/sample_period
>   echo 1          > .../probes/0/preps/0/sample_phys_addr
>=20
> damon_sysfs_set_perf_probe() builds the damon_perf_probe_event from the
> [ ... ]
> commit reads a consistent set of values.
>=20
> Co-developed-by: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-damon-perf=
-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com?part=3D6

