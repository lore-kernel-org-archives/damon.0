Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45BE2D12EC
	for <damon@lists.linux.dev>; Thu, 30 Apr 2026 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562059; cv=none; b=djFT40F1ilOCKV1ISq7viFkr8s9NDukusMsE44hzMV7jnd0BmgpE9cKxzF2upBj1p4U4tzH5H6tUVeDdr1YuSrzdZ7k5OP0WfySK7c8blI5hn4/ryQNIPu9z+aZJhO+7eIm754CVs9dD6yzCOmrwCbMcQGvjmXMLK23xDoTOIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562059; c=relaxed/simple;
	bh=c/DQUzT/OnvKt4aYmeuybPQPCRxBge/9TgLZ6pLgP2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QbO/XMxAgmN6Wl/SVUKdW0xhdWILxn005uWayOaWTX0PGpzYVPUMiXPbKLkpE2HMif20OdilNjkLGmci8evgPI2Kq7OuAzszfbH8rB8XnkeyxloGwy+kWdoKDeLMawyGOS2O8wlzNSnJLBT6xAhtivaOIszUeBHO1Kv7BbrM/8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCHziwcw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCHziwcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589FEC2BCC7;
	Thu, 30 Apr 2026 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777562059;
	bh=c/DQUzT/OnvKt4aYmeuybPQPCRxBge/9TgLZ6pLgP2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iCHziwcw61FtosWcxar1Df2YXBK9WvSyUqlPqUJURMAZgQc1gLnZo6PPMOr9MjX03
	 sYuosknCSTqWqy/nIoO6yHC1CF0fo/6FhuAXQuiJclrf4c0BpXhQ7HRrm6r/zQ8aN0
	 Zd1ixmbAfPLg2dW8ytHCehS0pbydQDtTVC9MJwrz8lqpEkUJoNdWQMQDRCoUJCV4Y9
	 cWdTLXRdLHHMJ6ReV7dqSpIpdZ2/qUV9SURcX0UYHdfVHmT7J0HiPnoIIr19Qq5WEY
	 iRWbVRhk17bSUWaM547gy15Dgklpyh+RciPznBO8JCEj/9V6AKxDGSEyta4MdTZu40
	 Hem/tYg2aaJMA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 1/2] mm/damon/stat: add a parameter for reading
 kdamond pid
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260430142013.80993-2-sj@kernel.org>
References: <20260430142013.80993-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 15:14:18 +0000
Message-Id: <20260430151419.589FEC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added `kdamond_pid` module parameter lacks a `MODULE_PARM=
_DESC` declaration.
--

commit d56734720ba3e7838cd85a1ac6661cf5e54d9a3b
Author: SeongJae Park <sj@kernel.org>

mm/damon/stat: add a parameter for reading kdamond pid

Expose the pid of DAMON_STAT kdamond via a new read-only module parameter
named kdamond_pid. This standardizes DAMON module usage, as DAMON_RECLAIM
and DAMON_LRU_SORT also provide this information.

> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index f4d3203e92639..37964683839d0 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c
[ ... ]
> +static const struct kernel_param_ops kdamond_pid_param_ops =3D {
> +	.set =3D damon_stat_kdamond_pid_store,
> +	.get =3D damon_stat_kdamond_pid_load,
> +};
> +
> +/*
> + * PID of the DAMON thread
> + *
> + * If DAMON_STAT is enabled, this becomes the PID of the worker thread.
> + * Else, -1.
> + */
> +module_param_cb(kdamond_pid, &kdamond_pid_param_ops, NULL, 0400);

This isn't a bug, but should this module parameter include a MODULE_PARM_DE=
SC()
declaration?

Other parameters in mm/damon/stat.c like enabled, estimated_memory_bandwidt=
h,
and memory_idle_ms_percentiles have corresponding MODULE_PARM_DESC()
declarations.

> +
>  static int __init damon_stat_init(void)
>  {
>  	int err =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430142013.8099=
3-1-sj@kernel.org?part=3D1
