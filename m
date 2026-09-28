Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800945D91A
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585075; cv=none; b=YqytJIXvz7y+na28R26+xYwVfOfsOXe8ffJKTX62/+JMXP9P9pqN0IFbSRgbLWyCtZTpVIbEjsBnUekJ+GbnxrwNyJGIIfjCrfXh0YF4BJqnoi1IXC3DOMBNcN8RgHijvxlOKm+gU85mzdVNf0KyZPxphlPxdc9S6gK6bLcIu8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585075; c=relaxed/simple;
	bh=bh2OTFwbe7e13/+ELOuRm/KyvNhiYZiwwPdYqc8Z8j8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R0zriwEW7uh5tuSj6G59dG0gJ1dXfg0KaK+BknbKBB7f3mSHjPGKbrNPCFaHpS0GztIutqAeyfmuXbeK65uwd1DlN3LIeEy/W8BcglkbxmXtBnsOkbCvz4V6EwjdP5qkVjjUwPNOYSm6dscMVYyvW7nTsQ4O6o0TrsnaY3NC2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRnEip/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRnEip/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFD21F00898;
	Mon, 28 Sep 2026 08:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585074;
	bh=Wi1NLaLIe7K7khAbwncuU8qBJD0vmHPt9iRXNJNquxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gRnEip/zu3skZ76bzgc/39chz/Y3oVcoqBjGhvhxEAPOkZ+N+7Qq9CzSu/wSPkuU6
	 paPIMD8nbc6wmafhw9TlmozOiGpdjaXFQK1bLV38zDJ47myxeRiXfhb6bUhhJxhQ5P
	 evsdQAlZPAwoy89elZgBxw0K4O+l7QAc8VBdq4y365OrkHG/JnEamFI+Y9kPpbY9Uh
	 4Z4IaANzfGgySOhOaMVCLSnJ6Dh0ELz5PZFkfstq1pBiK94rrdkPIShl+dSG3peGMe
	 uWQnVQWG7wVL4AcXjAcegiGOVCLbEaNzpSOqsmW3VlW/SXnPJN/QjtEE2kk8K7W58X
	 hDQRbA5I7/RvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] mm/damon/api: remove unused NR_DAMOS_* enumerators
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260928083959.4030-2-sj@kernel.org>
References: <20260928083959.4030-1-sj@kernel.org>
 <20260928083959.4030-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:44:33 +0000
Message-Id: <20260928084433.EFFD21F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
>=20
> NR_DAMOS_ACTIONS, NR_DAMOS_QUOTA_GOAL_METRICS, and NR_DAMOS_WMARK_METRICS
> are not referenced by any code.  Remove them.
>=20
> They can be reintroduced if a real user comes up.
>=20
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928083959.4030=
-1-sj@kernel.org?part=3D1

