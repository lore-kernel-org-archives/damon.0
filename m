Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C3376BC2
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618158; cv=none; b=LpUQQR8jiFm12btWP/I6R4/3q18SQky3ZdXjKwsA4X66LAxuspEQk5WnB/fWXlrUarxJA1mYBIgIFH/pxmoVSk2KvcMubDt4ayTC2kG+mJbSgA/TM0Dn2A4Y39k7R3XLq9tzNVMl25C3/WMcxzRMAdd0IXTTYDqGs5Had17/hmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618158; c=relaxed/simple;
	bh=9vJ2SLRlod0P3gpbLKx7E7UkVajxEuc01QT5xyCmC34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o0eOr4NZiZLelfg5vFP9XdZjqHw1SIItwn7flS4Ba4PrN+W0YEXsWCG3mU15xdp2DCEvo7GPWA9t6Qb1o0BOd9a5zMMRnkherC2SowaRhFmDCtwaSweNU0iTbaADl3cTJ9MhGV0oy90cSF57D9L0AxcD5mwahq+5EiqQ+tAbjtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmvJU/UL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmvJU/UL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA84E1F00899;
	Thu, 17 Sep 2026 04:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618156;
	bh=PGeOMhKzbAPjWC/5Q8y2ICCQpGgDHUKXoVRIEQEZCLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EmvJU/UL3VEFcdL4d46OKjECowimt0sWKaLAhPiRB5BMoZNNcuauV7+5SKd8PlSho
	 g+HkEeqHcwzcWwTaRLisGR+eXC2m+Xt4/GoiiG6EPYsdRWqnFPZR+cxeebTPvUSQc8
	 k6fyB8PAaqz09kC7sjaSEmrRFtjwwRHN7cRsEllMQ98/E90Ybd0vao1NR0jmH7Yvi4
	 sIRt90rWr5aUSwdvhMcaPBsXzXZ1+GqGSOIaksbheJcXE9NGpDHhjt3OECtQgjeRHA
	 xD5kTcz+zqGT1DK0gyuRy8xP0nBLdBsfUh1KfFImV+sohzQ/Ocj6jEPY93c2yS+Nzf
	 8x/xR2QWp4Mkg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 02/10] mm/damon/core: use abs_diff() in
 damon_feed_loop_next_input()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917040537.107341-3-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
 <20260917040537.107341-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:09:16 +0000
Message-Id: <20260917040916.AA84E1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_feed_loop_next_input() is open-coding absolute diff calculation
> instead of the dedicated helper, abs_diff(), for no good reason.  Use
> the dedicated helper.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917040537.1073=
41-1-sj@kernel.org?part=3D2

