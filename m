Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C463CC7D6
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 02:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438481; cv=none; b=H+rts6+xJwQV3jW1xEBNpdUIxeUbrI+aBuKPXlCSIC70ZJUmOX9M5q9V+wE37eicB67s+j1N9qLO1TKvYjAxq8jY81JYL0Z3ZX0S3dGFy6ECgC4QuwNAK9PNubKwJY2Tj0/leXZSsQz62P2tiILdR28swgjY6lf5LIcmKrFjJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438481; c=relaxed/simple;
	bh=DdwY3VxXB3AZiCNJx9PJkxFZIItve8zl2xi0PFEOtbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FBZv7DKO/MtxeccoG06vQg/9X8wKum8pQzeyTrMQuflvXdrrRPf2kPVmvOQ57e62NvIzTMxw15MP79/3NUCCZsmvcQlJBdWwImJdjFBagmi1C7VpH6Z27Sn7H3bS1o1MqGM20wJododAREoYpo5fvBpMN90PnJXkPxwDUhOxY+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/aNV/vo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/aNV/vo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537361F000FF;
	Tue, 15 Sep 2026 02:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438479;
	bh=HoBY+1d1BGIk5GkCF5GMSKZlDHck6aTqyIKeWTLMbv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C/aNV/vogC9Pnj33jOVm2jNwH/jNlTAmrds090CkC7RsadzyPJt3LgXJ/YUCzjsAN
	 vcpzHG3ZcKWIYrxY1qoB6GBeIUcF7dwAY5pTztzi3Ypw1qW8Ryo5r1hIUsFk1vp6iN
	 y/mLgA11I61AdRjFZPIh6Yd/faWbu8Ws9Sc5eGPvY8JvWd/zP25Y9lNCSWGmx/w9Y7
	 OWgl0A+Pg290qjD/ZF3zIjzKcUkPvl5gcdjY62HD55C63BMiP8FrdAnt67rxajWI0+
	 G9djMMdhP20G5pb+hAOHKbfHXZUhG0EBJHlnIPr9pFhWP7UtXt78qm0vrc6sSaD6p9
	 e+Vk8DDcmLT0Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 4/8] mm/damon/sysfs: add min,max files under
 probe filter directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915020929.102953-5-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
 <20260915020929.102953-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 02:14:38 +0000
Message-Id: <20260915021439.537361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> In future, DAMON sysfs interface will support data attribute probe
> filter types that have range arguments like the newly added
> hugepage_size type filter.  To prepare such supports, add two new DAMON
> sysfs files, min and max, under the probe filter directory.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915020929.1029=
53-1-sj@kernel.org?part=3D4

