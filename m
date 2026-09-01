Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B599372B2B
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238396; cv=none; b=pS8XpsZfXX4bXOKN6GknrAAIBgsJDLpTpmIzgejYhM1NWx/TTZMP6m3f4D22Xr3bKVzcFchyqu5jav193BLKCaOwniCrjpjZYAYccHKTRQerQCR1n4HqhLgh3t0TQSkuXdpzzBqTcyLe+A6K8mG6DTMgQZW+BxQI7kmfOD7wVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238396; c=relaxed/simple;
	bh=SC6spaVV3/KblvtiJJwwdXNK4ETH0wDWSeZtog4O5+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C7m9UihUeWe6MQN5otMZ3GvK00jHNb2JtGTqpzxseT0M02VE9rYQRlUG87RtZO3CbwiUGfHIwSArZsvc0YS9TQw2QA3/dHnPF+cx+MBduY0JEHpcUc+P3srN2DeuOCUKwsdEWAqZkjUjGrlh3Zk9X6xjAo3cQA8v0CDWwaX8Al8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwAcRdVd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwAcRdVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8631F000E9;
	Tue,  1 Sep 2026 04:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788238394;
	bh=eBNS+k0lcKOK+DNNo8LSHNipKRDGHKedF+XPG8hxu2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NwAcRdVdV51f+esPhvvZQ+8Q8GBYWXJZJi8n4OSOkbLje/VVR02xlOBuPmPV5gxsx
	 adLrN6fTVifGB2APTGCJBV2X++kmboJym7GnYW3zA2NkG6EBYf4xJO2F5sx9tDomfK
	 3sieUffgQnTQcVphf4Lb2qJu3kyuzwZNcwn5Nvbg/SBlpcjRZgxdy+21ff5679NG0B
	 Ll9JtItLzgbmhVuEj4jEK7B7PYIX6JG1OT8wCKKs3dXhc/AJykmhwVI74CohiOk2BV
	 Pc7fe+yOLihCR7JNNb45IqerIXbVgvH8u2/kd1bd++t7BEHRveY5aSIFdhOTIPmSQW
	 I9+KyPv1C5ULw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/17] mm/damon/sysfs: pass preps to DAMON core
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-14-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-14-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:53:14 +0000
Message-Id: <20260901045314.9C8631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Data race on `sys_prep->action` due to lockless read and write
--

commit 09b46cd761363fb28603bd1d27adb637a6c16a7d
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: pass preps to DAMON core
   =20
DAMON sysfs interface provides the files for setting DAMON probe preps.
But the underlying code is not really passing the user-set values to
DAMON core.  Pass those.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index c0130843223d7..d02f5f8ceae5b 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -2176,6 +2176,23 @@ static int damon_sysfs_set_attrs(struct damon_ctx =
*ctx,
>  	return damon_set_attrs(ctx, &attrs);
>  }
> =20
> +static int damon_sysfs_set_preps(struct damon_probe *probe,
> +		struct damon_sysfs_preps *sys_preps)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < sys_preps->nr; i++) {
> +		struct damon_sysfs_prep *sys_prep =3D sys_preps->preps_arr[i];
> +		struct damon_prep *prep;
> +
> +		prep =3D damon_new_prep(sys_prep->action);

[Severity: Low]
Could this result in a data race on sys_prep->action?

During DAMON context building, this locklessly reads the action enum while a
concurrent root user could be writing to the /sys/.../prep_action attribute.

A concurrent write to prep_action could happen while another process issues=
 a
commit command to the state file, which runs damon_sysfs_commit_input
asynchronously on the kdamond thread without holding damon_sysfs_lock.

Would it be better to use READ_ONCE() here, along with a corresponding
WRITE_ONCE() on the writer side, to adhere to the Linux Kernel Memory Model
guidelines and avoid potential KCSAN warnings?

> +		if (!prep)
> +			return -ENOMEM;
> +		damon_add_prep(probe, prep);
> +	}
> +	return 0;
> +}
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D13
