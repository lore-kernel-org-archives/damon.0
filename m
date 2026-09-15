Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D464388382
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 02:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439051; cv=none; b=Sfqn45X1QWn+/dexa3x5uO94WbMI55/KTO1HinyZn07sqIgwQsbwJMy7fnIYszskymP9sShWMH471HA7c7/s147ulGnyJXA6ZxH7cGGUK+m7RUnbkqrn3fiBDubOeMgG+OWq10t3ZY1rkcfSxpt+i3DflBR3bS/Hbj1l8RVofdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439051; c=relaxed/simple;
	bh=qZuLqCRaSPDxMmtPtKFd7krdfFvYBAYifmdqZds49Cw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TJXk4h4ulf+CYkhVKXsewy2Mt34LGoTXT2OMzEvgcs7P+9IApvDgKSD6j1frJrZS9u/7du30C0jP2rvBhDxWUhQDoq0U1dRthnD8QXyGvCGkEC4GCkwce+D7DWubNHJjQZ1w8mnzk3Qtm9t2p/ERur6y493DuwB3+1s3jK6UtZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOc7oCyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOc7oCyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F2E1F000FF;
	Tue, 15 Sep 2026 02:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789439050;
	bh=01EpJvBli2BtZ7dChM1/OK7/Rj7zWM1xYeppfcNRCD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mOc7oCyKxFcS2lNaDTCec4diGEzPrwfLg+8jZwwSu1YDHkUMvBj+3IISjM7RIQJAW
	 vfHytmAbA6vaRJybZs8an8chQbXR2Uzo5oQmaIWdIRc6cG6eyxOcflmxFfIGtcmzva
	 pzj1KyGPCwYRiCD7C1Fzocw8XDUu0xxrtYOmVJP2PrgE4dTe/N+0VMpAEbazellsfg
	 7W+FiArNR8DdnTbu++v4kHyfIV+/EQKhlGyChHedMCuMgCwmdEKUYgLOTbPO3AwcA7
	 D/hy1lODT/8E/Ph7N9LYbOgZv0BIZg7V8+t3iY6mi/cLLnIjyXRfvQnatzqyEE1L6N
	 0UC3T0EGiMhvg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 8/8] Docs/ABI/damon: update for hugepage_size
 probe filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915020929.102953-9-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
 <20260915020929.102953-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 02:24:09 +0000
Message-Id: <20260915022409.C7F2E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> For the newly added hugepage_size data attribute probe filter, two new
> sysfs files are added for the size range.  Update DAMON ABI document for
> the new files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915020929.1029=
53-1-sj@kernel.org?part=3D8

