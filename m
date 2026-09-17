Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719EE58F074
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655217; cv=none; b=s/q4gqE+3ERtVMarm89neNiPjAYc7Cak2xymqqTe8UXscS/y+W7vp+b7QRWRbTS/W2oYoc5DdXTDz7+uVCV522IHLpRtQ5/C+7/DyD4TkqpV9ffHBQWhPMdTD6ZQS2WpMm37OoS9Q0cMOWJempdFGJ/BrjE1/7qYDwkNIzHLLhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655217; c=relaxed/simple;
	bh=/UlAincZJgrOb3yJKeWHjSkNw31WEvP4XhR2O+mZfwc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QVQPIIMxYfLQC+Lzr/QWubsZkvugam6nxuBjAcfONk/FbdCITac10AM/0GlHyeP7QNFpspxo/SeWChX3HfzbuyfNinLXC4+SFEqhwAJ8zp+hwZy5sxUAJMOpTlxECoBJuXpTZJi5ltup3FBdrM+xt09RW48MRRr+PBpf923KiOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkLbq7um; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkLbq7um"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B641F000FF;
	Thu, 17 Sep 2026 14:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655216;
	bh=5JwuuIBrfMYi+Ma9jNd6d234YJyIeH1nHxQmYYVO6sc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PkLbq7umDEourKr/gCxfmbbGCMgnsXEbOKJWo66YneBt8q3ANcasZ3EjmgoxZeb5t
	 hWrfW8p57gTfPvp6A3++VT63u34tqLwDbT3GfzVpQ9PklIO3V5vpR09vq1BWhVenaD
	 iUUoN3YmBOg9nxtrwIqKTNsUxxa2N2opXEXVzYO4HPA3aXSSdcEEVWWVDkO0xtAjUx
	 F546wCzaBmg3z38B8tGOFw2iOJnwAkM12OQPUhXLj7UUlVbaoQ5lvtMIaI4KzlUNZw
	 pW8orOM013e+pxYkKIDh2vbhAyXLnf8WrFTi+LAZWHsYmzjhrI1EKEkjIoL7BaalVI
	 VraSE8/25xPZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] mm/damon/tests/core-kunit: add probe_hits_wsum
 damos filter commit test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917142210.90829-9-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:26:55 +0000
Message-Id: <20260917142655.D1B641F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMOS filter commit kunit test lacks test cases for probe_hits_wsum
> filter type.  Add test cases for probe_hits_wsum type DAMOS filter
> commit.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917142210.9082=
9-1-sj@kernel.org?part=3D8

