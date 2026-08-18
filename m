Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8762A26AE5
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036941; cv=none; b=tfrxT9wDOqBBUrVu/1Jp4Qx0Y7/p997faZCUc2Jn98kyJe1MkMWkKB8Mkkn7EtgvxLSE9yUDpJViuEN2omZkRuFhwRfAyDPhFElGGWSZuXutEOJCMte/ULAZr+FYrFOP057CdZDAMRxSeWYwm31HIv8HIejHkDmfyPx9c3ahXdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036941; c=relaxed/simple;
	bh=bR+QP/I/IKLxOIzaeDz3VQfdahfVWaWHeFSU4MWqjOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ANr8NPSAA7pDdLjKOyoKSnKL3YbGID7pAo9orlZ4HI41Izj66+jUuFC8dYoUDCkI6YDBcncrayUfzZhqb0AhnCu+MgbUt+fG/IeLZoiSxAbm3tj8irpRcJRVFVcneM2/P2CyEDNkyQbvJATTHQxCN6ONx7weHnR9OQUwqiwct8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoBZUC60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoBZUC60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85A21F00A3A;
	Tue, 18 Aug 2026 07:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787036940;
	bh=bR+QP/I/IKLxOIzaeDz3VQfdahfVWaWHeFSU4MWqjOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CoBZUC60fKt5LONnHboeaRthS4WyDFSBbmWBz/sw9r9VH7QBq2okvADaJCbY0VewX
	 4sJOqkOF0qxvkcJTSToVRmK4Zzg+KJqCZuV36kbKs0H3t4dYXWY/Esd3+AR4NHqR4t
	 umVt99PwBrIRD7OPh4Sf9HkvYjIb0cI9AEZs7FZbqyu8QxFvVYtwK2Hdhvwt9PtbGr
	 /Xj+nL3DLh4HbkTk+dQ/Uhc9nzcudmCEYr2QevGylJdwhFKJu6plKFXNDEQv+IVn9m
	 JEgy3QwXt9JHmRZP7c1Ai/Aeh/yaJzDUb8qtuLzvBLbULd+Au5H+K4+Z479I/aj9nT
	 3ig76V+6Zf0BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/7] docs/zh_CN: update DAMON usage translation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doehyun Baek" <doehyunbaek@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260818070358.455768-6-doehyunbaek@gmail.com>
References: <20260818070358.455768-1-doehyunbaek@gmail.com>
 <20260818070358.455768-6-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 07:08:59 +0000
Message-Id: <20260818070859.C85A21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update the Chinese translation of .../admin-guide/mm/damon/usage.rst.
>=20
> Update the translation through commit c9380cdd949d
> ("Docs/{admin-guide,mm}/damon: fix DAMON documentation details").
>=20
> Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818070358.4557=
68-1-doehyunbaek@gmail.com?part=3D5

