Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00B31A053
	for <damon@lists.linux.dev>; Thu, 14 May 2026 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722764; cv=none; b=fca2MeQILKyLJVbQPb21eErD/bd9WOxClqTtQas16Gib8FhSq3NJjNamOKsYAy9MBp82clROwSTA/LpSF7CpzwUIdQMAcL3I+aqkvdFngs7wry9NNCtkHaZGeWMPGJbC2bbxpVVFpgyDLSHrRO1Sm+8kG09DfgXmCGAyqXaTuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722764; c=relaxed/simple;
	bh=DBad2DZ//DthS4EItJjd6MowoY0YFq4oOycgX5SF3+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dx3dPfbvOqct1FB98kVC3W3oPoyn0iY5I+uibi2TvoZjYPCYTWY2oQj/eRcahAziydcIV1QQZq4UqOB0+LLf4VmpwTc4tgFf4fhfLYtW/WXIlJbaWDJ92seq73EIpIXaHYWLY6EbsOnmYGYrv0vEjaFBIWgSgfW8ibqopWI16RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgZJaHmB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgZJaHmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D23C19425;
	Thu, 14 May 2026 01:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778722764;
	bh=DBad2DZ//DthS4EItJjd6MowoY0YFq4oOycgX5SF3+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KgZJaHmBZQpW4GHZUR6Ikkgm/g331RMLdqJihqkRxeM02SfUG7hLPqWAidKIOo+if
	 BySC00Wva5vGo/GkPEdZIoA86F44Taz8eWR2f/vVZnvrXL60swjPq90/r72Tkbi9II
	 /lmp9WrKvpN92uo8viYO12+vUcZb1/kAoZK2Hv9l23ljUrvVClrYi1vgQzf+oczkuu
	 +3nCL/947AsrDbin57FaktmbjHrjKaWRLXAjyiMLsKYTx8MDuRBh+XjtlDs4WN1lwm
	 Sw6XySRpu0bahhcNdhUPAtyU6GcuGTACMPLaBqzTNUsm19Mk/CbD2T9eLUOQAr9Vms
	 l6JtRbLO9/sZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y 1/2] mm/damon/core: implement damon_kdamond_pid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260513043039.173237-1-sj@kernel.org>
References: <20260513043039.173237-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:39:23 +0000
Message-Id: <20260514013924.20D23C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message references a non-existent function `damon_is_=
running()` and makes inaccurate claims about the current state of API calle=
rs.
--

commit 79a54a37fc83e2191edada566d0eb1ab79303fd8
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: implement damon_kdamond_pid()

This commit hides the kdamond and kdamond_lock fields from DAMON API callers
by implementing a new damon_kdamond_pid() function to retrieve the worker
thread's PID.

Link: https://lkml.kernel.org/r/20260115152047.68415-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20260115152047.68415-2-sj@kernel.org

> For the first use case, a dedicated API function, namely
> 'damon_is_running()' is provided, and all DAMON API callers are using the
> function for the use case.

Is damon_is_running() actually present in the codebase at this point?

The commit message states that damon_is_running() is provided and all API
callers are using it, but it appears this function does not exist in the
codebase at the time of this commit. It seems to only be introduced in the
subsequent patch "mm/damon/lru_sort: detect and use fresh enabled and
kdamond_pid values" as a backported dependency.

Furthermore, API callers like mm/damon/sysfs.c (via
damon_sysfs_ctx_running()) still directly check ctx->kdamond !=3D NULL under
kdamond_lock.

Could this description be inaccurate, perhaps due to patches being applied
out of order during a backport?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026051243-crevice-=
spool-75d8@gregkh?part=3D1
