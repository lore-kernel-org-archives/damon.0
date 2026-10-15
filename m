Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332B3EE1EE
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089143; cv=none; b=II+4UpexSiCXIUfSqgxBG3COwocTQWim7cWZrbZrX297x4s7+e0tl4nioToRoYnFLV/02YHdtLsRWtMtC2b9oeDZ/6aIF6gEIhOukt7sPCmz3G0ra3fHW99Eb2ARlRPATApo7eKKfzMHSJop21LNr62HJBHVwpOZaRZMUllU+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089143; c=relaxed/simple;
	bh=m8Zajuz+bav7lhG/FCEjHdzjLqxBjMv4c3xc2c6ggm0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OIPhnp1fX2DE6+o0MK8xH/GyhuGZOu66WfmSJ7qAiK2l+uNPO2ehewGOqiwqCtUvjWMjJ4o7npE8GmNwabf8AIpuvdiN5G15C/apfeM75Y8AtKSfq+uoEbzA5CJHz0iXilDjPIJdfW7W1JbqVy0848a+9o8/omkawSaZ3xDR9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6NAAjan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6NAAjan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6591F000C4;
	Thu, 15 Oct 2026 18:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792089141;
	bh=m8Zajuz+bav7lhG/FCEjHdzjLqxBjMv4c3xc2c6ggm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m6NAAjanGmuxqgUkXwHAGOgYv+7RvEXlOYvu70sJcodLuiDDgYu9Buj2CUt+pcRHu
	 d2+yDXR3rceudD7d0DNBD3G3V8c1L8K0A2flVp43uhgyOOzDzMLy93sfNIE2/6ns3E
	 Pa/qtaGwkq/LAK0mx6TTGNilEdXhsaRJrpAx/hA/UN84WFX8EbbVPPVI1lN3zgUD4S
	 vg3HD2icUE5uoG1PKhge0aqyawIr+E6aiJZpe9QtfiMxQe7Wz85DhMftfFLDNRlKkM
	 hX4SC8cx0DAMIR4QjBy5pytdi+teDV5ctiFwYdjVMB6jQu6rtk/L7KjME+BK6HDuqA
	 sYFJwNfK/kf5g==
Message-ID: <sashiko-outbox-173303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/17] mm/memcontrol: allow update of LRU statistic
 without holding LRU lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-1-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-1-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:32:20 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> To enable moving file pages in folio_mark_accessed directly and lazily
> for MGLRU, allow updating the LRU statistic atomically without holding a
> lock. It may cause temporary counter underflow, which should be fine as
> we still follow final consistency of the counter, and it only serves as
> a estimated metrics, a little inaccuracy has no visible effect.
>=20
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D1

