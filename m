Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C544239A;
	Thu,  3 Sep 2026 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432047; cv=none; b=s2TwEGJveVa0OAMt/vDt3boMKEod9qJt/h6rmJg6WBClWjHH0MFqvEC46qxkO2jOeeSIRNXP+ZwS7mkzn+nsaKQY0l5PmMwr+wwtpK44xfvu/7/wsdclpNDlP9gqHv9aHmMSVvFTtkhBecMJIYMi2d0IDWvl0GKHfL4+KEc6v7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432047; c=relaxed/simple;
	bh=rFP8MZSPreuyFV+kIBVC97RoRv+t3a0YVteWnIuDHZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EcPadTNV3Zb4gGcgwQkN60pvMZcN64cowpwEWjcpcak1L1IFQtIW6iTnisgrc1OOTlj7WolVhUQI6RRu7MU2A/+2zl/bi60f8Q5TkfqzGYvowsmfsB2cof2INNacDcOoU4x6qBueEGC8jSp0Hl8UW+x9+gltww521p88xEgd4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1ccCcYu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1ccCcYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF641F000E9;
	Thu,  3 Sep 2026 10:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788432045;
	bh=rFP8MZSPreuyFV+kIBVC97RoRv+t3a0YVteWnIuDHZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O1ccCcYuZPfpTRf2+GXrYxW8aySXe0VfKpmKvIjc9gYA8CpeWvWzonEhSRwBr6JR6
	 wlVeAbDwLa50zO/EQ+Ad/mRBGvNBSZK+DQ8u673b6gdowNlcAhEkLoT1zxapl1KQLg
	 M+1H0283l/1yp2Mw89E4AUgD5POg9KajQmYEsmnCnfqkXfo6NtFumYXgAZgkARTaGP
	 iuWtrjn6Wqbjysh7G8nHkkyR2IWoUw0R7B4lVc7AC2AoHRCFnS2pDj+cYRyOLgNyT9
	 01w1VjdCp3iMLqX9Y2JVglTwJUSGKWDIz8GNDW7rT70dvQSNgErQEddUuZXzIM7m72
	 y+o9UhvK74H+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] mm: convert PTE table entry to pte
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: damon@lists.linux.dev, bpf@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903103002.1091859-6-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-6-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:40:45 +0000
Message-Id: <20260903104045.8BF641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The non-MMU stub receives hw_pte_t but returns a software PTE value. It
> has no attached PTE that requires ptep_get(), so convert only the stored
> entry through __pte_from_hw().
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D5

