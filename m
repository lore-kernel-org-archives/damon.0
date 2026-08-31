Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BDA348C50
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200991; cv=none; b=RJkUR4zvSrv4Gg8FqfP0A/i/eqLoKufkNPO/lX5gtycYFsuPY+cHUF878bCxAZdODHszqFxw4nds2MPgMf/wm7pWRhLp+EEqf6iJRPWc+pU0zr4Me61VPTw9scetOrj4muzR3OCyijeDA8cqKisVov8OlTYwcovjV+Po04woVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200991; c=relaxed/simple;
	bh=3j2xsDDYzKXbT8dXQClSlLcCjebyF6NqX8t11/hP7JA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fwO36cvl8YdzgU7Nelzr/glPxoB1RptJ6crKFVWYJ1z+MuyOXs+lHDAB3HINt0bafskv3khLvc1kEX8YUFDtBge/tBspCKwk+GvU3h64HLy5rYAEAR7CPlue/AB3Y83yVXur8AoE2ryshK/vZrHfYRXg4dLccUiCRabis4ikmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMiHyk1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMiHyk1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B89E1F00A3D;
	Mon, 31 Aug 2026 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200990;
	bh=33eTWJcRuz3KD71oYF9bKb7uNkjbACRaTPK4bSeKvRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HMiHyk1PhprhlddNJwzPSmJGVfN7z9Fx3mXaA/J9+cW0UkghG8ovkqTICZernhOY0
	 /TXPOkMP6t7ryoAHFSHb1NxQ19ROoKFR74IA1VCDOgiBOUqOQcDGYENuhri0dFx62+
	 ja0YCPr9TA+/1hN6rI9be5+Lgbj4pzr7sChrnqoJ0qTxvU/S0DlZAl8o2iCU1xTxbE
	 J0IWNrB049cF+Tjh4K2txOAMGvDadK+MNNdLyBCY8TqBZmFonzNMLTvc8a9o8IsAZ7
	 M+f2kPmy08oAeZUeN50vldTD+YIEznLMSH75rmqzYAoBBluFHd5tT2/mjuWHe9915c
	 ntoxRkbRizB4g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 6/8] mm/damon/core: handle extreme memory state
 in damon_get_node_mem_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831140254.72004-7-sj@kernel.org>
References: <20260831140254.72004-1-sj@kernel.org>
 <20260831140254.72004-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:29:50 +0000
Message-Id: <20260831182950.8B89E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> In an extreme and unlikely situation, si_meminfo_node() might let the
> caller show zero total ram.  That could cause a divide by zero in
> damon_get_node_mem_bp().  It could also show free memory larger than the
> total memory.  This could cause underflow and make DAMOS temporarily
> make unexpected behavior.  Thanks to safety guards in the auto-tuning
> feedback loop, that should not be a real problem, though.  Fix the
> problems by respectively returning 100% and 0% for used and free memory
> queries in the corner cases.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260328133216.9697-1-sj@kernel.org
>=20
> Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics f=
or memory node utilization")
> Cc: <stable@vger.kernel.org> # 6.16.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831140254.7200=
4-1-sj@kernel.org?part=3D6

