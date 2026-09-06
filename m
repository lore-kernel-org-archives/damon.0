Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96435E1BA
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728829; cv=none; b=aMTGLC2OYTm7opG+pCbnImdkKoMtDd45t4iyvD8tsk9xi9fjRfTfcjGEbbZRSWu7knOzgZXLwuAYXXwG0LcWoRcvTlvEm0W8U/dTrGJ12IGIAp6dPbqid98H5fDW1QEQwHEljC/uZwfKcDyeO2vrp1d5u8ptD0Nea7ysZJApHpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728829; c=relaxed/simple;
	bh=yx2NNJEQYCAWHxzevqY9+GwwZJGNNTc+S9cVJZfvHNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nCOywnmzNuEcEXQ1ARAiZw5BHf6lqYk1DOMCg+WzpGSFngF7vagVgok7g57hy9eXtSRdRs5JyVTb8Mmekvl8oVGakYnohKG2arlfi35DNZqFHasZHXA7foSCcCVCOmFVnh6Jr+9c08F0UqOqEHR/miqdWRM15U4s0RAO4GbAE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB2FEHps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB2FEHps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001681F00A3A;
	Sun,  6 Sep 2026 21:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788728828;
	bh=yx2NNJEQYCAWHxzevqY9+GwwZJGNNTc+S9cVJZfvHNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HB2FEHpsNviRl6hHqFrWcwEyc6ji2cIxdz8vIVpTyfh9vOS4Yb8HGrbclj31OSvTP
	 ecnTs8dF+OCBIld979mhaafYWAmtjZPX/3anA+6DmZRvCy2NJcVBCGzqWsPMHtTNlo
	 yDyeVtbw2h8yvxRFOBS0EJsyXmfXb0XY2dX9vqb3bBk3YLByarvBfL93FgJBlnZHO+
	 bRGCr6WoO2mUPafRLGXuuYoJ/qaigodQHxefhT/q64mHosTRNckqeJBMGpzBI/CPGt
	 6icR5p1VI0/kZ4+strqTJi6/D6PNK5XqAiGK6p+p+9vY0MmG9sjfWn7p4iwu9LjrwN
	 ybF8AwfGHdDEw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/6] Docs/mm/damon/design: update for
 probe_hits_wsum DAMOS core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260906210513.106895-6-sj@kernel.org>
References: <20260906210513.106895-1-sj@kernel.org>
 <20260906210513.106895-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 21:07:07 +0000
Message-Id: <20260906210708.001681F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906210513.1068=
95-1-sj@kernel.org?part=3D5

