Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C267445AE7
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089693; cv=none; b=S55cTjx59om6JCL+2wJCA869JPp8GV1gApNwDRM0j/7f4UFVAInSYhFsEXWNiSABzWcIGI+clBavCVr0B7fhkL8MQz6I8pCpUaGq5XZ7/ownSgPEcg6gNhqN57k2m+TmzPBLlVOvC9iv+YHibtdW+YBnn3zWEVIdLoc1XtFgKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089693; c=relaxed/simple;
	bh=DDXCltdJu8t4Qiu4TJ83uml+HNdSYySDUcy7O+n/CUA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BMYQ3lMhuxApOQqMnJUx/aD3wSh+t4a9g3hbWsJstbsj8qrIhRWd8E1Lz5vuos40g/FtzJAvh7l/tE/ErXrgwM39eKNFuyxzAIsghA5KvXmUbKM0cjquSsCI20tzIkYoVXm9jovbthyZjn3MqxncILpwotIiBstsIHGxkns7cmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHAu/Xwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHAu/Xwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6634E1F000C4;
	Thu, 15 Oct 2026 18:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792089689;
	bh=VKQRQNJYrbTG+/AhriggD7O3KGKe/QqmaVFtJkdBONI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AHAu/XwbQBNFfuMLj7h4YjBdVCQBO33/CWtDsJ6TeIbNmfSN7jr23WlSlPN53jQer
	 RK165/u+t1/OgaPNMUuOIZQBAOWmakiJFn27kFo6D5gkpto8wiMpfXUlnQi2R7P+Ds
	 JgWpwanUyrLqAk1nAHy0YcgUrRN7vn3kdrVOa1Tpe6loFiNxy88QvlXq8V/bKDzZxq
	 3FIuiw4NH8KrH1liJFl9Mb0AeG9TOZb7dzGi+0os34xDfE/KAoAOfYg5grDzF/zFAJ
	 Yhm4X/lpyncQfv3Y7T3kvUSaSREU3LpAjm2t5lyNpZ7/wINhGCwZoSF3LDvjCn6P3i
	 dccmRtn3yLYyQ==
Message-ID: <sashiko-outbox-173316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/17] mm/mglru: frequency guided workingset
 promotion (MGLRU-FG)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-4-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-4-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:41:28 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> Complement MGLRU's eviction-time tier-PID protection with access-time
> frequency-guided promotion.  Introduce a unified set of helpers built bas=
ed
> on referenced (access) count of a folio.
>=20
> Each access increments a folio's referenced count stored in folio flags
> (refs), refs still maps to a logarithmic tier just like before, but with
> more formal bit definitions, a few special thresholds are introduced:
> LRU_REFS_REFERENCED (1), LRU_REFS_WORKINGSET (2), LRU_REFS_PROTECTED (3),
> and LRU_REFS_MAX (7). When refs reaches a certain threshold, the folio is
> promoted proactively instead of waiting for the PID controller to kick in.
>=20
> Also simplify MGLRU's usage of PG_workingset and PG_referenced: they
> become the low two bits of the refs count, with the higher bits
> [ ... ]
> PG_workingset and PG_referenced are no longer independent flags under
> MGLRU.  Adjusting existing raw folio_test_*() callers to the new
> semantics is left as follow-ups.
>=20
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D4

