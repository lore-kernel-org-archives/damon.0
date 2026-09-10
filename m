Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A443C308F2A
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050297; cv=none; b=FmWVRhDizAqEngHFTshJFrWiFBxnmGbgaeplif3S6ZkbyLznDs01dnMZOsUrY1Qs9vun0yewoq4JHjLvAiz8iSr/O8AodNt2QDuC3r4e9occ5dxeWJm2Fjbve3aKnjTltnrE3Zbai/jNqY+J/7wPQ7rHve1iCF+VQi/avI/oU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050297; c=relaxed/simple;
	bh=Qq72opKDcUoOVeSoq1c0ZuxdBj/hP0Jl0q31v82+tDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kuHoT6fWYK6CYP2P3t7o1uD/e27y8/TRKNJH6zb2RKyLzpgDaq/4tS0dXsUwpnSCjFskCPSjplf+dUvp1zqNrJdPOCHU0PLPFqfs+zxD2TBbMTKdwfrtAgZYwX02ih932yUn5U0iUEiFVGYR70LuGLMHCwiB7oMGk2mUXWCqJEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMHIC+8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMHIC+8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016D51F000FF;
	Thu, 10 Sep 2026 14:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050296;
	bh=Qq72opKDcUoOVeSoq1c0ZuxdBj/hP0Jl0q31v82+tDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WMHIC+8WOHNX0S4X6bf+w7y8Blf7lVrijCU2VskBsScmZpF1AAtB54qxXDoT16fli
	 p/NujnBj+9gMuQctdrZWAYAT46F/nLF14GWt/8dszrbD/8lsxRstWpyljoA+gl6l81
	 Nt67DEJc2eJORTkQ9npVomLAlcm+2IdA6nQTUskMEhmx8ZhUUDoTEHNFONiK5sla6+
	 TR983A8+TjpbcXAlrQRGs8i5HQxyq4xyzT4jLzMbbkclvwmJMeCwktVMoLh0sgPSCa
	 MIuaKcvX+edGyKmApt5Fz+GKXbHygEtoNR1RtBcA9Z5RoEVgIJFhGuAL7bZlE2B9X/
	 yubYqaUv4ajLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] Docs/mm/damon/design: update for probe_hits_wsum
 DAMOS core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910141849.170896-7-sj@kernel.org>
References: <20260910141849.170896-1-sj@kernel.org>
 <20260910141849.170896-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:24:55 +0000
Message-Id: <20260910142456.016D51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added probe hits weighted sum
> based DAMOS core filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910141849.1708=
96-1-sj@kernel.org?part=3D6

