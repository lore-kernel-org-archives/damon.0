Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0E463B8F;
	Wed,  2 Sep 2026 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346872; cv=none; b=FG+YHm7jH4wPTGVpvb1y1OKm5zzrmilNVMtUqo8afMV0JxIKzKZcbRWebb53eXnkyRUF42nIYJiQNA9afTg/0agVI5OtgWulGiX7xXALvGUNolZlL28/Yl3BixRsagGwV9q6jPJ47g3cEaS9mb00dVo8CrGwranEEg1yHih2wU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346872; c=relaxed/simple;
	bh=0r8VloIYarJAi1NQV7cxZypLbsT2XUs9j8g7tDKkCEI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BqNugBm2Rlz70VBG4hj1zReZUUI4YBPSzrk9RwjTxEOL6MsDDxJh9bubspwBge+Lq0ulx+8LmRTTVovjX2HRA+9tqdSlSrZYezl1HJsGAs5MwYMSRD3JwZ30/QtjQ3DrWFtPfwcDMuiDYx5mpd1tIT2bkXRc2IdPnxj/WNg5aSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB2YQjLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB2YQjLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0051F000E9;
	Wed,  2 Sep 2026 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346870;
	bh=0r8VloIYarJAi1NQV7cxZypLbsT2XUs9j8g7tDKkCEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dB2YQjLIZPxCTxo19tdKzUmBR1VAdQ91IqdOgdWpZ1hQ1PJYlagRuw6J1v8h1YB4w
	 JgPxxkYqgj3pjWQ3E9m+S5sUtUS2NJxdNmf/9GESlVr7Ll1N7ia+JeUjG6jSbyfa5+
	 C4Bnd+ddJ9ZMCqeNdeRgKrhqa3FpwvoNmR+ADfvooz5+jpYvs/TJA3lo9W5KdMb/VQ
	 UJP4OK4nCYBc4hXt9Gv1BfiLyCN90pETeoyXzOzXq1LbPU3ORU1+WJvBl5EAJzrkcf
	 QIYOWA7GH91enRpIEKWqt65I1w74z9rIEpLGd51saoihkIEAndW7NM1bNDbjoq1Enr
	 3GrJ2TV85JUDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/11] mm/migrate: handle retries in
 migrate_folios_move()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org, dsterba@suse.cz, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>, "Chuck Lever" <cel@kernel.org>, damon@lists.linux.dev, linux-cxl@vger.kernel.org
In-Reply-To: <20260902-migrate-refactor-shivank-v1-2-9dcca87669c4@amd.com>
References: <20260902-migrate-refactor-shivank-v1-0-9dcca87669c4@amd.com>
 <20260902-migrate-refactor-shivank-v1-2-9dcca87669c4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:01:09 +0000
Message-Id: <20260902110110.5E0051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> After extracting the unmap phase, migrate_pages_batch() still drives the
> retry loop for the move phase and passes its retry bookkeeping to
> migrate_folios_move(). This splits the move phase across the two
> functions and requires several output parameters.
>=20
> Move the retry loop and its bookkeeping into migrate_folios_move().
> The function now takes the number of passes and reports failures through
> @nr_failed, matching migrate_folios_unmap().
>=20
> No functional change is intended.
>=20
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-migrate-re=
factor-shivank-v1-0-9dcca87669c4@amd.com?part=3D2

