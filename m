Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB75E48381D;
	Thu,  3 Sep 2026 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431732; cv=none; b=pAKeZn/tNnOcBmuStTG2Ufxlyj+M9Q0q9kG6ZCCvzlTqu8Y137FnRcLBtp0PtrTU/MTtLagYydz5rDBbFXEWm8MyhQusJYv3Xaa9k8x6cb5eBrC4hzSburpEQ3h3xOHcI8snb4TABgBnrMGRLzXuptc7xXwM2EgtMRycmBhlG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431732; c=relaxed/simple;
	bh=oupvZIQLRj2F8pwTGPPDeOgOmjETvsOL7Smn8U24vK4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xq3DFFytKhKFFt4QAAfwhNPnNTdOFi9iWdw6VwyyECqpuG6hX+D+AFC/xkRCmANa4yjf2CO1OSQ2gFCW/xvyRoHHuBAv818AQ794KHB2i9QVEIC2ylY5ihvNd24f3TGoHsTHhcjqzI7vvioU7Ac5VUmfCNJIoxUNDyoZdSKINAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hvl8VNPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hvl8VNPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06971F00A3D;
	Thu,  3 Sep 2026 10:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788431722;
	bh=oupvZIQLRj2F8pwTGPPDeOgOmjETvsOL7Smn8U24vK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hvl8VNPzvhooruZwipX6WzNUkFFm/74nfalux8huERIDwn31oavj0fOD2RPJntxJc
	 gDipr9gn95yhIILgLp8MYQM1fB0jKwMWAl8q/iu1ab+IhFJELc2TLY6qEw6iiKODGo
	 c6uLwt+wogqGTOWkxp0nUde21vklI29KvilJPZh90knTaHzTEqQtUJP42pddlwVqLD
	 KnSVvMeYHqRWbKaad4sV7+AJ4ekNqd1PKAQfrkw3u21et7bDNnyG2goL/ehRv0nc+D
	 k8wTfNJ5VCmwlSN7WilzGLnj716b5S5WBPosLIqBOpa1sAiFrfsQBUVJ9BzBB7FtAO
	 Y3vURHxFO5Sjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] mm: rename pointers to software PTE values as
 ptentp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, damon@lists.linux.dev, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903103002.1091859-3-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-3-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:35:21 +0000
Message-Id: <20260903103521.A06971F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Some interfaces use pte_t * for a software PTE value rather than for an
> entry stored in a PTE table. These pointers must remain pte_t * when
> pointers to PTE table storage are converted to hw_pte_t *.
>=20
> Rename these parameters in the install_pte callback,
> write_protect_page(), and guard_install_set_pte() to ptentp. The later
> Coccinelle conversion skips pointers named ptentp, allowing it to convert
> the remaining PTE table pointers without changing these interfaces.
>=20
> Some functions already use ptentp for such pointers, including:
> - madvise_folio_pte_batch()
> - folio_pte_batch_flags()
> No need to rename them.
>=20
> This patch only renames parameters and makes no functional change.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D2

