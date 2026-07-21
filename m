Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797F033F8C4
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611982; cv=none; b=TDtlH3VgPDhIPC+T7gEYRocAQNS/XMnOjlh2pF9S1jkfKy8GM63QcnhJkxRNir8/bDrX57mv/lY1K4ZL+qUGEMUfatgE/w/Jg6a2JxjKh93aI0wK5ARakkthy9mSbS5q8TVGlERGlgJ1n5kNcJo9S9pNIA+xq9jgRJnByS3AJkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611982; c=relaxed/simple;
	bh=zGGeydvhPoV4bq4Fc+744BMPE2qyioiMAPoCs+lxH/g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fxZJGoXNWRlp5j7rvNyNrTmbL9msBqkseq9WLAuiawbLoPe7glG6oOSJda1XrpckwiYz7+nU8dFE9QZm5OYsuaV9m6YJWqYFfiIbeOm/T9/lOHAy70TLsPiiQ5aXkyjiTJkcS7sIQ5hbkMKStpbNZNe/B/Hy1OGwzZrgSMpI3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUWAo9k/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUWAo9k/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6731F000E9;
	Tue, 21 Jul 2026 05:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784611981;
	bh=vxt7eIk64F0AvLULa6OmhahKV6KiHe96hogOjxG09iM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nUWAo9k/mR5CDu+ghWZP0TYeBdjJNQhHTA9fLBUXuAvGW6lxIGCK6CGVOoPqf2tqt
	 KWYbTCtPdH/0LzHhACHWOWs6E1k4AvnkwNnUCnFnwbyQv01wEOOGrldA8ekYs32veb
	 uZcOmyvIuiHc3kfxsoUrCpnmpU5ZPnVwlD+D2V15xZ1XA1IJXN7N36mdC3FPXcuQLm
	 RjGb79l0Nhi4E0Q7WbczaLrNV58kbgJaDDHOOX9p7Vr+v5v+Ex3fwc1eTVh5x8mxiJ
	 2OhILm9pe/n/sL78rVtCYcu2bK3nC3P39mAp7UZGmUCPFLOt7WSC3ZqlPNHhP/urat
	 R0lyb32c9wXpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/core: always put unsuccessfully
 committed target pids
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260721052238.163760-1-sj@kernel.org>
References: <2026072031-shingle-buddy-1bbb@gregkh>
 <20260721052238.163760-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 05:33:00 +0000
Message-Id: <20260721053301.0B6731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] PID references are leaked when damon_start() or late stages of c=
ontext building fail in damon_sysfs_turn_damon_on().
--

--- Patch [1]: [PATCH 6.12.y] mm/damon/core: always put unsuccessfully comm=
itted target pids ---
commit d053b994cdbf8e3fe384c68bbdb8f593cb5a45e5
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: always put unsuccessfully committed target pids

This commit fixes a PID leak by explicitly putting the PIDs of targets in
the commit operation when damon_commit_target() fails.

Link: https://lore.kernel.org/20260605013849.83750-1-sj@kernel.org
Link: https://lore.kernel.org/20260603112306.58490-1-akinobu.mita@gmail.com=
 [1]
Link: https://lore.kernel.org/20260320020056.835-1-sj@kernel.org [2]

> The source context will do the put operations using the above explained
> routine.  However, let's suppose the destination context was not
> originally using [f]vaddr operation set and the commit failed before the
> ops of the source context is committed.  The destination does not have the
> cleanup_target() ops callback, so it cannot put the pids via the
> damon_destroy_ctx().
>=20
> As a result, the pids are leaked.

[Severity: Medium]
This is a pre-existing issue, but does a similar PID leak happen in
mm/damon/sysfs.c when context building or starting fails?

For example, in damon_sysfs_build_ctx():

mm/damon/sysfs.c:damon_sysfs_build_ctx() {
	...
	err =3D damon_sysfs_apply_inputs(ctx, sys_ctx);
	if (err) {
		damon_destroy_ctx(ctx);
		return ERR_PTR(err);
	}
	...
}

If damon_sysfs_apply_inputs() fails during scheme addition (after targets
were successfully added and PIDs referenced), damon_destroy_ctx(ctx) is
called and the PIDs are leaked.

Similarly, in damon_sysfs_turn_damon_on():

mm/damon/sysfs.c:damon_sysfs_turn_damon_on() {
	...
	err =3D damon_start(&ctx, 1, false);
	if (err) {
		damon_destroy_ctx(ctx);
		return err;
	}
	...
}

If damon_start() fails (e.g., due to ENOMEM), the error path directly calls
damon_destroy_ctx(ctx). For vaddr operations, ctx->ops.cleanup is NULL,
and PID references are normally released by damon_sysfs_before_terminate().

However, since the thread is never started or the context is aborted early,
the termination callback is not called and the PIDs are never put.

Is this something that needs a similar fix to ensure these PIDs are
released?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721052238.1637=
60-1-sj@kernel.org?part=3D1
