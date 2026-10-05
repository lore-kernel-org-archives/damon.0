Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1313E3BD65D
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190403; cv=none; b=PE4PP0PM45cgh0f90BwnnOJAiP9nC8Bcex00+T3p37YXRj8ge+Wjdy4mqLdBkJQgCLej5hcgPtD2FwAYGmMLvWy3Qv6jaetrQSBvC+MeYGr2cV55C/VKSfhuXDdoUhDgVJx4SS8Wa+dvdSL++py1xXIhUirW94+TDIGNNi0xRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190403; c=relaxed/simple;
	bh=73e0GzCo6tU7Be9TmYg6VzR1qt0Xkf94+tBNd/Q7rAM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sl7ow+Jt+DYMCPKS5lMvde9PwvOdHUprW9Ikk5QHDV6bX/A3f8mxzFHb7Vjry3/c7HWUxymCQ0/quvzaRj75p5HWlt200NiVN8Nyiq0jMreyUiAukDomCeFj16mTHvb3NmOa8bIJRoydGIcwXTH6Ym5boMlOmOdNztAEJCMsTHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV5Spktu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV5Spktu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E5C1F000FF;
	Mon,  5 Oct 2026 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791190401;
	bh=FJP7kEK8LyND5+M8FG3WSfzBgSlxPDbimt7LRGZH+AM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lV5Spktu0M/XjuPkxxC1Ws81x+Wji4KyoNzf0WOrArFYltCm7CGCaZ0wflyiVVG5g
	 E25P9HOJTbMoiGFLuga2cETk7tEydPZQvspltZwfTuzsG+TcQOhJppWg5FbyfSci5B
	 Yeb6wmiPZ42Ki5R3yvP+gElMxFT0XmdGtnMPY9Jdwk7CMRnMAW0/Hw09qIe20iYOuP
	 wPhKcR92UzUFKk86qWkKYCAROSSx/fINGaQ3Vqeq205vvVYMsm2i7xkkJOu2l2khtn
	 XMS4vt0mYjKRPn/V6ej19Ei8S6i0DoGcWY7tx+QAUHhUTqVvFGEHuzlpvqWAS+97xI
	 X99j0OarP03bw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 1/9] mm/damon/paddr: remove page_fault access
 check primitive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-1-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
 <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-1-b03452e137f3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:53:21 +0000
Message-Id: <20261005085321.C6E5C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The page_fault access check primitive reports faults through
> damon_report_page_fault() into the global, mutex-protected
> damon_access_reports[] buffer.  A later patch in this series replaces that
> buffer with per-context rings fed only by perf-event probes, which leaves
> the page-fault producer with nowhere to report.  Remove the producer here
> so no report is silently dropped.
>=20
> Remove damon_pa_prepare_access_checks_faults() and its supporting
> damon_pa_change_protection()/damon_pa_change_protection_one() helpers,
> and the page_fault dispatch in damon_pa_prepare_access_checks().  Remove
> damon_report_page_fault() and its sole caller, do_damon_page(), along
> with the two page-fault-handler dispatch sites in mm/memory.c that
> selected it over the ordinary NUMA-hinting fault path.
>=20
> Writing Y to the sysfs page_fault file now returns -EOPNOTSUPP, and core
> validation rejects a context with page_fault set, so a configuration
> cannot select a primitive that no longer reports and have every region
> read as cold.  With page_fault gone, page_table is the only access check
> primitive left, so a context must enable it.  This leaves MM_CP_DAMON
> with no user that sets it; its check in mm/mprotect.c is left for a
> separate cleanup.
>=20
> Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-damon-perf=
-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com?part=3D1

