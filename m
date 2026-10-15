Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB9C331203
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089069; cv=none; b=fI4DAb94H4DNLO40ZiFJmL9ibB/Mk7TTxCY3EsMwoP67eQPOqXIdL8aUIvEn9i1XXGjqACwzizXgUwjtF7GpMNdTcKBtYUynM1o0+eHBYSa8kwM0ZRAoB4Mp8iHa6Hdgv3EeJ2LfdHBxVpPmtEnqJRFxiRCdLPqd4qPrhGZJIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089069; c=relaxed/simple;
	bh=BbVSyphbEwqPMwYwVS5OV2BwP3Gvb0re4cgvtpwoh4Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GN9DGb1xcClFG52R4I9PrWQb7GVBGCp/VRgnKt77v8NLRCBHk2fRIt26G6cUMxAx+qZv5bRG3Y/rqtR3mgZOVxGMsjdCus9G+LsbLiOeaA6iKlr3drV2DpJoHzwoelOADgO29R8BXYytCJQ4wEU5uE1PCKQg3YmL/JIFmbCNyhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXq0+yj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXq0+yj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F5E1F000C4;
	Thu, 15 Oct 2026 18:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792089065;
	bh=Sr1IdDJHYa3jHyjzF82ydN8KXhGnC/c50zNrlC6IgZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FXq0+yj9cHcOcMndjGK57kSSerf/EFeTtHBA3zJx5kfLJ+kgJRt/O5N4FTYyZ4GKK
	 WHNhHfOgTM276J5m7XU23DwPeWw4fLHH7cXNNgM/H4KWjp/PK0U8/hYtT7MHZw2a09
	 PDao8rI9uEK/2l2nIIbZ7a1NE99F/34PF4o8f5NsVoUQh+hWUs2pVetBv+ENyu8lie
	 FBz8sGdS13QuHATOZlT3BJKdoQOBMgNdewoNAiIet53da5DXi9pp60rtOJZXgG6wmo
	 mFXkF9vyzx3bUWQygydgJ+5bT6Uf077nAyELA3oy5zU2bawbhk4Ony9CNsks5AhNQH
	 GvIcHuyECjzaQ==
Message-ID: <sashiko-outbox-173300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/17] mm/memcg: add folio-based lruvec live helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-3-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-3-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:31:04 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> Add a helper that resolves a stable lruvec for a folio under RCU
> without taking the lruvec lock.  It takes a folio directly so the
> lruvec lookup happens inside the RCU read-side critical section,
> which a lruvec-based interface cannot guarantee.
>=20
> No functional change.
>=20
> Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D3

