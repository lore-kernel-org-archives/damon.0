Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0F5576ED4
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884915; cv=none; b=LvHX31V0pjI11m8yjj68B4A1KSKRrRxBvX8+lpYHTMbh/oCXbeHIwf7ZJO1eA3WQrfT9QlWxG2hVwTOU4lueqL1tJTF/bGPCER6DRHsS+nEL5r1FdzwoJhaV1B1nx1NBNAcq2sfMm1zsWXeMstdzNjgFxvwxssCnHh7dE8pWX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884915; c=relaxed/simple;
	bh=/j8nDaDHyJ8yDIMk9Ca9qYI9JRa01I8yPeev9KAxdAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=thcJseZc+LvVyZXGMIt+7TlfrvuMpb/OiSV3oYrwbrnhePtQiJkz8PemF6WgOeF3ckt3s/8+PT08mcH50qRU2wxHBUvvl8pkq/IeWxcuLkJmRcwz3MTY2oqtS0WE/8ihaIhwLmd6NX1akd7wLyEehQ1JCxTlFomoannDj53mfLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrKCxiwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrKCxiwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8E51F00A3A;
	Tue,  8 Sep 2026 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788884913;
	bh=ROvFynrWcvpdb/VLe9DB8eTurYy7eEgaJWSrD+ZtLBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VrKCxiwO5ZxpDHPCGoZcWLv8ZpMLLYOBf70d0+Puhg6xrBg5uuCMg7SXpmz/fsAQO
	 LRd00aJeK3KAL51t8XNrEUeOVgE4qt9Cc43+wNs+0KEm8mqxhmjuvcnJAG64GhQn93
	 XcQDzOo2ZOGm9qXw9L8yMiY9rAygEbwbY0C7Nf8YG/ErgB9yDsCs6nAN3ERoTJDPpT
	 Vh/BI6Qa5lerxQ053v8IyySeLyFOAwJMMEPNo9YoJ4/KeYP7lgQ+woMkGB7D7Eue2t
	 MQ1NFUWedmKWAie5sLZk8CS0oWFwJ/DLkLZLVvWn5obvV0Yr3nuEmVvn2tfyJzqu98
	 3jZq6bN2bs5aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/damon: ignore test-generated
 damon_dump_output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zenghui Yu" <zenghui.yu@linux.dev>
Cc: damon@lists.linux.dev
In-Reply-To: <20260908162716.85648-1-zenghui.yu@linux.dev>
References: <20260908162716.85648-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 16:28:33 +0000
Message-Id: <20260908162833.9F8E51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
>=20
> sysfs.py and sysfs_no_op_commit_break.py dump the DAMON status collected
> via drgn_dump_damon_status.py into a damon_dump_output file in the working
> directory.  Ignore it so that running the tests in-tree does not pollute
> git status.
>=20
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908162716.8564=
8-1-zenghui.yu@linux.dev?part=3D1

