Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707445;
	b=JwuGHJLoqLFQs7fi+2BJiPQ5wbrl8RMb4QYFK1+ne90FK280ryYmOtuaO2moa3uu6sdI
	 3zJ5KLNC+nmcpR3rO5RF0SS7R11+lFM+XtqNGKk0WUP/Erg4wWaq4MH4j0XmURCidEaqV
	 Gkpk2Zv3yKlps6JhrSw/uxwmqLbhj4AeeO2cr4aWlxiCdrQ0VxtRpI0MQtXPa1KfJCoGr
	 97WJB+x5LUnlcNb8pPt5rXOzNuUhoM+CcbceMqZHNFi3J8f3SCgalBJJBAkNUxsC+hQBl
	 LiZ4mceKyOR+XCgQAQt18+W1RaDzEon9qpEG0eT1yZ4T7BG2K5vs59DxQGA5qzsWhmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707445;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5WHfBAJW7tBZ/jpc0vscD0oFhU+5t1WH3jV5FJLIBPk=;
	b=TpqC5M8yy1ud1Q/Gp6YXyyVmDwGY9FNDmZSrJoMbA5hzMZg2TN5alP5JS2bq8li8EjB9
	 4vfMRQrRMBFMoeiiUL+wanVcI6WNaVUmXSGllDWsSlRa2mqmg6htXhuWMP+bVtWsp2SP0
	 u6AJh3xaL0eXTm1GING9NtD4tS6/MmXhR3Z4LfdTcKB0R/7Tj4TN2rYaQ4w51VVA9Yl9j
	 uT6wZvrIk+J68kd9rXavXkZBpOXNdXR4/jIzoZNgbsZU2bE8597hb/hVNscc6zgQdy81Q
	 T+IIYZbtPQG4Nfy1aazvoqYs9bVUZF1oJNL52Xe6VRj9CBTcdowEq2RmTXPwXjEtYiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlEqMa82;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72441606A32C
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlEqMa82
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8640E1F000C1;
	Tue,  3 Nov 2026 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793707444;
	bh=5WHfBAJW7tBZ/jpc0vscD0oFhU+5t1WH3jV5FJLIBPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DlEqMa82fbVZ/wFQkULtTKCChAspiAFzDxCBp7GTVibIsug4Us8FezHdufB+IZahV
	 Tpal14x6qpiFlrt+hLxWaHVZQpOAszvYFFcQsM3CFa1K4pcyTZj3fl4b16BjhbqaNy
	 ITjHL9UNi2RUO2xMHBLyGiEnjg2aqfFTWQrI2EiYWvETHs769cBEeWrhlmpxd2TzZ1
	 ZGs5goW1XnHJ5vWmr3s1z5+tiEmSh2M6iMr0hBfwMxH8gcwTzCGUJ5VylS1L3rj93R
	 fEVq9wAG9Q4XoPw79lqLELrgQt57eQUo5M1lh2KM4k0XwbHcs2Y4q39NZPLbv5OXxz
	 0J/bpmgxHeEDw==
Message-ID: <sashiko-outbox-195212@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] Docs/admin-guide/mm/damon/reclaim: improve language
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manuel Ebner" <manuelebnerli@mailbox.org>, "SJ Park" <sj@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>
Cc: "Aveline Noir" <jm5905938@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261103120043.100887-2-manuelebnerli@mailbox.org>
References: <20261103120043.100887-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 12:04:04 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Docs/mm/damon: typo 'aimes' introduced in reclaim.rst
--

commit 553db5dbc4617619eacc8a4470aca6b0504960ff
Author: Manuel Ebner <manuelebnerli@mailbox.org>

Docs/admin-guide/mm/damon/reclaim: improve language

This commit improves the grammar, tense consistency, and phrasing in the
DAMON_RECLAIM administration guide documentation.

> diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentati=
on/admin-guide/mm/damon/reclaim.rst
> index 028947f5da8ec..aeb2770f1d03e 100644
> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> @@ -4,7 +4,7 @@
>  DAMON-based Reclamation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -DAMON-based Reclamation (DAMON_RECLAIM) is a static kernel module that a=
imed to
> +DAMON-based reclamation (DAMON_RECLAIM) is a static kernel module that a=
imes to
>  be used for proactive and lightweight reclamation under light memory pre=
ssure.
>  It doesn't aim to replace the LRU-list based page_granularity reclamatio=
n, but
>  to be selectively used for different level of memory pressure and requir=
ements.

[Severity: Low]
In the DAMON-based Reclamation introduction in
Documentation/admin-guide/mm/damon/reclaim.rst, "aimes" is a typo. Should
this be "aims" instead?

[ ... ]

> @@ -88,7 +89,7 @@ identifies the region as cold, and reclaims it.
>  autotune_monitoring_intervals
>  -----------------------------
> =20
> -If this parameter is set as ``Y``, DAMON_RECLAIM automatically tunes DAM=
ON's
> +If this parameter is set to ``Y``, DAMON_RECLAIM automatically tunes DAM=
ON's
>  sampling and aggregation intervals.  The auto-tuning aims to capture mea=
ningful
>  amount of access events in each DAMON-snapshot, while keeping the sampli=
ng
>  interval 5 milliseconds in minimum, and 10 seconds in maximum.  Setting =
this as
> @@ -113,10 +114,10 @@ quota_sz

[ ... ]

> @@ -137,7 +138,7 @@ quota_mem_pressure_us
> =20
>  Desired level of memory pressure-stall time in microseconds.
> =20
> -While keeping the caps that set by other quotas, DAMON_RECLAIM automatic=
ally
> +While keeping the caps that are set by other quotas, DAMON_RECLAIM autom=
atically
>  increases and decreases the effective level of the quota aiming this lev=
el of
>  memory pressure is incurred.  System-wide ``some`` memory PSI in microse=
conds
>  per quota reset interval (``quota_reset_interval_ms``) is collected and

Also, this isn't a bug, but in the autotune_monitoring_intervals section ju=
st
above:

  Setting this as ``N`` disables the auto-tuning.

and in the quota_autotune_feedback section just below quota_mem_pressure_us:

  While keeping the caps that set by other quotas, DAMON_RECLAIM automatica=
lly

should those also be updated to "Setting this to" and "that are set by" to
match the changes in this patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103120043.1008=
87-2-manuelebnerli@mailbox.org?part=3D1
