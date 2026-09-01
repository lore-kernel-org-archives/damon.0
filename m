Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E22415B6B
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269403; cv=none; b=gAN/fB0KrII0GbLcfrDRxnyseTnBFsiHRYU+L8e3hXmIZQaqQ0arTrzwlAJja4Jl81C9lfj4Qeo4pIiETVlNThga9ekejwZJ7BMvQlm0veS7VHlMpvBC+6o4o3dds0MtJpyuuhVrdR/z1TX3j78kYmFp1YYa4jYTvkHZrIPckwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269403; c=relaxed/simple;
	bh=j9tdfndPqOVhkgLPb4PiZDma0pzpb516GCUPriio/gg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e4gUGcX7zMwFzlzjZ2zl5X67nf8YnppXHJBspPUY3Ypxqj4Ou3rM6Yx1uoYpM3MiROu+LC+4m3q/KSa8PZAt8AJPdhmybsn9/xyNedpOYtPjDles69uhilVmGeeMBo4Rpe1vga18KaDgZznRqV756FXg6lQ8kkw60eCK4BCCs6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsIAALtc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsIAALtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430DF1F000E9;
	Tue,  1 Sep 2026 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269401;
	bh=zkTx8t3XxXUxdvGRhl/8HZYyZgbVO/w8gg+U79HN1og=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OsIAALtc6zqgX31GcIBQHK0U3cp5bEHyXX87PsdSckehYnM3U+n9zeUhhEc/hHoPO
	 nMUiet4+PMMjaSxw4a39vnn2SlzwZY92pwGIoanh9z9t0kyKz3IJ1lKP6baroTQv/j
	 OaZE4CVD6CUMObjEFIbbG6TwNvlpDGO4DF9NFxrufZMZmegqXLnowFngJHCJ6+O7Nx
	 ubpPB7D2ZUwsUVafirebE8WIztjNuwMxKDj9Rpd6X2aJzPtDyCA6h6XKtUJgRvcXCS
	 4QQ932tW6yb8RLkuMw0Hh+uSRcGUheyBC0sAy+ezl0DRMsIGO0sFmXbxdNz3Dt+lA7
	 jX+twPR8MzwOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 07/17] mm/damon/core: introduce
 damon_operations->prep_probes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-8-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:30:00 +0000
Message-Id: <20260901133001.430DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_prep needs to be executed by the underlying DAMON operation set.
> Extend the operation set callback list for the execution of damon_prep
> actions.  If the underlying operation set implements the callback, DAMON
> core executes it in the monitoring preparation time.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D7

