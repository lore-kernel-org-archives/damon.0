Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5F2853F3
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881595; cv=none; b=Bqs5lb2MhfYbOMUce+iDYmkNhn8vgyll5G7vgv9GX5LxIJLlHznvJgrHZkQ8DAOwTpQdcfcHmRbz11/JT3vd8TQvgLltp4nB9jO2X3ECfu6ktWxFP90I0+ltOTAeTVlBIatTZ1OdBMtXBYGu+GTIrh6Ay4sebZdlyUxBFDT7MmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881595; c=relaxed/simple;
	bh=hEPIT2JmnHm/A3ElaZb9efm7WEDzO3pcp4nPMuQjk3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S9MCvsEVx20XR2aQagY8+jV3lsH4AkQHlL6ZGtij0pMqOJgnBEyVrbopWGWUS2jKluIj+Bd1RNYRCfqVAGx84ZjxYoCkLAh+rq6enfG+q3uW0oRH7INYR8vXgYDbMeSfp9QIsyGFLYPCQ3Wh21pB94YX83izUqdn3wVseGz5qTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXRpQj36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXRpQj36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945D01F000E9;
	Fri, 19 Jun 2026 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781881594;
	bh=hEPIT2JmnHm/A3ElaZb9efm7WEDzO3pcp4nPMuQjk3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LXRpQj3696281ww2y+niDNErHjPQKC7yBuO6rM2dxbPK69XsALGEEVRWchBJtf8F3
	 I9AFq4hT3CYDIsCRMYzFOYA+8/dZ5+nP1OqtqwY3wRxgQ2Er4Q+sh6tr9jYH1ruIa/
	 PQVWQ5KEtPRDg9ghFuFv5J2D9cxBMJIQL8RcRtAOVXuR8KJITgiC3nhq22GVS9JhOI
	 4kSkFQPP4KcFyfr2i3Nsk+/Jui3L6mRzIU93DGf5k7D9quoLuQYBl+Uiw2sYrsPaWg
	 JqnatKfy2YbHj6R55BhNhgb516Z+3DxHjQrbqPS+T5oKV74kpgAZrsXwV6Pnc5Ba4T
	 O2d84Rc2ctOsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] Docs/mm/damon/design: Document hugepage_mem_bp
 target metric
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260619145821.2109933-4-gutierrez.asier@huawei-partners.com>
References: <20260619145821.2109933-1-gutierrez.asier@huawei-partners.com>
 <20260619145821.2109933-4-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 15:06:34 +0000
Message-Id: <20260619150634.945D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message body contains a typo regarding the metric name, =
referring to it as `huge_mem_bp` instead of `hugepage_mem_bp`.
--

commit 2ffffa695a51c9a7abedd1fec09204d864318807
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Docs/mm/damon/design: Document hugepage_mem_bp target metric

This commit updates the DAMON design documentation to include the new
hugepage_mem_bp metric exposed by sysfs.

> Document huge_mem_bp metric exposed by sysfs.

[Severity: Low]
This isn't a bug, but there is a slight mismatch in the metric name here.
The patch subject and the actual documentation additions use hugepage_mem_b=
p,
while this line in the commit message body uses huge_mem_bp. Could the
commit message be updated to match the documented metric name?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619145821.2109=
933-1-gutierrez.asier@huawei-partners.com?part=3D3
